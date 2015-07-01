//
//  MainMenuScene.swift
//  SpaceGame
//
//  Created by Adam Johnson on 6/24/15.
//  Copyright (c) 2015 Adam. All rights reserved.


import SpriteKit
import CoreMotion


class MainMenuScene: SKScene
{
    var titleLabel = SKLabelNode(fontNamed: "Thonburi-Light")
    var tapScreenLabel = SKLabelNode(fontNamed: "SpaceOne")
    
    var backgroundOne : SKSpriteNode?
    var backgroundTwo : SKSpriteNode?


    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }


    override init(size: CGSize)
    {
        super.init(size: size)

        backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        addBackground()
        
        addBackgroundTwo()
        
        addMainMenuSceneLabels()
    }
    
    func addBackground()
    {
        backgroundOne = SKSpriteNode(imageNamed: "sparsespace")
        backgroundOne!.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundOne!.position = CGPoint(x: self.size.width / 2.0, y: 0)
        
        addChild(backgroundOne!)
    }
    
    
    func addBackgroundTwo()
    {
        backgroundTwo = SKSpriteNode(imageNamed: "sparsespace")
        backgroundTwo!.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundTwo!.position = CGPoint(x: self.size.width / 4.0, y: backgroundOne!.position.y + backgroundOne!.size.height)
        
        addChild(backgroundTwo!)
    }



    func addMainMenuSceneLabels()
    {
        titleLabel.text = "Space Savior"
        titleLabel.fontSize = 40
        titleLabel.fontColor = SKColor.whiteColor()
        titleLabel.position = CGPointMake(size.width / 2, size.height / 2 + 80)
        addChild(titleLabel)

        tapScreenLabel.text = "Tap Screen To Begin"
        tapScreenLabel.fontSize = 25
        tapScreenLabel.fontColor = SKColor.whiteColor()
        tapScreenLabel.position = CGPointMake(size.width / 2, size.height / 2 - 80)
        addChild(tapScreenLabel)
    }


    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {

        let transition = SKTransition.fadeWithDuration(1.5)
        let gameScene = GameScene(size: size)

        view?.presentScene(gameScene, transition: transition)
    }
    
    override func update(currentTime: NSTimeInterval)
    {
        backgroundOne!.position = CGPointMake(self.size.width / 2, backgroundOne!.position.y - 6)
        
        backgroundTwo!.position = CGPointMake(self.size.width / 2, backgroundTwo!.position.y - 6)
        
        if backgroundOne!.position.y < -800 //-backgroundOne!.size.height
        {
            backgroundOne!.position = CGPointMake(self.size.width / 2, backgroundTwo!.position.y + 800)
        }
        
        if backgroundTwo!.position.y < -800 //-backgroundTwo!.size.height
        {
            backgroundTwo!.position = CGPointMake(self.size.width / 2, backgroundOne!.position.y + 800)
        }
    }
}
