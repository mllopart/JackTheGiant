//
//  BGClass.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 12/25/16.
//  Copyright © 2016 The Fox Game Studio. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    func moveBG(camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3;
        }
    }
}
