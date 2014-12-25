//
//  CubeModel.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation

class CubeModel : ModelObject {

	var vertices: [Float] {
		get {
			return vertexData
		}
	}
	
	var vertexCount: Int {
		get {
			return 24
		}
	}
	
	var indices: [Int] {
		get {
			return indexData
		}
	}
	
	let vertexData: [Float] = [
		//Left
		-1, -1, -1,
		-1, 1, -1,
		-1, 1, 1,
		-1, -1, 1,

		//Right
		1, -1, 1,
		1, 1, 1,
		1, 1, -1,
		1, -1, -1,

		//Bottom
		-1, -1, -1,
		-1, -1, 1,
		1, -1, 1,
		1, -1, -1,

		//Top
		-1, 1, -1,
		1, 1, -1,
		1, 1, 1,
		-1, 1, 1,

		//Back
		1, -1, -1,
		1, 1, -1,
		-1, 1, -1,
		-1, -1, -1,

		//Front
		-1, -1, 1,
		-1, 1, 1,
		1, 1, 1,
		1, -1, 1]

	let uvData: [Float] = [
		//Left
		0, 0,
		0, 1,
		1, 1,
		1, 0,
		
		//Right
		0, 0,
		0, 1,
		1, 1,
		1, 0,
		
		//Bottom
		0, 0,
		0, 1,
		1, 1,
		1, 0,
		
		//Top
		0, 0,
		0, 1,
		1, 1,
		1, 0,
		
		//Back
		0, 0,
		0, 1,
		1, 1,
		1, 0,
		
		//Front
		0, 0,
		0, 1,
		1, 1,
		1, 0]

	let indexData: [Int] = [
		//Left
		0, 1, 2,
		0, 2, 3,
		
		//Right
		4, 5, 6,
		4, 6, 7,
		
		//Bottom
		8, 9, 10,
		8, 10, 11,
		
		//Top
		12, 13, 14,
		12, 14, 15,
		
		//Back
		16, 17, 18,
		16, 18, 19,
		
		//Front
		20, 21, 22,
		20, 22, 23]

	let tangentData: [Float] = [
		//Left
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		
		//Right
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		
		//Bottom
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		
		//Top
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		
		//Back
		-1, 0, 0,
		-1, 0, 0,
		-1, 0, 0,
		-1, 0, 0,
		
		//Front
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		1, 0, 0]
	
	let bitangentData: [Float] = [
		//Left
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		
		//Right
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		
		//Bottom
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		
		//Top
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		
		//Back
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		
		//Front
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0]

	let normalData: [Float] = [
		//Left
		-1, 0, 0,
		-1, 0, 0,
		-1, 0, 0,
		-1, 0, 0,
		
		//Right
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		1, 0, 0,
		
		//Bottom
		0, -1, 0,
		0, -1, 0,
		0, -1, 0,
		0, -1, 0,
		
		//Top
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		0, 1, 0,
		
		//Back
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		0, 0, -1,
		
		//Front
		0, 0, 1,
		0, 0, 1,
		0, 0, 1,
		0, 0, 1]
}