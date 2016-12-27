//
//  OptionScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/26/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            let nodeAtLocation = self.atPoint(location);
            
            if nodeAtLocation.name == "Back Button" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.crossFade(withDuration: 1));
            }
            
        }
        
    }

}
