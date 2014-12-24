//
//  GameEngine.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation

class GameEngine {
	
	func update() {
		
		/*
		// vData is pointer to the MTLBuffer's Float data contents
		let pData = vertexBuffer.contents()
		let vData = UnsafeMutablePointer<Float>(pData + 256*bufferIndex)
		
		// reset the vertices to default before adding animated offsets
		vData.initializeFrom(vertexData)
		
		// Animate triangle offsets
		let lastTriVertex = 24
		let vertexSize = 4
		for j in 0..<MaxBuffers {
			// update the animation offsets
			xOffset[j] += xDelta[j]
			
			if(xOffset[j] >= 1.0 || xOffset[j] <= -1.0) {
				xDelta[j] = -xDelta[j]
				xOffset[j] += xDelta[j]
			}
			
			yOffset[j] += yDelta[j]
			
			if(yOffset[j] >= 1.0 || yOffset[j] <= -1.0) {
				yDelta[j] = -yDelta[j]
				yOffset[j] += yDelta[j]
			}
			
			// Update last triangle position with updated animated offsets
			let pos = lastTriVertex + j*vertexSize
			vData[pos] = xOffset[j]
			vData[pos+1] = yOffset[j]
		}
*/
	}
}