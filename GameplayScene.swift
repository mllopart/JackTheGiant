//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/18/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
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
    
    override func didMove(to view: SKView) {
        initializeVars();
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera();
        manageBackgrounds();
        managePlayer();
        createNewClouds();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self);
            
            if location.x > centerScreen! {
                moveLeft = false;
                player?.animatePlayer(moveLeft: moveLeft);
            } else {
                moveLeft = true;
                player?.animatePlayer(moveLeft: moveLeft);
            }
        }
        
        canMove = true;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false;
        player?.stopPlayerAnimation();
    }
    
    func initializeVars () {
        print ("GameplayScene loaded");
        
        getBackgrounds();
        
        
        mainCamera=self.childNode(withName: "Main Camera") as! SKCameraNode?;
        player = self.childNode(withName: "Player") as! Player?;
        
        centerScreen = (self.scene?.size.width)! / (self.scene?.size.height)!;
        player?.initializePlayerAndAnimations();
        
        cloudsControler.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: centerScreen!, minX: minX, maxX: maxX, initialClouds: true);
        
        //print("The random number is \(cloudsControler.randomBetweenNumbers(firstNum: 2, secondNum: 5))");
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)!-400;
    
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
}
