//
//  QuadModel.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation
import Metal

let vertexData:[Float] =
[
	-1.0,  1.0, 0.0, 1.0, // UL
	1.0,  1.0, 0.0, 1.0,  // UR
	1.0, -1.0, 0.0, 1.0,  // LR

	1.0, -1.0, 0.0, 1.0,  // LR
	-1.0, -1.0, 0.0, 1.0, // LL
	-1.0,  1.0, 0.0, 1.0  // UL
	
//	-1.0,  1.0, 0.0, 1.0, // UL 0
//	1.0,  1.0, 0.0, 1.0,  // UR 1
//	-1.0, -1.0, 0.0, 1.0, // LL 2
//	1.0, -1.0, 0.0, 1.0   // LR 3
]

let indexData: [Int] = [
	0, 1, 3,
	3, 2, 0
]

class QuadModel : ModelObject {
	
	var vertices: [Float] {
		get {
			return vertexData;
		}
	}
	
	var vertexCount: Int {
		get {
			return 6
		}
	}
	
	var indices: [Int] {
		get {
			return indexData
		}
	}

}