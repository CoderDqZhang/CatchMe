
//
//  AudioPlayManager.swift
//  CatchMe
//
//  Created by Zhang on 09/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayManager: NSObject {
    var avPlay:AVPlayer!

    override init() {
        super.init()
        self.avPlay = AVPlayer.init()
    }
    
    static let shareInstance = AudioPlayManager()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func playAudio(){
        self.avPlay.replaceCurrentItem(with: self.getMuiscItem())
        NotificationCenter.default.addObserver(self, selector: #selector(self.playAgain), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func getMuiscItem() -> AVPlayerItem {
        let audioFile = Bundle.main.path(forResource: "music", ofType: ".mov")
        let url = URL.init(fileURLWithPath: audioFile!)
        let item = AVPlayerItem.init(url: url)
        return item
    }
    
    @objc func playAgain(){
        self.play()
    }
    
    func play(){
        if self.avPlay.currentItem == nil {
            self.playAudio()
        }else{
            self.avPlay.replaceCurrentItem(with: self.getMuiscItem())
        }
        self.avPlay.play()
    }
    
    func pause(){
        self.avPlay.pause()
    }
}

