//
//  HomeViewControllerExtension.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

extension HomeViewController: QBRTCClientDelegate {
    
    // MARK: 當別人打電話給你
    func didReceiveNewSession(_ session: QBRTCSession, userInfo: [String: String]? = nil) {
        
        if CallManager.shared.session != nil {
            // we already have a video/audio call session, so we reject another one
            // userInfo - the custom user information dictionary for the call from caller. May be nil.
            //            let userInfo: [String: String] = ["key": "value"]
            session.rejectCall(userInfo)
            print("已有電話,拒接")
        } else {
            print("準備接電話")
            CallManager.shared.session = session
            // swiftlint:disable force_cast
            let ringViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RingViewController") as! RingViewController
            // swiftlint:enable force_cast
            self.present(ringViewController, animated: true, completion: nil)
        }
    }
    
    func session(_ session: QBRTCBaseSession, receivedRemoteAudioTrack audioTrack: QBRTCAudioTrack, fromUser userID: NSNumber) {
        
    }
    
    // MARK: 當別人沒接電話
    func session(_ session: QBRTCSession, userDidNotRespond userID: NSNumber) {
        
        print("User \(userID) did not respond to your call within timeout")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 當別人拒絕接電話
    func session(_ session: QBRTCSession, rejectedByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        print("Rejected by user \(userID)")
        
    }
    
    // MARK: 當別人接受你的電話
    func session(_ session: QBRTCSession, acceptedByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        
    }
    
    // MARK: 當別人掛掉你的電話
    func session(_ session: QBRTCSession, hungUpByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        //For example:Update GUI
        // Or
        /**
         HangUp when initiator ended a call
         */
        if session.initiatorID.isEqual(to: userID) {
            session.hangUp(userInfo)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Session 開始連接
    func session(_ session: QBRTCBaseSession, startedConnectingToUser userID: NSNumber) {
        print("Started connecting to user \(userID)")
        
    }
    
    // MARK: 關掉 連接的session
    func session(_ session: QBRTCBaseSession, connectionClosedForUser userID: NSNumber) {
        
        print("Connection is closed for user \(userID)")
        
        CallManager.shared.session = nil
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 已連接session到別的user
    func session(_ session: QBRTCBaseSession, connectedToUser userID: NSNumber) {
        print("Connection is established with user \(userID)")
        //開始算時間
    }
    
    // MARK: 停止連接session到別的user
    func session(_ session: QBRTCBaseSession, disconnectedFromUser userID: NSNumber) {
        print("Disconnected from user \(userID)")
        //停止算時間
    }
    
    // MARK: 無法連接session
    func session(_ session: QBRTCBaseSession, connectionFailedForUser userID: NSNumber) {
        print("Connection has failed with user \(userID)")
        //        CallManager.shared.session = nil
    }
    
}
