//
//  GameScene.swift
//  SpaceGame
//
//  Created by Adam Johnson on 6/24/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate
{
    // Node variables.
    var backgroundNode : SKSpriteNode?
    var playerNode : SKSpriteNode?
    var blueLaser : SKSpriteNode?

    // Sound variables.
    var shootLowNoiseSoundAction = SKAction.playSoundFileNamed("lowblast.wav", waitForCompletion: false)
    var shootNoiseSoundAction = SKAction.playSoundFileNamed("blast.wav", waitForCompletion: false)


    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }


    override init(size: CGSize)
    {
        super.init(size: size)


        physicsWorld.contactDelegate = self


        //addBackground()

        addPlayer()
    }


    func addBackground()
    {
        // Sets the Background image to backgroundNode.
        backgroundNode = SKSpriteNode(imageNamed: "Background")

        // Sets the background's anchor point.
        backgroundNode!.anchorPoint = CGPoint(x: 0.5, y: 0.0)

        // Sets the background's position.
        backgroundNode!.position = CGPoint(x: self.size.width / 2.0, y: 0.0)

        // Adds the background node.
        addChild(backgroundNode!)
    }


    func addPlayer()
    {

        playerNode = SKSpriteNode(imageNamed: "shipship2")

        playerNode!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        playerNode!.position = CGPoint(x: self.size.width / 2.0, y: 50.0)


//        Add physics body to playerNode.
//        playerNode!.physicsBody = SKPhysicsBody(circleOfRadius: playerNode!.size.width / 2)
//        playerNode!.physicsBody!.dynamic = false


//        Add simulated air friction.
//        playerNode!.physicsBody!.linearDamping = 1.0

//        Turns off rotation when collided with.
//        playerNode!.physicsBody!.allowsRotation = false

//        Setting up the bit masks for playerNode.
//        playerNode!.physicsBody!.categoryBitMask = CollisionCategoryPlayer
//        playerNode!.physicsBody!.contactTestBitMask = CollisionCategoryPowerUpOrbs | CollisionCategoryBlackHoles
//        playerNode!.physicsBody!.collisionBitMask = 0



        addChild(playerNode!)
    }


    func addBlueLaser()
    {

        blueLaser = SKSpriteNode(imageNamed: "bluelaserwhiteborder")

        blueLaser!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        blueLaser!.position = CGPoint(x: playerNode!.position.x, y: playerNode!.position.y + 20)

//        blueLaser!.physicsBody = SKPhysicsBody(circleOfRadius: blueLaser!.size.height / 2)
//
//        blueLaser!.physicsBody!.dynamic = false

        // Move the blue laser up the screen (shoot the laser).
//        let moveUpAction = SKAction.moveToY(playerNode!.position.y + 3000, duration: 3.0)
//
//        blueLaser!.runAction(moveUpAction)

        //blueLaser!.name = "blue_laser"

//        blueLaser!.physicsBody!.categoryBitMask = CollisionCategoryBlueLaser
//        blueLaser!.physicsBody!.contactTestBitMask = CollisionCategoryBlackHoles
//        blueLaser!.physicsBody!.collisionBitMask = 0

        addChild(blueLaser!)

        let moveUpAction = SKAction.moveToY(playerNode!.position.y + 8000, duration: 2.5)

        blueLaser!.runAction(moveUpAction)

        runAction(shootLowNoiseSoundAction)
        runAction(shootNoiseSoundAction)
    }


    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        addBlueLaser()


    }




}
