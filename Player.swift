//
//  Player.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/18/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas();
    private var playerAnimation = [SKTexture]();
    private var animatePlayerAction = SKAction();
    private let lTimePerFrame = 0.08;
    
    
    func initializePlayerAndAnimations() {
        textureAtlas = SKTextureAtlas(named: "Player.atlas");
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)";
            playerAnimation.append(SKTexture(imageNamed: name));
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: lTimePerFrame, resize: true, restore: false)
    }
    
    func animatePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale);
        } else {
            self.xScale = fabs(self.xScale);
        }
        
        self.run(SKAction.repeatForever((animatePlayerAction)) , withKey: "Animate");
    }
    
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate");
        self.texture = SKTexture(imageNamed:"Player 1");
        self.size = (self.texture?.size())!;
    
    }
    
    func movePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.position.x = self.position.x - 7;
        } else {
            self.position.x = self.position.x + 7;
        }
    }
    
}
