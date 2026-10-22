import Foundation
import MLX
import MLXNN

/// Lossless Q2_0 tiles: original 2-bit codes and FP16 scales, reordered so a
/// SIMD group reads adjacent output columns. Inspired by Splash 1482f6b's
/// quant planes and grouped expert tiles (Apache-2.0; see Licenses/).
/// No widened weights or additional cache bytes. A staging batch temporarily
/// owns both layouts, bounded by ExpertStore.defaultLoadBatch.
package enum Q2PackedExperts {
    package static let enabled: Bool = {
        // MSL 4 BF16 × FP16 tensor operands require OS 26.1 (MSL spec,
        // Table 7.3). macOS 26.0 retains the existing raw-kernel path too.
        if #available(macOS 26.1, *) { return true }
        return false
    }()

    package static func repack(_ raw: MLXArray, rows: Int, columns: Int) -> MLXArray {
        precondition(rows.isMultiple(of: 32) && columns.isMultiple(of: 64))
        let records = raw.size / (rows * columns / 64 * 18)
        return pack([contiguous(raw)], template: [("N", rows), ("K", columns)],
            grid: (rows * columns / 64, records, 1), threadGroup: (256, 1, 1),
            outputShapes: [raw.shape], outputDTypes: [.uint8])[0]
    }

    /// Demand reads already own a bounded per-worker scratch buffer. Transpose
    /// its code words directly into a joined, pinned slot to avoid a separate
    /// GPU submission and scatter for every layer's small set of misses.
    package static func repackCPU(_ raw: UnsafeRawPointer, into output: UnsafeMutableRawPointer,
                                  rows: Int, columns: Int) {
        precondition(rows.isMultiple(of: 32) && columns.isMultiple(of: 64))
        let blocks = columns / 64
        for tile in 0..<(rows / 32) {
            for block in 0..<blocks {
                let codes = (tile * blocks * 2 + block * 2) * 32 * 8
                let scales = rows * columns / 4 + (tile * blocks + block) * 32 * 2
                for lane in 0..<32 {
                    let source = ((tile * 32 + lane) * blocks + block) * 18
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source + 2, as: UInt64.self),
                        toByteOffset: codes + lane * 8, as: UInt64.self)
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source + 10, as: UInt64.self),
                        toByteOffset: codes + 256 + lane * 8, as: UInt64.self)
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source, as: UInt16.self),
                        toByteOffset: scales + lane * 2, as: UInt16.self)
                }
            }
        }
    }

    /// CPU routing is already required to stream absent experts. Group those
    /// known routes once; padding never changes route weights or logical rows.
    package static func apply(_ x: MLXArray, weights: [MLXArray], ids: [Int32], repeatInput: Int,
                      hidden: Int, intermediate: Int) -> MLXArray {
        // Q2's admitted prefill is 512 rows, with at most ten routes per row.
        precondition(!ids.isEmpty && ids.count <= PackMemoryProfile.q2.maximumPrefill * 10 && repeatInput > 0)
        var byExpert: [Int32: [Int32]] = [:], keys: [Int32] = []
        for (row, expert) in ids.enumerated() {
            if byExpert[expert] == nil { keys.append(expert); byExpert[expert] = [] }
            byExpert[expert]!.append(Int32(row))
        }
        var order: [Int32] = [], experts: [Int32] = []
        var inverse = [Int32](repeating: 0, count: ids.count)
        for expert in keys {
            let rows = byExpert[expert]!
            for start in stride(from: 0, to: rows.count, by: 8) {
                let tile = Array(rows[start..<min(start + 8, rows.count)])
                for row in tile { inverse[Int(row)] = Int32(order.count); order.append(row) }
                order.append(contentsOf: repeatElement(tile.last!, count: 8 - tile.count))
                experts.append(expert)
            }
        }
        let slots = MLXArray(experts)
        let grouped = take(x.reshaped([-1, hidden]), MLXArray(order.map { $0 / Int32(repeatInput) }), axis: 0)
        func project(_ input: MLXArray, _ w: MLXArray, up: MLXArray? = nil, rows: Int, columns: Int) -> MLXArray {
            matrix([contiguous(input), contiguous(w), slots, contiguous(up ?? w)],
                template: [("T", x.dtype), ("IN", columns), ("OUT", rows), ("FUSED", up != nil)],
                grid: (((rows + 63) / 64) * 64, experts.count, 1), threadGroup: (64, 1, 1),
                outputShapes: [[experts.count * 8, rows]], outputDTypes: [x.dtype])[0]
        }
        let activated = project(grouped, weights[0], up: weights[1], rows: intermediate, columns: hidden)
        let down = project(activated, weights[2], rows: hidden, columns: intermediate)
        return take(down, MLXArray(inverse), axis: 0)
    }

    private static let pack = MLXFast.metalKernel(name: "slotstream_q2_expert_repack",
        inputNames: ["raw"], outputNames: ["packed"], source: """
        uint i=thread_position_in_grid.x, expert=thread_position_in_grid.y;
        if (i>=N*K/64) return;
        uint row=i/(K/64), block=i%(K/64);
        size_t base=size_t(expert)*N*K/64*18;
        size_t source=base+size_t(i)*18;
        for(uint part=0;part<2;++part) {
            size_t to=base+((size_t(row/32)*(K/32)+2*block+part)*32+row%32)*8;
            for(uint b=0;b<8;++b) packed[to+b]=raw[source+2+part*8+b];
        }
        size_t scale=base+N*K/4+((size_t(row/32)*(K/64)+block)*32+row%32)*2;
        packed[scale]=raw[source]; packed[scale+1]=raw[source+1];
        """)

    private static let matrix = MLXFast.metalKernel(name: "slotstream_q2_grouped_mpp",
        inputNames: ["x", "w", "slots", "up"], outputNames: ["y"], source: """
        using namespace mpp::tensor_ops;
        uint lane=thread_index_in_simdgroup, sg=simdgroup_index_in_threadgroup;
        uint tile=threadgroup_position_in_grid.y;
        uint row0=threadgroup_position_in_grid.x*64+sg*32;
        threadgroup half stage[2*2*32*32];
        threadgroup half* ws=stage+sg*2*32*32;
        // MPP's tensor type requires a non-const element even for a read-only operand.
        auto a=tensor(const_cast<device T*>(x)+size_t(tile)*8*IN,
            dextents<int,2>{IN,8},array<int,2>{1,IN});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b(ws,
            dextents<int,2>{32,32},array<int,2>{1,32});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b1(ws+32*32,
            dextents<int,2>{32,32},array<int,2>{1,32});
        constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,
            matmul2d_descriptor::mode::multiply_accumulate);
        matmul2d<desc,execution_simdgroups<1>> op;
        auto as=a.template slice<32,8>(0,0); auto bs=b.template slice<32,32>(0,0);
        auto bs1=b1.template slice<32,32>(0,0);
        auto acc=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
        auto gateValues=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
        // Keep both projections and their activation in one dispatch. Each
        // projection rounds to BF16, then the product rounds only once.
        for(uint pass=0;pass<(FUSED?2:1);++pass) {
        const device uchar* weights=(pass==0?w:up)+size_t(slots[tile])*OUT*IN/64*18;
        for(ushort i=0;i<acc.get_capacity();++i) acc[i]=0;
        uint row=row0+lane;
        const device uint2* codes=reinterpret_cast<const device uint2*>(weights+
            (size_t(row/32)*(IN/32)*32+row%32)*8);
        const device half* scales=reinterpret_cast<const device half*>(weights+OUT*IN/4+
            (size_t(row/32)*(IN/64)*32+row%32)*2);
        uint2 q=row<OUT ? codes[0] : uint2(0);
        half d=row<OUT ? scales[0] : half(0);
        for(uint k0=0;k0<IN;k0+=32) {
            uint g=k0/32;
            for(uint j=0;j<32;++j)
                ws[(g%2)*32*32+lane*32+j]=half(float(int((q[j/16]>>(2*(j%16)))&3)-1)*float(d));
            simdgroup_barrier(mem_flags::mem_threadgroup);
            // Two tiles let the next compressed load overlap this multiply,
            // without overwriting the tile currently consumed by MPP.
            if(k0+32<IN && row<OUT) {
                q=codes[(g+1)*32];
                if(g%2) d=scales[((g+1)/2)*32];
            }
            auto at=a.template slice<32,8>(k0,0);
            if(g%2) op.run(at,bs1,acc); else op.run(at,bs,acc);
        }
        for(ushort i=0;i<acc.get_capacity();++i) {
            if(!acc.is_valid_element(i)) continue;
            auto ij=acc.get_multidimensional_index(i);
            uint row=row0+ij[0];
            if constexpr(FUSED) {
                if(pass==0) gateValues[i]=float(bfloat(acc[i]));
                else if(row<OUT) {
                    float g=gateValues[i];
                    y[(size_t(tile)*8+ij[1])*OUT+row]=T(
                        (g/(1.0f+fast::exp2(-1.44269504089f*g)))*float(bfloat(acc[i])));
                }
            } else if(row<OUT) y[(size_t(tile)*8+ij[1])*OUT+row]=T(acc[i]);
        }
        }
        """, header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n")
}
