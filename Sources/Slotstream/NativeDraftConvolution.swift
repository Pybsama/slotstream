import Foundation
import MLX

/// Splash's DFlash convolution and residual boundary, on the MLX stream.
/// Adapted from 1482f6b runtime/metal/kernels/decode/draft.metal (Apache-2.0).
/// The draft proposes tokens; target verification remains unchanged.
package enum NativeDraftConvolution {
    private static let lock = NSLock()
    private static var calls = 0
    package static var callCount: Int { lock.withLock { calls } }

    package static func apply(_ input: MLXArray, dynamic: MLXArray,
        base: MLXArray, residual: MLXArray? = nil) -> MLXArray {
        let width = input.dim(-1), count = input.dim(1)
        precondition(input.ndim == 3 && input.dim(0) == 1 && (1...8).contains(count)
            && width.isMultiple(of: 16) && base.shape == [2,2,width]
            && dynamic.shape == [1,count,4*(width/16)]
            && [input,dynamic,base].allSatisfy { $0.dtype == .bfloat16 })
        precondition(residual == nil || (residual!.shape == input.shape && residual!.dtype == .bfloat16))
        lock.withLock { calls += 1 }
        return kernel([contiguous(input),contiguous(dynamic),contiguous(base),contiguous(residual ?? input)],
            template: [("FINISH",residual != nil)], grid: (count*width,1,1), threadGroup:(256,1,1),
            outputShapes:[input.shape],outputDTypes:[.bfloat16])[0]
    }
    private static let kernel = MLXFast.metalKernel(name:"slotstream_native_draft_conv",
        inputNames:["input","dynamic","base","residual"],outputNames:["output"],source:#"""
        const uint i=thread_position_in_grid.x, hidden=input_shape[2], rows=input_shape[1];
        if(i>=rows*hidden)return;
        const uint row=i/hidden, channel=i%hidden, groups=hidden/16, group=channel/16;
        constexpr uint kind=FINISH?1:0;
        float value=float(input[i])*(float(base[kind*2*hidden+channel])
            +float(dynamic[row*4*groups+kind*2*groups+group]));
        if(row>0)value+=float(input[(row-1)*hidden+channel])
            *(float(base[(kind*2+1)*hidden+channel])
            +float(dynamic[row*4*groups+(kind*2+1)*groups+group]));
        if constexpr(FINISH)value+=float(residual[i]);
        output[i]=bfloat(value);
        """#,ensureRowContiguous:true)
}
