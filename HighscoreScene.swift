//
//  HighscoreScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/26/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var highScoreLbl: SKLabelNode?;
    private var coinLbl: SKLabelNode?;
    
    
    override func didMove(to view: SKView) {
        getReference();
        setScore();
    }
    
    private func getReference() {
        highScoreLbl = self.childNode(withName: "Score Label") as? SKLabelNode;
        coinLbl = self.childNode(withName: "Coin Label") as? SKLabelNode;
    }
    
    private func setScore() {
        
        if GameManager.instance.getEasyDifficulty() == true {
            highScoreLbl?.text = String(GameManager.instance.getEasyDifficultyScore());
            coinLbl?.text = String(GameManager.instance.getEasyDifficultyScoreCoins());
        } else if GameManager.instance.getMediumDifficulty() == true {
            highScoreLbl?.text = String(GameManager.instance.getMediumDifficultyScore());
            coinLbl?.text = String(GameManager.instance.getMediumDifficultyScoreCoins());
        } else if GameManager.instance.getHardDifficulty() == true {
            highScoreLbl?.text = String(GameManager.instance.getHardDifficultyScore());
            coinLbl?.text = String(GameManager.instance.getHardDifficultyScoreCoins());
        }
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
