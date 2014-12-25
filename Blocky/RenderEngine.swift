//
//  RenderEngine.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

class RenderEngine {
	let device = { MTLCreateSystemDefaultDevice() }()
	
	var commandQueue: MTLCommandQueue! = nil
	var pipelineState: MTLRenderPipelineState! = nil
	var vertexBuffer: MTLBuffer! = nil
	var vertexColorBuffer: MTLBuffer! = nil

	let inflightSemaphore = dispatch_semaphore_create(MaxBuffers)

	func setup() {
		commandQueue = device.newCommandQueue()
		commandQueue.label = "main command queue"
		
		let defaultLibrary = device.newDefaultLibrary()
		let fragmentProgram = defaultLibrary?.newFunctionWithName("passThroughFragment")
		let vertexProgram = defaultLibrary?.newFunctionWithName("passThroughVertex")
		
		let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
		pipelineStateDescriptor.vertexFunction = vertexProgram
		pipelineStateDescriptor.fragmentFunction = fragmentProgram
		pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
		
		var pipelineError : NSError?
		pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor, error: &pipelineError)
		if (pipelineState == nil) {
			println("Failed to create pipeline state, error \(pipelineError)")
		}
	}
	
	func update() {
		
	}
	
	func render(scene: GameScene, drawable: CAMetalDrawable) {
		
		// use semaphore to encode 3 frames ahead
		dispatch_semaphore_wait(inflightSemaphore, DISPATCH_TIME_FOREVER)
		
		update()
		
		let commandBuffer = commandQueue.commandBuffer()
		commandBuffer.label = "Frame command buffer"
		
		let renderPassDescriptor = MTLRenderPassDescriptor()
		renderPassDescriptor.colorAttachments[0].texture = drawable.texture
		renderPassDescriptor.colorAttachments[0].loadAction = .Clear
		renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		renderPassDescriptor.colorAttachments[0].storeAction = .Store
		
		let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)!
		renderEncoder.label = "render encoder"
		
		renderEncoder.pushDebugGroup("draw morphing triangle")
		renderEncoder.setRenderPipelineState(pipelineState)
		
		for model: ModelObject in scene.models {
			let vertexCount = model.vertexCount
			let vertexBuffer = vertexBufferWithVertices(model.vertices, device)
			let indexBuffer = indexBufferWithIndices(model.indices, device)
			
			renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
			renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: 1)
//			renderEncoder.drawIndexedPrimitives(.Triangle, indexCount: vertexCount, indexType: .UInt32, indexBuffer: indexBuffer, indexBufferOffset: 0)
		}
		
		renderEncoder.popDebugGroup()
		renderEncoder.endEncoding()
		
		// use completion handler to signal the semaphore when this frame is completed allowing the encoding of the next frame to proceed
		// use capture list to avoid any retain cycles if the command buffer gets retained anywhere besides this stack frame
		commandBuffer.addCompletedHandler{ [weak self] commandBuffer in
			if let strongSelf = self {
				dispatch_semaphore_signal(strongSelf.inflightSemaphore)
			}
			return
		}
		
		commandBuffer.presentDrawable(drawable)
		commandBuffer.commit()
	}

}