//
//  CloudController.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/25/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class CloudsController {
    
    var lastCloudPositionY = CGFloat();
    
    func shuffle( cloudsArray: [SKSpriteNode]) -> [SKSpriteNode] {
        
        var cloArr = cloudsArray;
        
        for i in (1...cloudsArray.count-1).reversed() {
            
            let j = Int(arc4random_uniform(UInt32(i-1)));
            
            swap(&cloArr[i], &cloArr[j]);
            
        }
        
        return cloArr;
    }
    
    func randomBetweenNumbers (firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);        
    }
    
    func createClouds () -> [SKSpriteNode] {
        var clouds = [SKSpriteNode] ();
        
        for _ in 0..<2  {
            
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1");
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2");
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3");
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud");
            
            
            cloud1.name = "cloud1";
            cloud1.xScale = 0.9;
            cloud1.yScale = 0.9;
            
            cloud2.name = "cloud2";
            cloud2.xScale = 0.9;
            cloud2.yScale = 0.9;
            
            cloud3.name = "cloud3";
            cloud3.xScale = 0.9;
            cloud3.yScale = 0.9;
            
            darkCloud.name = "Dark Cloud";
            darkCloud.xScale = 0.9;
            darkCloud.yScale = 0.9;
            
            cloud1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud1.size.width-6, height: cloud1.size.height-7))
            cloud1.physicsBody?.affectedByGravity = false;
            cloud1.physicsBody?.restitution = 0;
            cloud1.physicsBody?.categoryBitMask = ColliderType.Cloud;
            cloud1.physicsBody?.collisionBitMask = ColliderType.Player;
            
            cloud2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud2.size.width-6, height: cloud2.size.height-7))
            cloud2.physicsBody?.affectedByGravity = false;
            cloud2.physicsBody?.restitution = 0;
            cloud2.physicsBody?.categoryBitMask = ColliderType.Cloud;
            cloud2.physicsBody?.collisionBitMask = ColliderType.Player;
            
            cloud3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cloud3.size.width-6, height: cloud3.size.height-7))
            cloud3.physicsBody?.affectedByGravity = false;
            cloud3.physicsBody?.restitution = 0;
            cloud3.physicsBody?.categoryBitMask = ColliderType.Cloud;
            cloud3.physicsBody?.collisionBitMask = ColliderType.Player;
            
            darkCloud.physicsBody = SKPhysicsBody(rectangleOf: darkCloud.size)
            darkCloud.physicsBody?.affectedByGravity = false;
            darkCloud.physicsBody?.restitution = 0;
            darkCloud.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectables;
            darkCloud.physicsBody?.collisionBitMask = ColliderType.Player;
            
            clouds.append(cloud1);
            clouds.append(cloud2);
            clouds.append(cloud3);
            clouds.append(darkCloud);
            
        }
        
        clouds = shuffle(cloudsArray: clouds);
        return clouds;
    }
    
    func arrangeCloudsInScene(scene:SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        
        var clouds = createClouds();
        var positionY = CGFloat();
        
        if initialClouds {
            
            while (clouds[0].name == "Dark Cloud") {
                //shuffle the cloud array
                clouds = shuffle(cloudsArray: clouds);
            }
            
            positionY = center - 100;
            
        } else {
            positionY = lastCloudPositionY;
        }
        
        var random = 0;
        
        for index in 0...clouds.count - 1 {
            
            var  randomX = CGFloat();
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX);
                random = 1;
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX);
                random = 0;
            }
            
            clouds[index].position = CGPoint(x:randomX, y:positionY);
            clouds[index].zPosition = 3;
            
            scene.addChild(clouds[index]);
            positionY -= distanceBetweenClouds;
            lastCloudPositionY = positionY;
            
        }
        
        
    }
    
    
    
}
