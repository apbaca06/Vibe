//
//  RingtoneManager.swift
//  i-Chat
//
//  Created by cindy on 2017/12/19.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import AVFoundation

class RingtoneManager {

    static let shared = RingtoneManager()

    var ringPlayer: AVAudioPlayer = AVAudioPlayer()

    func playRingtone() {
        do {

            let audioPath = Bundle.main.path(forResource: "iphone", ofType: "mp3")

            let url = URL.init(fileURLWithPath: audioPath!)

            try ringPlayer = AVAudioPlayer(contentsOf: url)

//            let audioSession = AVAudioSession.sharedInstance()
//            
////            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .mixWithOthers)
//            
//            try audioSession.setMode(AVAudioSessionPortBuiltInReceiver)
//            
//            try audioSession.setActive(true)
//            audioSession.setCategory
//            session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker, error: nil)

//            AVAudioSession.setCategory(<#T##AVAudioSession#>)
//            AVAudioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker, error: nil)
//
//            AVAudioSession.sharedInstance().setActive(true, error: nil)

            ringPlayer.numberOfLoops = 5

            ringPlayer.play()

        } catch {
            let error = error
        }
    }
}
