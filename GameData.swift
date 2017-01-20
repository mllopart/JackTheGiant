//
//  GameData.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 1/8/17.
//  Copyright © 2017 The Fox Game Studio. All rights reserved.
//

import Foundation


class GameData :  NSObject, NSCoding {
    
    struct Keys {
        
        static let EasyDiffcultyScore = "EasyDiffcultyScore";
        static let MediumDiffcultyScore = "MediumDiffcultyScore";
        static let HardDiffcultyScore = "HardDiffcultyScore";
        
        static let EasyDiffcultyCoinScore = "EasyDiffcultyCoinScore";
        static let MediumDiffcultyCoinScore = "MediumDiffcultyCoinScore";
        static let HardDiffcultyCoinScore = "HardDiffcultyCoinScore";
        
        static let EasyDiffculty = "EasyDiffculty";
        static let MediumDiffculty = "MediumDiffculty";
        static let HardDiffculty = "HardDiffculty";
        
        static let Music = "Music";
    }
    
    private var easyDifficultyScore = Int32();
    private var mediumDifficultyScore = Int32();
    private var hardDifficultyScore = Int32();
    
    private var easyDifficultyCoinScore = Int32();
    private var mediumDifficultyCoinScore = Int32();
    private var hardDifficultyCoinScore = Int32();
    
    private var easyDifficulty = false;
    private var mediumDifficulty = false;
    private var hardDifficulty = false;
    
    private var isMusicOn = false;
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init();
        
        self.easyDifficultyScore = aDecoder.decodeCInt(forKey: "EasyDiffcultyScore");
        self.mediumDifficultyScore = aDecoder.decodeCInt(forKey: "MediumDiffcultyScore");
        self.hardDifficultyScore = aDecoder.decodeCInt(forKey: "HardDiffcultyScore");
        
        self.easyDifficultyCoinScore = aDecoder.decodeCInt(forKey: "EasyDiffcultyCoinScore");
        self.mediumDifficultyCoinScore = aDecoder.decodeCInt(forKey: "MediumDiffcultyCoinScore");
        self.hardDifficultyCoinScore = aDecoder.decodeCInt(forKey: "HardDiffcultyCoinScore");
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: "EasyDiffculty");
        self.mediumDifficulty = aDecoder.decodeBool(forKey: "MediumDiffculty");
        self.hardDifficulty = aDecoder.decodeBool(forKey: "HardDiffculty");
        
        self.isMusicOn = aDecoder.decodeBool(forKey: "Music");
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encodeCInt(self.easyDifficultyScore, forKey: Keys.EasyDiffcultyScore);
        aCoder.encodeCInt(self.mediumDifficultyScore, forKey: Keys.MediumDiffcultyScore);
        aCoder.encodeCInt(self.hardDifficultyScore, forKey: Keys.HardDiffcultyScore);
        
        aCoder.encodeCInt(self.easyDifficultyCoinScore, forKey: Keys.EasyDiffcultyCoinScore);
        aCoder.encodeCInt(self.mediumDifficultyCoinScore, forKey: Keys.MediumDiffcultyCoinScore);
        aCoder.encodeCInt(self.hardDifficultyCoinScore, forKey: Keys.HardDiffcultyCoinScore);
        
        aCoder.encode(easyDifficulty, forKey: Keys.EasyDiffculty);
        aCoder.encode(mediumDifficulty, forKey: Keys.MediumDiffculty);
        aCoder.encode(hardDifficulty, forKey: Keys.HardDiffculty);
        
        aCoder.encode(isMusicOn, forKey: Keys.Music);
        
        
    }
    
    //setters
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore;
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore;
    }
    
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore;
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore;
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore;
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore;
    }
    
    func setEasyDifficulty (easyDifficulty : Bool) {
        self.easyDifficulty = easyDifficulty;
    }
    
    func setMediumDifficulty (mediumDifficulty : Bool) {
        self.mediumDifficulty = mediumDifficulty;
    }
    
    func setHardDifficulty (hardDifficulty : Bool) {
        self.hardDifficulty = hardDifficulty;
    }
    
    func setIsMusicOn (isMusicOn : Bool) {
        self.isMusicOn = isMusicOn;
    }
    
    //geters
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore
    }
    
    func getEasyDifficultyScoreCoins() -> Int32 {
        return self.easyDifficultyCoinScore
    }
    
    func getMediumDifficultyScoreCoins() -> Int32 {
        return self.mediumDifficultyCoinScore
    }
    
    func getHardDifficultyScoreCoins() -> Int32 {
        return self.hardDifficultyCoinScore
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }
    
    
    
}
