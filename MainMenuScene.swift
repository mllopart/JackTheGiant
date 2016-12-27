//
//  MainMenuScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/26/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var highscoreBtn: SKSpriteNode?;
    var optionsBtn: SKSpriteNode?;
    var startGameBtn: SKSpriteNode?;
    var quitGameBtn: SKSpriteNode?;
    var soundBtn: SKSpriteNode?;
    
    
    override func didMove(to view: SKView) {
        
        highscoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode!;
        optionsBtn = self.childNode(withName: "Options") as? SKSpriteNode!;
        startGameBtn = self.childNode(withName: "Start Game") as? SKSpriteNode!;
        soundBtn = self.childNode(withName: "Music") as? SKSpriteNode!;
        quitGameBtn = self.childNode(withName: "Quit") as? SKSpriteNode!;
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            let nodeAtLocation = self.atPoint(location);
            
            if nodeAtLocation == highscoreBtn {
                print("Highscore");
                
                let scene = HighscoreScene(fileNamed: "HighscoreScene");
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
                
            }
            
            if nodeAtLocation == optionsBtn {
                let scene = OptionScene(fileNamed: "OptionScene");
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
            }
            
            if nodeAtLocation == startGameBtn {
                let scene = GameplayScene(fileNamed: "GameplayScene");
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!);
            }
            
            if nodeAtLocation == soundBtn {
                print("Sound");
            }
            
            if nodeAtLocation == quitGameBtn {
                print("Quit");
            }
            
        }
        
    }

}
