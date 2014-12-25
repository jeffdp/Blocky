//
//  Model.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation
import Metal

protocol ModelObject {
	var vertices: [Float] { get }
	var vertexCount: Int { get }
	
	var indices: [UInt16] { get }
}