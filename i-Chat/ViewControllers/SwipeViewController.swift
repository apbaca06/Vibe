//
//  SwipeViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/13.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class SwipeViewController: UIViewController, QBRTCAudioSessionDelegate {

    var session: QBRTCSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.dismiss()

        // self class must conform to QBRTCClientDelegate protocol
        QBRTCClient.instance().add(self)

        QBRTCAudioSession.instance().initialize()

    }

    @IBAction func callAction(_ sender: UIButton) {

        audioCall()

    }

    func audioCall() {

        let opponentsIDs: [NSNumber] = [38855767]

        let newSession = QBRTCClient.instance().createNewSession(

            withOpponents: opponentsIDs,

            with: QBRTCConferenceType.audio
        )

        // userInfo - the custom user information dictionary for the call. May be nil.
        let userInfo: [String: String] = ["name": "john"]

        QBRTCConfig.setAnswerTimeInterval(60)

        newSession.startCall(userInfo)
    }
}

extension SwipeViewController: QBRTCClientDelegate {

    // MARK: 當別人打電話給你
    func didReceiveNewSession(session: QBRTCSession!, _ userInfo: [String: String]) {

        if self.session != nil {
            // we already have a video/audio call session, so we reject another one
            // userInfo - the custom user information dictionary for the call from caller. May be nil.
//            let userInfo: [String: String] = ["key": "value"]
            session.rejectCall(userInfo)
            print("已有電話,拒接")
        } else {
            print("準備接電話")
            self.session = session
            let ringViewController = RingViewController()
            self.present(ringViewController, animated: true, completion: nil)
        }
    }

    func session(_ session: QBRTCBaseSession, receivedRemoteAudioTrack audioTrack: QBRTCAudioTrack, fromUser userID: NSNumber) {


    }

    // MARK: 當別人沒接電話
    func session(session: QBRTCSession!, userDidNotRespond userID: NSNumber!) {
        print("User \(userID) did not respond to your call within timeout")
    }

    // MARK: 當別人拒絕接電話
    func session(session: QBRTCSession!, rejectedByUser userID: NSNumber!, userInfo: [NSObject: AnyObject]!) {
        print("Rejected by user \(userID)")
    }

    // MARK: 當別人接你的電話
    func session(_ session: QBRTCSession, acceptedByUser userID: NSNumber, userInfo: [String: String]? = nil) {

    }

    // MARK: 當別人掛掉你的電話
    func session(_ session: QBRTCSession, hungUpByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        //For example:Update GUI
        //
        // Or
        /**
         HangUp when initiator ended a call
         */
        if session.initiatorID.isEqual(to: userID) {
            session.hangUp(userInfo)
        }
    }

    // MARK: Session 開始連接
    func session(session: QBRTCSession!, startedConnectingToUser userID: NSNumber!) {
        print("Started connecting to user \(userID)")
    }

    // MARK: 關掉 連接的session
    func session(session: QBRTCSession!, connectionClosedForUser userID: NSNumber!) {
        print("Connection is closed for user \(userID)")
    }

    // MARK: 已連接session到別的user
    func session(session: QBRTCSession!, connectedToUser userID: NSNumber!) {
        print("Connection is established with user \(userID)")
    }

    // MARK: 停止連接session到別的user
    func session(session: QBRTCSession!, disconnectedFromUser userID: NSNumber!) {
        print("Disconnected from user \(userID)")
    }

    // MARK: 無法連接session
    func session(session: QBRTCSession!, connectionFailedForUser userID: NSNumber!) {
        print("Connection has failed with user \(userID)")
    }

}
