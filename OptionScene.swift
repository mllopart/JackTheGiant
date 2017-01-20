//
//  OptionScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/26/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    
    private var easyBtn: SKSpriteNode?;
    private var mediumBtn: SKSpriteNode?;
    private var hardBtn: SKSpriteNode?;
    private var sign: SKSpriteNode?;
    
    override func didMove(to view: SKView) {
        initializeVariables();
        setSign();
    }
    
    func initializeVariables() {
        easyBtn = self.childNode(withName: "Easy Button") as? SKSpriteNode!;
        mediumBtn = self.childNode(withName: "Medium Button") as? SKSpriteNode!;
        hardBtn = self.childNode(withName: "Hard Button") as? SKSpriteNode!;
        sign = self.childNode(withName: "Sign") as? SKSpriteNode!;
    }
    
    private func setSign() {
        if GameManager.instance.getEasyDifficulty() {
            sign?.position.y = (easyBtn?.position.y)!;
        }
        
        if GameManager.instance.getMediumDifficulty() {
            sign?.position.y = (mediumBtn?.position.y)!;
        }
        
        if GameManager.instance.getHardDifficulty() {
            sign?.position.y = (hardBtn?.position.y)!;
        }

    }
    
    private func setDifficulty(difficulty: String) {
        
        switch (difficulty) {
            case "easy":
                GameManager.instance.setEasyDifficulty(easyDifficulty: true);
                GameManager.instance.setMediumDifficulty(mediumDifficulty: false);
                GameManager.instance.setHardDifficulty(hardDifficulty: false);
                break;
            case "medium":
                GameManager.instance.setEasyDifficulty(easyDifficulty: false);
                GameManager.instance.setMediumDifficulty(mediumDifficulty: true);
                GameManager.instance.setHardDifficulty(hardDifficulty: false);
                break;
            case "hard":
                GameManager.instance.setEasyDifficulty(easyDifficulty: false);
                GameManager.instance.setMediumDifficulty(mediumDifficulty: false);
                GameManager.instance.setHardDifficulty(hardDifficulty: true);
                break;
        default:
            break;
        }
        
        GameManager.instance.saveData();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            let nodeAtLocation = self.atPoint(location);
            
            if nodeAtLocation == easyBtn {
                setDifficulty(difficulty: "easy");
                sign?.position.y = (easyBtn?.position.y)!;
            } else if nodeAtLocation == mediumBtn {
                setDifficulty(difficulty: "medium");
                sign?.position.y = (mediumBtn?.position.y)!;
            } else if nodeAtLocation == hardBtn {
                setDifficulty(difficulty: "hard");
                sign?.position.y = (hardBtn?.position.y)!;
            }
            
            sign?.zPosition = 4;
            
            if nodeAtLocation.name == "Back Button" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.crossFade(withDuration: 1));
            }
            
        }
        
    }

}
