//
//  GameScene.swift
//  SpaceGame
//
//  Created by Adam Johnson on 6/24/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene
{

    var backgroundNode : SKSpriteNode?

    var playerNode : SKSpriteNode?


    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }


    override init(size: CGSize)
    {
        super.init(size: size)







        addBackground()

        addPlayer()
    }


    func addBackground()
    {
        backgroundNode = SKSpriteNode(imageNamed: "Background")

        // Sets the background's anchor point.
        backgroundNode!.anchorPoint = CGPoint(x: 0.5, y: 0.0)

        // Sets the background's position.
        backgroundNode!.position = CGPoint(x: size.width / 2.0, y: 0.0)

        // Adds the background node.
        addChild(backgroundNode!)
    }


    func addPlayer()
    {
        // Add the player.
        playerNode = SKSpriteNode(imageNamed: "shipship2")

        // Add physics body to playerNode.
//        playerNode!.physicsBody = SKPhysicsBody(circleOfRadius: playerNode!.size.width / 2)
//        playerNode!.physicsBody!.dynamic = false

        // Set player position.
        playerNode!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playerNode!.position = CGPoint(x: self.size.width / 4.0, y: 220.0)

        // Add simulated air friction.
//        playerNode!.physicsBody!.linearDamping = 1.0

        // Turns off rotation when collided with.
//        playerNode!.physicsBody!.allowsRotation = false

        // Setting up the bit masks for playerNode.
//        playerNode!.physicsBody!.categoryBitMask = CollisionCategoryPlayer
//        playerNode!.physicsBody!.contactTestBitMask = CollisionCategoryPowerUpOrbs | CollisionCategoryBlackHoles
//        playerNode!.physicsBody!.collisionBitMask = 0

        backgroundNode!.addChild(playerNode!)
    }




}
