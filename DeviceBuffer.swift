//
//  DeviceBuffer.swift
//  Pollux
//
//  Created by Youssef Victor on 11/28/17.
//  Copyright © 2017 Youssef Victor. All rights reserved.
//

import Foundation
import Metal

// TODO: Documentation for Device Buffer
class DeviceBuffer <T>  {
    // Buffer Size
    var count  : Int
    
    // The actual Buffer that stores the data
    var data : MTLBuffer?
    
//    let memory  : UnsafeMutableRawPointer?
    
    
    init (count: Int, with device: MTLDevice, containing contents : [T] = [], blitOn commandQueue: MTLCommandQueue? = nil) {
        self.count = count
        self.data = device.makeBuffer(length: count * MemoryLayout<T>.size.self, options: .storageModePrivate)
        
        // Create a temporary shared buffer to move data to/from
        if contents.count > 0 {
            let sharedBuffer = SharedBuffer<T>(count: self.count, with: device, containing: contents)
            
            let commandBuffer = commandQueue!.makeCommandBuffer()
            let blitCommandEncoder = commandBuffer?.makeBlitCommandEncoder()
            blitCommandEncoder?.copy(from: sharedBuffer.data!, sourceOffset: 0,
                                     to: self.data!, destinationOffset: 0,
                                     size: count * MemoryLayout<T>.size.self)
            blitCommandEncoder?.endEncoding()
            commandBuffer?.commit()
            commandBuffer?.waitUntilCompleted()
        }
    }
    
      // TODO: Implement Subscript operator
//    public subscript(i: Int) -> T {
      // Create single sharedBuffer Element
      // --- copy from buffer to element ---
      // return element
//    }
    
    public func resize(count: Int, with device: MTLDevice) {
        self.count = count
        self.data =  device.makeBuffer(length: self.count * MemoryLayout<T>.size.self, options: .storageModePrivate)
    }
}
