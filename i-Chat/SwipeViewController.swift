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

class SwipeViewController: UIViewController {

    var session: QBRTCSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        QBRTCClient.initializeRTC()

        // self class must conform to QBRTCClientDelegate protocol
        QBRTCClient.instance().add(self)

        let opponentsIDs: [NSNumber] = [38845869]

        let newSession = QBRTCClient.instance().createNewSession(

            withOpponents: opponentsIDs,

            with: QBRTCConferenceType.audio
        )

        // userInfo - the custom user information dictionary for the call. May be nil.
        let userInfo: [String: String] = ["key": "value"]

        newSession.startCall(userInfo)

    }
}

extension SwipeViewController: QBRTCClientDelegate {

    // MARK: Called when connection is initiated with user
    func session(session: QBRTCSession!,startedConnectingToUser userID: NSNumber!) {
        print("Started connecting to user \(userID)")
    }

    // MARK: Called when connection is closed for user
    func didReceiveNewSession(session: QBRTCSession!, _ userInfo: [NSObject: AnyObject]!) {

        if self.session != nil {
            // we already have a video/audio call session, so we reject another one
            // userInfo - the custom user information dictionary for the call from caller. May be nil.
            let userInfo: [String: String] = ["key": "value"]
            session.rejectCall(userInfo)
        } else {
            self.session = session
        }
    }

    // MARK: Called in case when connection is established with user:
    func session(_: QBRTCSession!, connectedToUser userID: NSNumber!) {
        print("Connection is established with user \(userID)")
    }

    // MARK: Called in case when user is disconnected
    func session(session: QBRTCSession!, disconnectedFromUser userID: NSNumber!) {
        print("Disconnected from user \(userID)")
    }

    // MARK: Called in case when user did not respond to your call within timeout
    func session(session: QBRTCSession!, userDidNotRespond userID: NSNumber!) {
        print("User \(userID) did not respond to your call within timeout")
    }

    // MARK: Called in case when connection failed with user.
    func session(session: QBRTCSession!, connectionFailedForUser userID: NSNumber!) {
        print("Connection has failed with user \(userID)")
    }

}
