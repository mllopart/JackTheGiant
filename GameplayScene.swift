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
            GameplayController.instance.incLife();
            secondBody.node?.removeFromParent();
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            GameplayController.instance.incCoin();
            secondBody.node?.removeFromParent();
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            //death
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
                
                if location.x > centerScreen! {
                    moveLeft = false;
                    player?.animatePlayer(moveLeft: moveLeft);
                } else {
                    moveLeft = true;
                    player?.animatePlayer(moveLeft: moveLeft);
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
        
        cloudsControler.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: centerScreen!, minX: minX, maxX: maxX, initialClouds: true);
        
        //print("The random number is \(cloudsControler.randomBetweenNumbers(firstNum: 2, secondNum: 5))");
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)!-400;
        getLabels();
        GameplayController.instance.initializeVariables();
    
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
    }
    
    func moveCamera() {
        self.mainCamera?.position.y -= 3;
        
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
            cloudsControler.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: centerScreen!, minX: minX, maxX: maxX, initialClouds: false);
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
}
