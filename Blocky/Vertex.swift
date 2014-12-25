//
//  Vertex.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation

struct Vertex{
 
	var x,y,z: Float     // position data
	var nx, ny, nz: Float   // color data
 
	func floatBuffer() -> [Float] {
		return [x, y, z, nx, ny, nz]
	}
 
};