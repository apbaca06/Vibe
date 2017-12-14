////
////  ChatroomViewController.swift
////  i-Chat
////
////  Created by cindy on 2017/12/14.
////  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
////
//
//import Foundation
//import UIKit
//import AudioToolbox
//
//class ChatroomViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        
//        //Save current audio configuration before start call or accept call
//        QBRTCAudioSession.instance().initialize()
//        //OR you can initialize audio session with a specific configuration
//        QBRTCAudioSession.instance().initialize { (configuration) -> () in
//            // adding blutetooth support
//            configuration.categoryOptions |= AVAudioSessionCategoryOptionAllowBluetooth
//            configuration.categoryOptions |= AVAudioSessionCategoryOptionAllowBluetoothA2DP
//            
//            // adding airplay support
//            configuration.categoryOptions |= AVAudioSessionCategoryOptionAllowAirPlay
//            
//            if (_session.conferenceType == QBRTCConferenceTypeVideo) {
//                // setting mode to video chat to enable airplay audio and speaker only for video call
//                configuration.mode = AVAudioSessionModeVideoChat
//            }
//        }
//        //Set headphone or phone receiver
//        QBRTCAudioSession.instance().currentAudioDevice = QBRTCAudioDeviceReceiver
//        //or set speaker
//        QBRTCAudioSession.instance().currentAudioDevice = QBRTCAudioDeviceSpeaker
//        //deinitialize after session close
//        QBRTCAudioSession.instance().deinitialize()
//    }
//}
