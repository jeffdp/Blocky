//
//  MetalModels.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-25.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation
import Metal

// This is a series of functions that are useful when dealing with Metal geometry

func vertexBufferWithVertices(vertices: [Float], device: MTLDevice) -> MTLBuffer {
	let length = vertexData.count * sizeofValue(vertices[0])
	let vertexBuffer = device.newBufferWithBytes(vertices, length: length, options: nil)
	vertexBuffer.label = "vertices"
	
	return vertexBuffer
}

func indexBufferWithIndices(indices: [UInt16], device: MTLDevice) -> MTLBuffer {
	let length = indexData.count * sizeofValue(indices[0])
	let indexBuffer = device.newBufferWithBytes(indices, length: length, options: nil)
	indexBuffer.label = "indices"
	
	return indexBuffer
}