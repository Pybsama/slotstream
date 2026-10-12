import Foundation
import Metal
import QuartzCore
struct ModelError: Error { let message: String; init(_ s: String) { message = s } }
func emit(_ value: [String: Any]) {
    let data = try! JSONSerialization.data(withJSONObject: value, options: [.sortedKeys])
    print(String(decoding: data, as: UTF8.self)); fflush(stdout)
}
func percentile(_ a: [Double], _ p: Double) -> Double { a.sorted()[min(a.count-1, Int(Double(a.count-1)*p))] }
let device = MTLCreateSystemDefaultDevice()!
let queue = device.makeCommandQueue()!
let source = """
#include <metal_stdlib>
using namespace metal;
kernel void work(device float* output [[buffer(0)]], uint i [[thread_position_in_grid]]) {
    float x = float(i % 97) * 0.01f;
    for (uint j = 0; j < 500; ++j) x = fma(x, 1.0000001f, 0.5f);
    output[i] = x;
}
kernel void spin(device atomic_uint* flag [[buffer(0)]], constant uint& n [[buffer(1)]], uint i [[thread_position_in_grid]]) {
    for (uint j = 0; j < n; ++j) {
        if (atomic_load_explicit(flag, memory_order_relaxed) != 0u) break;
    }
}
"""
let library = try device.makeLibrary(source: source, options: nil)
let work = try device.makeComputePipelineState(function: library.makeFunction(name: "work")!)
let spin = try device.makeComputePipelineState(function: library.makeFunction(name: "spin")!)
let output = device.makeBuffer(length: 65536 * 4, options: .storageModeShared)!
let flag = device.makeBuffer(length: 16, options: .storageModeShared)!
flag.contents().storeBytes(of: UInt32(0), as: UInt32.self)
func finish(_ cb: MTLCommandBuffer) {
    cb.waitUntilCompleted()
    guard cb.status == .completed, cb.error == nil else { fatalError("Metal failure: \(String(describing: cb.error))") }
}
func sample(width: Int) -> [Double] {
    let cb = queue.makeCommandBuffer()!
    let enc = cb.makeComputeCommandEncoder(dispatchType: .concurrent)!
    enc.setComputePipelineState(work); enc.setBuffer(output, offset: 0, index: 0)
    enc.dispatchThreads(MTLSize(width: width, height: 1, depth: 1), threadsPerThreadgroup: MTLSize(width: 256, height: 1, depth: 1))
    enc.endEncoding()
    let start = CACurrentMediaTime(); cb.commit(); finish(cb)
    return [(CACurrentMediaTime() - start)*1e6, (cb.gpuStartTime-start)*1e6, (cb.gpuEndTime-cb.gpuStartTime)*1e6]
}
emit(["kind":"environment","device": device.name,"os":ProcessInfo.processInfo.operatingSystemVersionString,"thermal":ProcessInfo.processInfo.thermalState.rawValue,"bytes":65536*4+16,"scope":"synthetic diagnostic, no model"])
for n in [UInt32(5000),50000,200000] {
    var durations: [Double] = []
    for _ in 0..<7 {
        let cb = queue.makeCommandBuffer()!, enc = cb.makeComputeCommandEncoder()!
        enc.setComputePipelineState(spin); enc.setBuffer(flag, offset:0,index:0)
        var count = n; enc.setBytes(&count,length:4,index:1)
        enc.dispatchThreads(MTLSize(width:1,height:1,depth:1),threadsPerThreadgroup:MTLSize(width:1,height:1,depth:1))
        enc.endEncoding(); cb.commit(); finish(cb)
        durations.append((cb.gpuEndTime-cb.gpuStartTime)*1e3)
    }
    emit(["kind":"bounded_spin","iterations":n,"gpu_ms_median":percentile(durations,0.5),"gpu_ms_max":durations.max()!])
}
let keeper = GPUKeepAlive.shared!
var references: [Int: Data] = [:]
for width in [256,65536] {
    _ = sample(width:width)
    references[width] = Data(bytes:output.contents(),count:width*4)
}
for round in 0..<4 {
    for enabled in (round % 2 == 0 ? [false,true] : [true,false]) {
        if enabled { keeper.begin() }
        for gap in [0,200,1000] {
            for width in [256,65536] {
                for _ in 0..<8 { if gap > 0 { usleep(UInt32(gap)) }; _ = sample(width:width) }
                var samples: [[Double]] = []
                for _ in 0..<48 { if gap > 0 { usleep(UInt32(gap)) }; samples.append(sample(width:width)) }
                let exact = references[width] == Data(bytes:output.contents(),count:width*4)
                emit(["kind":"work","round":round,"keepalive":enabled,"gap_us":gap,"width":width,"wall_us_p50":percentile(samples.map{$0[0]},0.5),"wall_us_p95":percentile(samples.map{$0[0]},0.95),"commit_to_start_us_p50":percentile(samples.map{$0[1]},0.5),"gpu_us_p50":percentile(samples.map{$0[2]},0.5),"exact":exact,"thermal":ProcessInfo.processInfo.thermalState.rawValue])
                if !exact { fatalError("output mismatch") }
            }
        }
        if enabled { keeper.end() }
        usleep(200000)
        let settled = keeper.submittedBuffers; usleep(200000)
        guard keeper.submittedBuffers == settled else { fatalError("keepalive did not settle") }
    }
}
emit(["kind":"complete","buffers":keeper.submittedBuffers,"thermal":ProcessInfo.processInfo.thermalState.rawValue])

// A bounded causal probe: no CPU writes to an in-flight GPU flag. The
// dependency arm deliberately makes real work wait for the spin to finish.
// It is a positive control for serialization, not a reproduction of M5 Air.
let spinQueue = device.makeCommandQueue()!
let event = device.makeSharedEvent()!
var eventValue: UInt64 = 0
for round in 0..<3 {
    let modes = round % 2 == 0 ? ["independent", "dependency"] : ["dependency", "independent"]
    for mode in modes {
        for n in [UInt32(0), 5000, 50000, 200000] {
            for depth in [1, 2] {
                for sampleIndex in 0..<8 {
                    usleep(1000)
                    var spins: [MTLCommandBuffer] = []
                    for index in 0..<depth {
                        let cb = spinQueue.makeCommandBufferWithUnretainedReferences()!
                        let enc = cb.makeComputeCommandEncoder()!
                        enc.setComputePipelineState(spin)
                        enc.setBuffer(flag, offset: 0, index: 0)
                        var count = n; enc.setBytes(&count, length: 4, index: 1)
                        enc.dispatchThreads(MTLSize(width: 1, height: 1, depth: 1), threadsPerThreadgroup: MTLSize(width: 1, height: 1, depth: 1))
                        enc.endEncoding()
                        if index == depth - 1 {
                            eventValue += 1
                            cb.encodeSignalEvent(event, value: eventValue)
                        }
                        spins.append(cb)
                    }
                    let cb = queue.makeCommandBuffer()!
                    if mode == "dependency" { cb.encodeWaitForEvent(event, value: eventValue) }
                    let enc = cb.makeComputeCommandEncoder(dispatchType: .concurrent)!
                    enc.setComputePipelineState(work); enc.setBuffer(output, offset: 0, index: 0)
                    enc.dispatchThreads(MTLSize(width: 65536, height: 1, depth: 1), threadsPerThreadgroup: MTLSize(width: 256, height: 1, depth: 1))
                    enc.endEncoding()
                    let start = CACurrentMediaTime()
                    for spinCB in spins { spinCB.commit() }
                    let workCommit = CACurrentMediaTime(); cb.commit(); finish(cb)
                    let workDone = CACurrentMediaTime()
                    let exact = references[65536] == Data(bytes: output.contents(), count: 65536*4)
                    for spinCB in spins { finish(spinCB) }
                    emit(["kind": "scheduling", "round": round, "mode": mode, "iterations": n, "depth": depth,
                          "sample": sampleIndex, "wall_us": (workDone-workCommit)*1e6,
                          "work_commit_us": (workCommit-start)*1e6,
                          "work_start_us": (cb.gpuStartTime-start)*1e6, "work_end_us": (cb.gpuEndTime-start)*1e6,
                          "spin_intervals_us": spins.map { [($0.gpuStartTime-start)*1e6, ($0.gpuEndTime-start)*1e6] },
                          "exact": exact, "thermal": ProcessInfo.processInfo.thermalState.rawValue])
                    if !exact { fatalError("scheduling probe output mismatch") }
                }
            }
        }
    }
}
emit(["kind":"scheduling_complete","thermal":ProcessInfo.processInfo.thermalState.rawValue])
