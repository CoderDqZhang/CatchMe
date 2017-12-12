
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

    var audioPlayer:AVAudioPlayer!
    
    override init() {
        super.init()
    }
    
    static let shareInstance = AudioPlayManager()
    
    func playBgMusic(name:String){
        let musicPath = Bundle.main.path(forResource: name, ofType: ".mp3")
        //指定音乐路径
        let url = URL.init(fileURLWithPath: musicPath!)
        do {
            try audioPlayer = AVAudioPlayer.init(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer.numberOfLoops = -1
            //设置音乐播放次数，-1为循环播放
            audioPlayer.volume = 1
            audioPlayer.delegate = self
            //设置音乐音量，可用范围为0~1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch  {
            print("error")
        }
        
    }
    
    func pause(){
        self.audioPlayer.pause()
    }
}

extension AudioPlayManager : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
}

