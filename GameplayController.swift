//
//  GameplayController.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 1/2/17.
//  Copyright © 2017 The Fox Game Studio. All rights reserved.
//

import Foundation
import SpriteKit

//singleton
class GameplayController {
    
    static let instance = GameplayController();
    private init () {}
    
    var scoreText: SKLabelNode?;
    var coinText: SKLabelNode?;
    var lifeText: SKLabelNode?;
    
    var score: Int?;
    var coinScore: Int?;
    var lifes: Int?;
    
    
    func initializeVariables () {
        
        if GameManager.instance.gameStartedFromMainMenu {
            
            GameManager.instance.gameStartedFromMainMenu = false;
            
            score = 0;
            coinScore = 0;
            lifes = 2;
            
            scoreText?.text = "\(score!)";
            coinText?.text = "x\(coinScore!)";
            lifeText?.text = "x\(lifes!)";
            
        } else if GameManager.instance.gameRestartedPlayerDied {
            
            GameManager.instance.gameRestartedPlayerDied = false;
            
            scoreText?.text = "\(score!)";
            coinText?.text = "x\(coinScore!)";
            lifeText?.text = "x\(lifes!)";
        }
        
        
        
    }
}