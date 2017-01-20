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
    
    private var gameData: GameData?;
    
    var gameStartedFromMainMenu = false;
    var gameRestartedPlayerDied = false;
    
    func initializeGameData () {
        
        let manager = FileManager.default;
        
        
        if !manager.fileExists(atPath: getFilePath() as String) {
            gameData = GameData();
            
            gameData?.setEasyDifficultyScore(easyDifficultyScore: 0);
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0);
            
            gameData?.setMediumDifficultyScore(mediumDifficultyScore: 0);
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0);
            
            gameData?.setHardDifficultyScore(hardDifficultyScore: 0);
            gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: 0);
            
            gameData?.setEasyDifficulty(easyDifficulty: false);
            gameData?.setMediumDifficulty(mediumDifficulty: true);
            gameData?.setHardDifficulty(hardDifficulty: false);
            
            gameData?.setIsMusicOn(isMusicOn: true);
            
            saveData();
        }
        
        loadData();
    }
    
    func loadData() {
        
        gameData = (NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData);
    }
    
    func saveData() {
        
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String);
        }
    }
    
    private func getFilePath() -> String {
        
        let manager = FileManager.default;
        
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        
        return url!.appendingPathComponent("Game Manager Fox").path;
    }
    
    
    //setters
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.gameData?.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore);
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.gameData?.setMediumDifficultyScore(mediumDifficultyScore: mediumDifficultyScore);
    }
    
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.gameData?.setHardDifficultyScore(hardDifficultyScore: hardDifficultyScore);
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyCoinScore);
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumDifficultyCoinScore);
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardDifficultyCoinScore);
    }
    
    func setEasyDifficulty (easyDifficulty : Bool) {
        self.gameData?.setEasyDifficulty(easyDifficulty: easyDifficulty);
    }
    
    func setMediumDifficulty (mediumDifficulty : Bool) {
        self.gameData?.setMediumDifficulty(mediumDifficulty: mediumDifficulty);
    }
    
    func setHardDifficulty (hardDifficulty : Bool) {
        self.gameData?.setHardDifficulty(hardDifficulty: hardDifficulty);
    }
    
    func setIsMusicOn (isMusicOn : Bool) {
        self.gameData?.setIsMusicOn(isMusicOn: isMusicOn);
    }
    
    //getters
    func getEasyDifficultyScore() -> Int32 {
        return (self.gameData?.getEasyDifficultyScore())!;
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return (self.gameData?.getMediumDifficultyScore())!;
    }
    
    func getHardDifficultyScore() -> Int32 {
        return (self.gameData?.getHardDifficultyScore())!;
    }
    
    func getEasyDifficultyScoreCoins() -> Int32 {
        return (self.gameData?.getEasyDifficultyScoreCoins())!;
    }
    
    func getMediumDifficultyScoreCoins() -> Int32 {
        return (self.gameData?.getMediumDifficultyScoreCoins())!;
    }
    
    func getHardDifficultyScoreCoins() -> Int32 {
        return (self.gameData?.getHardDifficultyScoreCoins())!;
    }
    
    func getEasyDifficulty() -> Bool {
        return (self.gameData?.getEasyDifficulty())!;
    }
    
    func getMediumDifficulty() -> Bool {
        return (self.gameData?.getMediumDifficulty())!;
    }
    
    func getHardDifficulty() -> Bool {
        return (self.gameData?.getHardDifficulty())!;
    }
    
    func getIsMusicOn() -> Bool {
        return (self.gameData?.getIsMusicOn())!;
    }
    
}
