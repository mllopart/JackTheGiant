//
//  GameController.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 1/2/17.
//  Copyright © 2017 The Fox Game Studio. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager();
    private init () {}
    
    var gameStartedFromMainMenu = false;
    var gameRestartedPlayerDied = false;
    
}
