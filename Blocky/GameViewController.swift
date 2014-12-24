//
//  GameViewController.swift
//  Blocky
//
//  Created by Jeff Porter on 2014-12-21.
//  Copyright (c) 2014 jeffdporter. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

let MaxBuffers = 3
let ConstantBufferSize = 1024*1024

class GameViewController: UIViewController {
    
    let metalLayer = { CAMetalLayer() }()
	var renderEngine = RenderEngine()
	let gameEngine = GameEngine()
	var scene: GameScene?
	
	var timer: CADisplayLink! = nil
	
	required init(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Instantiate the render engine
		renderEngine = RenderEngine()
		
		// set up the metal layer
        metalLayer.device = renderEngine.device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.framebufferOnly = true
        
        self.resize()
        
        view.layer.addSublayer(metalLayer)
        view.opaque = true
        view.backgroundColor = nil
		
		renderEngine.setup()
		setupScene()
		
        timer = CADisplayLink(target: self, selector: Selector("renderLoop"))
        timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }
	
	// TODO: Move this into a game object
	func setupScene() {
		scene = GameScene()
		
	}
	
    override func viewDidLayoutSubviews() {
        self.resize()
    }
    
    func resize() {
        if (view.window == nil) {
            return
        }
        
        let window = view.window!
        let nativeScale = window.screen.nativeScale
        view.contentScaleFactor = nativeScale
        metalLayer.frame = view.layer.frame
        
        var drawableSize = view.bounds.size
        drawableSize.width = drawableSize.width * CGFloat(view.contentScaleFactor)
        drawableSize.height = drawableSize.height * CGFloat(view.contentScaleFactor)
        
        metalLayer.drawableSize = drawableSize
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
   
    deinit {
        timer.invalidate()
    }
    
    func renderLoop() {
        autoreleasepool {
			let drawable = self.metalLayer.nextDrawable()
			
			if let theScene: GameScene = self.scene {
				self.renderEngine.render(theScene, drawable: drawable)
			}
        }
    }
    
	
}