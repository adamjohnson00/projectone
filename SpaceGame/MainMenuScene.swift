//
//  MainMenuScene.swift
//  SpaceGame
//
//  Created by Adam Johnson on 6/24/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

import SpriteKit
import CoreMotion


class MainMenuScene: SKScene
{

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }


    override init(size: CGSize)
    {
        super.init(size: size)

        backgroundColor = SKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)

    }



    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {

        let transition = SKTransition.fadeWithDuration(1.5)
        let gameScene = GameScene(size: size)

        view?.presentScene(gameScene, transition: transition)
    }
    


}