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
    var blueLaserOne : SKSpriteNode?
    var blueLaserTwo : SKSpriteNode?
    var blueLaserThree : SKSpriteNode?
    var blueLaserFour : SKSpriteNode?

    var badguytest : SKSpriteNode?

    var secretnode : SKSpriteNode?

    var explosiontest : SKSpriteNode?

    // Sound variables.
    var shootLowNoiseSoundAction = SKAction.playSoundFileNamed("lowblast.wav", waitForCompletion: false)
    var shootNoiseSoundAction = SKAction.playSoundFileNamed("blast.wav", waitForCompletion: false)

    // For the accelerator.
    var coreMotionManager = CMMotionManager()
    var xAxisAcceleration : CGFloat = 0


    //let CollisionCategoryPlayer : UInt32 = 0x1 << 1
    let CollisionCategoryBlueLaser : UInt32 = 0x1 << 1
    let CollisionCategoryBadGuyTest : UInt32 = 0x1 << 2

    var badguytestlife = 0

    var gun = 1

    var blastlimit = 1

    var fireExplosion : SKEmitterNode?
    var fireTimer : NSTimer?



    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }



    override init(size: CGSize)
    {
        super.init(size: size)

        // Sets the delegate.
        physicsWorld.contactDelegate = self

        // Sets the strength and direction of gravity.
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)

        // Enables user interation.
        userInteractionEnabled = true




        addBackground()

        addPlayer()

        addBadGuyTest()

    }











    func secretNode()
    {
        secretnode = SKSpriteNode(imageNamed: "secretnode")

        secretnode!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        secretnode!.position = CGPoint(x: badguytest!.position.x, y: badguytest!.position.y)

        secretnode!.physicsBody = SKPhysicsBody(circleOfRadius: secretnode!.size.width / 2)

        secretnode!.physicsBody!.dynamic = false

        let firePath = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")

        fireExplosion = NSKeyedUnarchiver.unarchiveObjectWithFile(firePath!) as? SKEmitterNode

        fireExplosion!.position = CGPointMake(0.0, 0.5)

        secretnode!.addChild(fireExplosion!)

        fireExplosion!.hidden = true

        addChild(secretnode!)
    }











    func addBackground()
    {
        // Sets the Background image to backgroundNode.
        backgroundNode = SKSpriteNode(imageNamed: "paintbackgroundfour")

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


        // Add physics body to playerNode.
        playerNode!.physicsBody = SKPhysicsBody(circleOfRadius: playerNode!.size.width / 2)

        playerNode!.physicsBody!.dynamic = false


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















    func addBadGuyTest()
    {
        badguytest = SKSpriteNode(imageNamed: "badguytest")

        badguytest!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        badguytest!.position = CGPoint(x: self.size.width / 2, y: 400)

        badguytest!.physicsBody = SKPhysicsBody(circleOfRadius: badguytest!.size.width / 2)

        badguytest!.physicsBody!.dynamic = true

        badguytest!.name = "bad_guy_test"

        // Setting up the bit masks for playerNode.
        badguytest!.physicsBody!.categoryBitMask = CollisionCategoryBadGuyTest
        badguytest!.physicsBody!.contactTestBitMask = CollisionCategoryBlueLaser
        badguytest!.physicsBody!.collisionBitMask = 0

        let moveRightAction = SKAction.moveToX(self.size.width, duration: 1)
        let moveLeftAction = SKAction.moveToX(0.0, duration: 2)
        let moveRightAction2 = SKAction.moveToX(self.size.width / 2, duration: 1)

        let actionSequence = SKAction.sequence([moveRightAction, moveLeftAction, moveRightAction2])
        let moveAction = SKAction.repeatActionForever(actionSequence)

        badguytest!.runAction(moveAction)

        addChild(badguytest!)
    }









    override func touchesBegan(touches: Set <NSObject>, withEvent event: UIEvent)
    {
        if gun == 1
        {
            shootLaserOne()
        }
        else if gun == 2
        {
            shootLaserTwo()
        }
        else if gun == 3
        {
            shootLaserThree()
        }
        else if gun == 4
        {
            shootLaserFour()
        }
        else if gun == 5
        {
            shootLaserOne()
            shootLaserTwo()
            shootLaserThree()
            shootLaserFour()
        }
    }









    func didBeginContact(contact: SKPhysicsContact)
    {
        // nodeA and bodyA are the "badguytest" node.
        var nodeA = contact.bodyA!.node!

        // nodeB and bodyB are the laser blasts.
        var nodeB = contact.bodyB!.node!


        if nodeA.name == "bad_guy_test"
        {
            badguytestlife++

            nodeB.removeFromParent()

            if badguytestlife == 3
            {
                badguytest!.physicsBody!.contactTestBitMask = 0
                secretNode()
                explode()
                nodeA.removeFromParent()
            }
//            println(badguytestlife)
        }
    }








    func explode()
    {
        fireExplosion!.hidden = false

        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "hideExplosion:", userInfo: nil, repeats: false)
    }


    func hideExplosion(timer: NSTimer!)
    {
        if !fireExplosion!.hidden == true
        {
            fireExplosion!.hidden = true
        }
    }



















    override func update(currentTime: NSTimeInterval)
    {
        if badguytestlife == 3
        {

        }
    }


















    func shootLaserOne()
    {
        blueLaserOne = SKSpriteNode(imageNamed: "redlaserwhiteborder")

        blueLaserOne!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        blueLaserOne!.position = CGPoint(x: playerNode!.position.x - 10, y: playerNode!.position.y + 24)

        blueLaserOne!.physicsBody = SKPhysicsBody(circleOfRadius: blueLaserOne!.size.width / 2)

        blueLaserOne!.physicsBody!.dynamic = true

        blueLaserOne!.name = "blue_laser"

        blueLaserOne!.physicsBody!.categoryBitMask = CollisionCategoryBlueLaser
        //blueLaserOne!.physicsBody!.contactTestBitMask = CollisionCategoryBadGuyTest
        blueLaserOne!.physicsBody!.collisionBitMask = 0

        addChild(blueLaserOne!)

        // Creates the action that moves the laser blast up the screen.
        let moveUpAction = SKAction.moveToY(self.size.height + 20, duration: 0.8)
        let moveRightAction = SKAction.moveToX(playerNode!.position.x, duration: 0.6)

        // Runs the action.
        blueLaserOne!.runAction(moveUpAction)
        blueLaserOne!.runAction(moveRightAction)

        // Plays sound when laser blast is created.  (Two sounds are played at the same time.)
        runAction(shootLowNoiseSoundAction)
        runAction(shootNoiseSoundAction)

        gun = 2
    }


    func shootLaserTwo()
    {
        blueLaserTwo = SKSpriteNode(imageNamed: "bluelaserwhiteborder")

        blueLaserTwo!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        blueLaserTwo!.position = CGPoint(x: playerNode!.position.x + 10, y: playerNode!.position.y + 24)

        blueLaserTwo!.physicsBody = SKPhysicsBody(circleOfRadius: blueLaserTwo!.size.width / 2)

        blueLaserTwo!.physicsBody!.dynamic = true

        blueLaserTwo!.name = "blue_laser"

        blueLaserTwo!.physicsBody!.categoryBitMask = CollisionCategoryBlueLaser
        //blueLaserTwo!.physicsBody!.contactTestBitMask = CollisionCategoryBadGuyTest
        blueLaserTwo!.physicsBody!.collisionBitMask = 0

        addChild(blueLaserTwo!)

        // Creates the action that moves the laser blast up the screen.
        let moveUpAction = SKAction.moveToY(self.size.height + 20, duration: 0.8)
        let moveLeftAction = SKAction.moveToX(playerNode!.position.x, duration: 0.6)

        // Runs the action.
        blueLaserTwo!.runAction(moveUpAction)
        blueLaserTwo!.runAction(moveLeftAction)

        // Plays sound when laser blast is created.  (Two sounds are played at the same time.)
        runAction(shootLowNoiseSoundAction)
        runAction(shootNoiseSoundAction)

        gun = 3
    }


    func shootLaserThree()
    {
        blueLaserThree = SKSpriteNode(imageNamed: "bluelaserwhiteborder")

        blueLaserThree!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        blueLaserThree!.position = CGPoint(x: playerNode!.position.x - 25, y: playerNode!.position.y)

        blueLaserThree!.physicsBody = SKPhysicsBody(circleOfRadius: blueLaserThree!.size.width / 2)

        blueLaserThree!.physicsBody!.dynamic = true

        blueLaserThree!.name = "blue_laser"

        blueLaserThree!.physicsBody!.categoryBitMask = CollisionCategoryBlueLaser
        //blueLaserThree!.physicsBody!.contactTestBitMask = CollisionCategoryBadGuyTest
        blueLaserThree!.physicsBody!.collisionBitMask = 0

        addChild(blueLaserThree!)

        // Creates the action that moves the laser blast up the screen.
        let moveUpAction = SKAction.moveToY(self.size.height + 20, duration: 0.8)
        let moveRightAction = SKAction.moveToX(playerNode!.position.x, duration: 0.6)

        // Runs the action.
        blueLaserThree!.runAction(moveUpAction)
        blueLaserThree!.runAction(moveRightAction)


        // Plays sound when laser blast is created.  (Two sounds are played at the same time.)
        runAction(shootLowNoiseSoundAction)
        runAction(shootNoiseSoundAction)

        gun = 4
    }


    func shootLaserFour()
    {
        blueLaserFour = SKSpriteNode(imageNamed: "redlaserwhiteborder")

        blueLaserFour!.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        blueLaserFour!.position = CGPoint(x: playerNode!.position.x + 25, y: playerNode!.position.y)

        blueLaserFour!.physicsBody = SKPhysicsBody(circleOfRadius: blueLaserFour!.size.width / 2)

        blueLaserFour!.physicsBody!.dynamic = true

        blueLaserFour!.name = "blue_laser"

        blueLaserFour!.physicsBody!.categoryBitMask = CollisionCategoryBlueLaser
        //blueLaserFour!.physicsBody!.contactTestBitMask = CollisionCategoryBadGuyTest
        blueLaserFour!.physicsBody!.collisionBitMask = 0

        addChild(blueLaserFour!)

        // Creates the action that moves the laser blast up the screen.
        let moveUpAction = SKAction.moveToY(self.size.height + 20, duration: 0.8)
        let moveLeftAction = SKAction.moveToX(playerNode!.position.x, duration: 0.6)
        
        // Runs the action.
        blueLaserFour!.runAction(moveUpAction)
        blueLaserFour!.runAction(moveLeftAction)
        
        // Plays sound when laser blast is created.  (Two sounds are played at the same time.)
        runAction(shootLowNoiseSoundAction)
        runAction(shootNoiseSoundAction)
        
        gun = 1
    }







    
    


}
















//    func nodeForExplosion()
//    {
//        explosiontest = SKSpriteNode(imageNamed: "badguytest")
//
//        explosiontest!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//
//        explosiontest!.position = CGPoint(x: self.size.width / 2, y: 300)
//
//        explosiontest!.physicsBody = SKPhysicsBody(circleOfRadius: badguytest!.size.width / 2)
//
//        explosiontest!.physicsBody!.dynamic = true
//
//        addChild(explosiontest!)
//    }




























