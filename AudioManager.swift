//
//  AudioManager.swift
//  Jack The Giant
//
//  Created by Marc Llopart Riera on 1/20/17.
//  Copyright © 2017 The Fox Game Studio. All rights reserved.
//

import AVFoundation

//singleton
class AudioManager {
    
    static let instance = AudioManager();
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?;
    
    func playBGMusic() {
        
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3");
        
        var err: NSError?;
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!);
            audioPlayer?.numberOfLoops = -1;
            audioPlayer?.prepareToPlay();
            audioPlayer?.play();
            
        } catch let err1 as NSError {
            err = err1;
        }
        
        if err != nil {
            print("We have a problem in BG music: \(err)");
        }
        
    }
    
    func stopBGMusic() {
        if (audioPlayer?.play()) != nil {
            audioPlayer?.stop();
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil;
    }
    
}
