import Foundation
import MLX

/// Prototype of the pinned upstream shared expert's column/M8 arithmetic.
/// Plans supply actual input extents; no padded device rows may be read.
/// Adapted from Splash 1482f6b gguf_column_tile.h and moe_gguf.metal.
package enum NativeSharedExpertTiles {
    private static let lock = NSLock()
    private static var references: [Q2GGUFFormat: MLXFast.MLXFastKernel] = [:]
    /// Unfused diagnostic path for independent original-byte checks and the
    /// fused schedule test. It uses no prepared-program cache or shared state.
    package static func projection(_ input: MLXArray, weight: Q2ResidentWeights,
        outputType: DType = .bfloat16) -> MLXArray {
        let count = input.size / weight.columns
        precondition((1...8).contains(count) && input.dtype == .bfloat16)
        let kernel = lock.withLock {
            if let existing = references[weight.format] { return existing }
            let decoder = Q2ResidentWeights.decoder(weight.format)!
            let kernel = MLXFast.metalKernel(name: "slotstream_shared_reference_\(weight.format.rawValue)",
                inputNames: ["x", "w", "u"], outputNames: ["y"], source: source,
                header: header + "\ntypedef \(decoder) FG;typedef \(decoder) FU;\n")
            references[weight.format] = kernel
            return kernel
        }
        return kernel([contiguous(input.reshaped([count, weight.columns])), weight.bytes, weight.bytes],
            template: [("IN", weight.columns), ("OUT", weight.rows), ("COUNT", count),
                ("P1", weight.plane1), ("META", weight.meta), ("UP1", weight.plane1),
                ("UMETA", weight.meta), ("FUSED", false), ("Y", outputType)],
            grid: (weight.rows, 1, 1), threadGroup: (64, 1, 1),
            outputShapes: [[count, weight.rows]], outputDTypes: [outputType])[0]
    }
    package static let header = "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n"
        + Q2ResidentKernelSources.header + #"""
    template<class F, ushort Rows>
    inline void native_shared_columns(device const bfloat* x, uint count, uint K,
        device const uchar* w, uint p1, uint meta, uint column,
        threadgroup half2* table, thread float (&sums)[Rows]) {
        uint groups=K/32, units=groups/F::MetaGroups;
        device uchar* p0=const_cast<device uchar*>(w)+(size_t(column/64)*groups*64+column%64)*F::P0;
        device uchar* p=const_cast<device uchar*>(w)+p1+(size_t(column/64)*groups*64+column%64)*F::P1;
        device uchar* m=const_cast<device uchar*>(w)+meta+(size_t(column/64)*units*64+column%64)*F::MetaBytes;
        for(ushort r=0;r<Rows;++r)sums[r]=0;
        auto payload=F::load(p0,p);auto hdr=F::loadMeta(m);
        for(uint g=0;g<groups;++g){
            half4 values[8];
            dequant32_chunks<F>(payload,hdr,g%F::MetaGroups,table,
                [&](ushort c,half4 lo,half4 hi) __attribute__((always_inline)) {values[c]=lo;values[c+4]=hi;});
            if(g+1<groups){
                payload=F::load(p0+size_t(g+1)*64*F::P0,p+size_t(g+1)*64*F::P1);
                if((g+1)/F::MetaGroups!=g/F::MetaGroups)hdr=F::loadMeta(m+size_t((g+1)/F::MetaGroups)*64*F::MetaBytes);
            }
            #pragma unroll
            for(ushort r=0;r<Rows;++r){
                if(r>=count)break;
                device const uint4* xr=reinterpret_cast<device const uint4*>(x+size_t(r)*K+g*32);
                float sum=0;
                #pragma unroll
                for(ushort j=0;j<8;++j){
                    uint4 bits=xr[j/2];float4 xv=float4(as_type<bfloat4>(j%2?bits.zw:bits.xy)),wv=float4(values[j]);
                    sum=sum+wv.x*xv.x;sum=sum+wv.y*xv.y;sum=sum+wv.z*xv.z;sum=sum+wv.w*xv.w;
                }
                sums[r]+=sum;
            }
        }
    }
    template<class F,class Tensor,class Acc>
    inline void native_shared_staged(Tensor a,device const uchar* w,uint K,uint p1,uint meta,uint column,
        threadgroup half* stage,threadgroup half2* table,thread Acc& acc){
        using namespace mpp::tensor_ops;
        uint lane=column%32,groups=K/32,units=groups/F::MetaGroups;
        device uchar* p0=const_cast<device uchar*>(w)+(size_t(column/64)*groups*64+column%64)*F::P0;
        device uchar* p=const_cast<device uchar*>(w)+p1+(size_t(column/64)*groups*64+column%64)*F::P1;
        device uchar* m=const_cast<device uchar*>(w)+meta+(size_t(column/64)*units*64+column%64)*F::MetaBytes;
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b(stage,dextents<int,2>{32,32},array<int,2>{1,32});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b1(stage+32*32,dextents<int,2>{32,32},array<int,2>{1,32});
        constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,matmul2d_descriptor::mode::multiply_accumulate);
        matmul2d<desc,execution_simdgroups<1>> op;
        auto bs=b.template slice<32,32>(0,0),bs1=b1.template slice<32,32>(0,0);
        auto payload=F::load(p0,p);auto hdr=F::loadMeta(m);
        for(uint g=0;g<groups;++g){
            dequant32<F>(payload,hdr,g%F::MetaGroups,table,stage+(g%2)*32*32+lane*32);
            simdgroup_barrier(mem_flags::mem_threadgroup);
            if(g+1<groups){
                payload=F::load(p0+size_t(g+1)*64*F::P0,p+size_t(g+1)*64*F::P1);
                if((g+1)/F::MetaGroups!=g/F::MetaGroups)hdr=F::loadMeta(m+size_t((g+1)/F::MetaGroups)*64*F::MetaBytes);
            }
            auto at=a.template slice<32,8>(g*32,0);
            if(g%2)op.run(at,bs1,acc);else op.run(at,bs,acc);
        }
        simdgroup_barrier(mem_flags::mem_threadgroup);
    }
    """#
    package static let source = #"""
    using namespace mpp::tensor_ops;
    uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup,tid=thread_index_in_threadgroup;
    uint origin=threadgroup_position_in_grid.x*(FUSED?32:64)+(FUSED?0:sg*32),column=origin+lane;
    threadgroup half stages[2*2*32*32];threadgroup half2 tables[2*256];
    bool any=quant_pair_entries<FG>(tables,tid,64);
    if constexpr(FUSED)any=quant_pair_entries<FU>(tables+256,tid,64)||any;
    if(any)threadgroup_barrier(mem_flags::mem_threadgroup);
    threadgroup half2* table=tables+(FUSED&&sg==1?256:0);
    threadgroup half* stage=stages+sg*2*32*32;
    threadgroup bfloat* gate=reinterpret_cast<threadgroup bfloat*>(stages);
    if constexpr(COUNT<=2){
        float sums[2];
        if constexpr(FUSED){
            if(sg==1)native_shared_columns<FU,2>(x,COUNT,IN,u,UP1,UMETA,column,table,sums);
            else native_shared_columns<FG,2>(x,COUNT,IN,w,P1,META,column,table,sums);
        }else native_shared_columns<FG,2>(x,COUNT,IN,w,P1,META,column,table,sums);
        if constexpr(FUSED){
            if(sg==0)for(uint r=0;r<COUNT;++r)gate[r*32+lane]=bfloat(sums[r]);
            threadgroup_barrier(mem_flags::mem_threadgroup);
            if(sg==1)for(uint r=0;r<COUNT;++r){float g=float(gate[r*32+lane]);
                y[r*OUT+column]=Y(float(bfloat(sums[r]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));}
        }else for(uint r=0;r<COUNT;++r)y[r*OUT+column]=Y(sums[r]);
        return;
    }
    auto a=tensor(const_cast<device bfloat*>(x),dextents<int,2>{IN,COUNT},array<int,2>{1,IN});
    tensor<threadgroup half,dextents<int,2>,tensor_inline> b(stage,dextents<int,2>{32,32},array<int,2>{1,32});
    constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,matmul2d_descriptor::mode::multiply_accumulate);
    matmul2d<desc,execution_simdgroups<1>> op;
    auto as=a.template slice<32,8>(0,0);auto bs=b.template slice<32,32>(0,0);
    auto acc=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
    for(ushort i=0;i<acc.get_capacity();++i)acc[i]=0;
    if constexpr(FUSED){
        if(sg==1)native_shared_staged<FU>(a,u,IN,UP1,UMETA,column,stage,table,acc);
        else native_shared_staged<FG>(a,w,IN,P1,META,column,stage,table,acc);
    }else native_shared_staged<FG>(a,w,IN,P1,META,column,stage,table,acc);
    if constexpr(FUSED){
        if(sg==0)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
            auto ij=acc.get_multidimensional_index(i);if(ij[1]<COUNT)gate[ij[1]*32+ij[0]]=bfloat(acc[i]);}
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(sg==1)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
            auto ij=acc.get_multidimensional_index(i);if(ij[1]>=COUNT)continue;float g=float(gate[ij[1]*32+ij[0]]);
            y[ij[1]*OUT+origin+ij[0]]=Y(float(bfloat(acc[i]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));}
    }else for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
        auto ij=acc.get_multidimensional_index(i);if(ij[1]<COUNT)y[ij[1]*OUT+origin+ij[0]]=Y(acc[i]);}
    """#
    package static let mixedHeader = #"""
    template<class Callback> inline void native_shared_format(uint format,Callback callback){
     switch(format){
    case 2:callback(FmtQ40{});break;
    case 6:callback(FmtQ50{});break;
    case 8:callback(FmtQ80{});break;
    case 11:callback(FmtQ3K{});break;
    case 12:callback(FmtQ4K{});break;
    case 13:callback(FmtQ5K{});break;
    case 14:callback(FmtQ6K{});break;
    case 20:callback(FmtIQ4NL{});break;
    case 23:callback(FmtIQ4XS{});break;
    case 42:callback(FmtTwoBit<GGUF_FMT_Q20>{});break;
    default:break;}}

    template<bool Fused>
    __attribute__((noinline)) void native_shared_column_tile(device const bfloat* x,uint count,uint K,uint N,
        device const uchar* w,device const uchar* u,uint p1,uint meta,uint up1,uint umeta,uint gf,uint uf,
        uint origin,uint lane,uint sg,threadgroup half2* table,threadgroup bfloat* gate,device bfloat* y){
        float sums[2];
        native_shared_format(Fused&&sg==1?uf:gf,[&](auto f){
            native_shared_columns<decltype(f),2>(x,count,K,Fused&&sg==1?u:w,
                Fused&&sg==1?up1:p1,Fused&&sg==1?umeta:meta,origin+lane,table,sums);
        });
        if constexpr(Fused){
            if(sg==0)for(uint r=0;r<count;++r)gate[r*32+lane]=bfloat(sums[r]);
            threadgroup_barrier(mem_flags::mem_threadgroup);
            if(sg==1)for(uint r=0;r<count;++r){float g=float(gate[r*32+lane]);
                y[r*N+origin+lane]=bfloat(float(bfloat(sums[r]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));}
        }else for(uint r=0;r<count;++r)y[r*N+origin+lane]=bfloat(sums[r]);
    }
    """#
    package static let mixedSource = #"""
    typedef bfloat Y;
        const uint COUNT=shared_meta[9], GF=shared_meta[FUSED?0:6], UF=shared_meta[3];
        const uint P1=shared_meta[FUSED?1:7],META=shared_meta[FUSED?2:8],UP1=shared_meta[4],UMETA=shared_meta[5];
        device const bfloat* shared_x=x+size_t(shared_tile)*8*IN;
        device bfloat* shared_y=y+size_t(shared_tile)*8*OUT;
        device const uchar* shared_w=FUSED?shared_gate:shared_down;
        device const uchar* shared_u=shared_up;
        using namespace mpp::tensor_ops;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup,tid=thread_index_in_threadgroup;
        uint origin=threadgroup_position_in_grid.x*(FUSED?32:64)+(FUSED?0:sg*32),column=origin+lane;
        threadgroup half* stages=schedule_stage;threadgroup half2* tables=schedule_tables;
        bool any=false;
        native_shared_format(GF,[&](auto f){any=quant_pair_entries<decltype(f)>(tables,tid,64);});
        if constexpr(FUSED)native_shared_format(UF,[&](auto f){any=quant_pair_entries<decltype(f)>(tables+256,tid,64)||any;});
        if(any)threadgroup_barrier(mem_flags::mem_threadgroup);
        threadgroup half2* table=tables+(FUSED&&sg==1?256:0);
        threadgroup half* stage=stages+sg*2*32*32;
        threadgroup bfloat* gate=reinterpret_cast<threadgroup bfloat*>(stages);
        if(COUNT<=2){
            native_shared_column_tile<FUSED>(shared_x,COUNT,IN,OUT,shared_w,shared_u,P1,META,UP1,UMETA,
                GF,UF,origin,lane,sg,table,gate,shared_y);
            return;
        }
        auto a=tensor(const_cast<device bfloat*>(shared_x),dextents<int,2>{IN,COUNT},array<int,2>{1,IN});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b(stage,dextents<int,2>{32,32},array<int,2>{1,32});
        constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,matmul2d_descriptor::mode::multiply_accumulate);
        matmul2d<desc,execution_simdgroups<1>> op;
        auto as=a.template slice<32,8>(0,0);auto bs=b.template slice<32,32>(0,0);
        auto acc=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
        for(ushort i=0;i<acc.get_capacity();++i)acc[i]=0;
        if constexpr(FUSED){
            native_shared_format(sg==1?UF:GF,[&](auto f){native_shared_staged<decltype(f)>(a,sg==1?shared_u:shared_w,IN,sg==1?UP1:P1,sg==1?UMETA:META,column,stage,table,acc);});
        }else native_shared_format(GF,[&](auto f){native_shared_staged<decltype(f)>(a,shared_w,IN,P1,META,column,stage,table,acc);});
        if constexpr(FUSED){
            if(sg==0)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
                auto ij=acc.get_multidimensional_index(i);if(ij[1]<COUNT)gate[ij[1]*32+ij[0]]=bfloat(acc[i]);}
            threadgroup_barrier(mem_flags::mem_threadgroup);
            if(sg==1)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
                auto ij=acc.get_multidimensional_index(i);if(ij[1]>=COUNT)continue;float g=float(gate[ij[1]*32+ij[0]]);
                shared_y[ij[1]*OUT+origin+ij[0]]=Y(float(bfloat(acc[i]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));}
        }else for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
            auto ij=acc.get_multidimensional_index(i);if(ij[1]<COUNT)shared_y[ij[1]*OUT+origin+ij[0]]=Y(acc[i]);}
    """#
}
