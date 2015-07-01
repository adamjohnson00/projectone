//
//  GameViewController.swift
//  SpaceGame
//
//  Created by Adam Johnson on 6/24/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

import UIKit
import SpriteKit





class GameViewController: UIViewController
{
    var scene: MainMenuScene!

    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Configure the main view.
        let skView = view as! SKView
        
        // Turns on the frames per second display.
        //skView.showsFPS = true
        //skView.showsNodeCount = true;


        // Create and configure the game scene.
        scene = MainMenuScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill

        // Show the scene.
        skView.presentScene(scene)
    }
}