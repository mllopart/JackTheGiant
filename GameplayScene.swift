//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/18/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene , SKPhysicsContactDelegate {
    
    var mainCamera: SKCameraNode?;
    
    var cloudsControler = CloudsController();
    
    var bg1: BGClass?;
    var bg2: BGClass?;
    var bg3: BGClass?;
    
    var player: Player?;
    
    var canMove = false;
    var moveLeft = false;
    
    var centerScreen: CGFloat?;
    var distanceBetweenClouds = CGFloat(240);
    let minX = CGFloat(-160);
    let maxX = CGFloat(160);
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat();
    private var pausePanel: SKSpriteNode?;
    private let playerMinX = CGFloat(-214);
    private let playerMaxX = CGFloat(214);
    
    private var acceleration = CGFloat();
    private var cameraSpeed = CGFloat();
    private var maxSpeed = CGFloat();
    
    override func didMove(to view: SKView) {
        initializeVars();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera();
        manageBackgrounds();
        managePlayer();
        createNewClouds();
        player?.setScore();
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            //if GameManager.instance.getIsMusicOn() {
                self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false));
            //}
            
            GameplayController.instance.incLife();
            secondBody.node?.removeFromParent();
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            //if GameManager.instance.getIsMusicOn() {
                self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false));
            //}
            GameplayController.instance.incCoin();
            secondBody.node?.removeFromParent();
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            
            managePlayerDied();

        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            let nodeAtLocation = self.atPoint(location);
            
            if self.scene?.isPaused == false {
                
                if nodeAtLocation.name == "Pause" {
                    self.scene?.isPaused = true;
                    createPausePannel();
                }
                
                if nodeAtLocation.name != "Pause" && nodeAtLocation.name != "Resume" && nodeAtLocation.name != "Quit" {
                    if location.x > centerScreen! {
                        moveLeft = false;
                        player?.animatePlayer(moveLeft: moveLeft);
                    } else {
                        moveLeft = true;
                        player?.animatePlayer(moveLeft: moveLeft);
                    }
                }
                
            } else {
                if nodeAtLocation.name == "Resume" {
                    pausePanel?.removeFromParent();
                    self.scene?.isPaused = false;
                }
                
                if nodeAtLocation.name == "Quit" {
                    pausePanel?.removeFromParent();
                    self.scene?.isPaused = false;
                    let scene = MainMenuScene(fileNamed: "MainMenu");
                    scene!.scaleMode = .aspectFill
                    self.view?.presentScene(scene!, transition: SKTransition.crossFade(withDuration: 1));
                }
            }
        }
        
        canMove = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
        player?.stopPlayerAnimation();
    }
    
    func initializeVars () {
//        print ("GameplayScene loaded");
        
        physicsWorld.contactDelegate = self;
        
        getBackgrounds();
        
        mainCamera=self.childNode(withName: "Main Camera") as! SKCameraNode?;
        player = self.childNode(withName: "Player") as! Player?;
        
        centerScreen = (self.scene?.size.width)! / (self.scene?.size.height)!;
        player?.initializePlayerAndAnimations();
        
        cloudsControler.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: centerScreen!, minX: minX, maxX: maxX, initialClouds: true, player: player!);
        
        //print("The random number is \(cloudsControler.randomBetweenNumbers(firstNum: 2, secondNum: 5))");
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)!-400;
        getLabels();
        GameplayController.instance.initializeVariables();
        setCameraSpeed();
    
    }
    
    func getBackgrounds () {
        bg1 = self.childNode(withName: "BG 1") as! BGClass?;
        bg2 = self.childNode(withName: "BG 2") as! BGClass?;
        bg3 = self.childNode(withName: "BG 3") as! BGClass?;
    }
    
    func managePlayer () {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        
        if (player?.position.x)! > playerMaxX {
            //out of bounds right - we do not allow to go more to the right
            player?.position.x = playerMaxX;
            
        }
        
        if (player?.position.x)! < playerMinX {
            //out of bounds left - we do not allow to go more to the left
            player?.position.x = playerMinX;
            
        }
        
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            
            managePlayerDied();
            
        }
        
        if (player?.position.y)! + (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            self.scene?.isPaused = true;
            
            managePlayerDied();
            
        }
    }
    
    func moveCamera() {
        
        cameraSpeed = cameraSpeed + acceleration;
        
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed;
        }
        
        self.mainCamera?.position.y -= cameraSpeed;
        
    }
    
    func manageBackgrounds () {
        bg1?.moveBG(camera: mainCamera!);
        bg2?.moveBG(camera: mainCamera!);
        bg3?.moveBG(camera: mainCamera!);
    }
    
    func createNewClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)!-400;
            
            //we create new clouds in the scene
            cloudsControler.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: centerScreen!, minX: minX, maxX: maxX, initialClouds: false, player:player!);
            
            checkForChildsOutOffScreen();
        }
    }
    
    func checkForChildsOutOffScreen() {
        
        for child in children {
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                
                let childName = child.name?.components(separatedBy: " ");
                
                if childName![0] != "BG" {
                    print("The child removed is \(child.name!)");
                    child.removeFromParent();
                }
                
            }
        }
        
    }
    
    func getLabels() {
        GameplayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score text") as! SKLabelNode?;
        GameplayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as! SKLabelNode?;
        GameplayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as! SKLabelNode?;
    }
    
    func createPausePannel () {
        
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu");
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button");
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2");
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pausePanel?.xScale = 1.6;
        pausePanel?.yScale = 1.6;
        pausePanel?.zPosition = 5;
        pausePanel?.position=CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2 );
        
        resumeBtn.name = "Resume";
        resumeBtn.zPosition = 6;
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        resumeBtn.position=CGPoint(x:(pausePanel?.position.x)!, y:(pausePanel?.position.y)! + 25)
        
        quitBtn.name = "Quit";
        quitBtn.zPosition = 6;
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        quitBtn.position=CGPoint(x:(pausePanel?.position.x)!, y:(pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeBtn);
        pausePanel?.addChild(quitBtn);
        
        self.mainCamera?.addChild(pausePanel!);
        
    }
    
    func createEndScorePanel() {
        
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score");
        let scoreLabel = SKLabelNode(fontNamed: "Blow");
        let coinLabel = SKLabelNode(fontNamed: "Blow");
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        endScorePanel.zPosition = 8;
        endScorePanel.xScale = 1.5;
        endScorePanel.xScale = 1.5;
        
        scoreLabel.fontSize = 40;
        scoreLabel.zPosition = 7;
        
        coinLabel.fontSize = 40;
        coinLabel.zPosition = 7;
        
        endScorePanel.position=CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2 );
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y:endScorePanel.position.y + 10);
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y:endScorePanel.position.y - 105);
        
        coinLabel.text = String(GameplayController.instance.coinScore!);
        scoreLabel.text = String(GameplayController.instance.score!);
        
        endScorePanel.addChild(scoreLabel);
        endScorePanel.addChild(coinLabel);
        
        mainCamera?.addChild(endScorePanel);
        
        
    }
    
    
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty() {
            acceleration = 0.001;
            cameraSpeed = 1.5;
            maxSpeed = 4;
        } else if GameManager.instance.getMediumDifficulty() {
            acceleration = 0.002;
            cameraSpeed = 2.0;
            maxSpeed = 6;
        } else if GameManager.instance.getHardDifficulty() {
            acceleration = 0.003;
            cameraSpeed = 2.5;
            maxSpeed = 8;
        }
    }
    
    private func managePlayerDied (){
        
        self.scene?.isPaused = true;
        player?.removeFromParent();
        
        GameplayController.instance.lifes = GameplayController.instance.lifes! - 1;
        
        if GameplayController.instance.lifes! >= 0 {
            
            GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.lifes!)";
            Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        } else {
            createEndScorePanel();
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        
        
    }
    
    func playerDied() {
        
        
        if GameplayController.instance.lifes! >= 0 {
            
            GameManager.instance.gameRestartedPlayerDied = true;
            
            let scene = GameplayScene(fileNamed: "GameplayScene");
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
            
        } else {
            
            
            if GameManager.instance.getEasyDifficulty() {
                let highscore = GameManager.instance.getEasyDifficultyScore();
                let coinscore = GameManager.instance.getEasyDifficultyScoreCoins();
                
                if highscore < GameplayController.instance.score! {
                    GameManager.instance.setEasyDifficultyScore(easyDifficultyScore: GameplayController.instance.score!);
                }
                
                if coinscore < GameplayController.instance.coinScore! {
                    GameManager.instance.setEasyDifficultyCoinScore(easyDifficultyCoinScore: GameplayController.instance.coinScore!);
                }
            } else if GameManager.instance.getMediumDifficulty() {
                let highscore = GameManager.instance.getMediumDifficultyScore();
                let coinscore = GameManager.instance.getMediumDifficultyScoreCoins();
                
                if highscore < GameplayController.instance.score! {
                    GameManager.instance.setMediumDifficultyScore(mediumDifficultyScore: GameplayController.instance.score!);
                }
                
                if coinscore < GameplayController.instance.coinScore! {
                    GameManager.instance.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: GameplayController.instance.coinScore!);
                }
                
            } else if GameManager.instance.getHardDifficulty() {
                let highscore = GameManager.instance.getHardDifficultyScore();
                let coinscore = GameManager.instance.getHardDifficultyScoreCoins();
                
                if highscore < GameplayController.instance.score! {
                    GameManager.instance.setHardDifficultyScore(hardDifficultyScore: GameplayController.instance.score!);
                }
                
                if coinscore < GameplayController.instance.coinScore! {
                    GameManager.instance.setHardDifficultyCoinScore(hardDifficultyCoinScore: GameplayController.instance.coinScore!);
                }
            }
            
            
            GameManager.instance.saveData();
            
            
            self.scene?.isPaused = false;
            let scene = MainMenuScene(fileNamed: "MainMenu");
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.crossFade(withDuration: 1));
            
        }
    }
}
