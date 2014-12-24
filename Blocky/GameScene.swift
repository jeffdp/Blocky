//
//  GameScene.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-24.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import Foundation

/* Design
   ------
   Maintain a set of model objects
   Provide model objects to the renderer
 */

class GameScene {
	var models: [ModelObject] = []
	
	init() {
		// TEMP: creating scene by default
		
		let model = QuadModel()
		models.append(model)
	}
}