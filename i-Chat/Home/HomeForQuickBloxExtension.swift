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
            session.rejectCall(userInfo)

            print("****已有電話,拒接")

        } else {
            print("****準備接電話")
            CallManager.shared.session = session

            // swiftlint:disable force_cast
            let incomingCallViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IncomingCallViewController") as! IncomingCallViewController
            // swiftlint:enable force_cast

            guard let dict = userInfo,
                  let name = dict["Name"]
                else { return }
//            incomingCallViewController.name.text = name

            self.present(incomingCallViewController, animated: true, completion: nil)
        }
    }

    func session(_ session: QBRTCBaseSession, receivedRemoteAudioTrack audioTrack: QBRTCAudioTrack, fromUser userID: NSNumber) {

        self.dismiss(animated: true, completion: nil)

        RingtoneManager.shared.ringPlayer.stop()

        print("****Recieved remote audio track \(userID)")

        let audioViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AudioViewController")

        self.present(audioViewController, animated: true, completion: nil)

    }

    // MARK: 當別人沒接電話

    func session(_ session: QBRTCSession, userDidNotRespond userID: NSNumber) {

        print("****User \(userID) did not respond to your call within timeout")

        self.dismiss(animated: true, completion: nil)
    }

    // MARK: 當別人拒絕接電話
    func session(_ session: QBRTCSession, rejectedByUser userID: NSNumber, userInfo: [String: String]? = nil) {

        print("****Rejected by user \(userID)")

        CallManager.shared.session = nil

        self.dismiss(animated: true, completion: nil)

    }

    // MARK: 當別人接受你的電話
    func session(_ session: QBRTCSession, acceptedByUser userID: NSNumber, userInfo: [String: String]? = nil) {

        print("****Accepted by user \(userID)")

    }

    // MARK: 當別人掛掉你的電話
    func session(_ session: QBRTCSession, hungUpByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        //For example:Update GUI
        // Or
        /**
//         HangUp when initiator ended a call
//         */
//        if session.initiatorID.isEqual(to: userID) {
//
//            session.hangUp(userInfo)
//
//            print("****Hung up by user \(userID)")
//
//            CallManager.shared.session = nil
//
//            self.dismiss(animated: true, completion: nil)
//        }
        CallManager.shared.session = session
        print("****Hung up by user \(userID)")

        CallManager.shared.session?.hangUp(userInfo)

        CallManager.shared.session = nil

    }

    // MARK: Session 開始連接
    func session(_ session: QBRTCBaseSession, startedConnectingToUser userID: NSNumber) {
        print("****Started connecting to user \(userID)")

    }

    // MARK: 關掉 連接的session
    func session(_ session: QBRTCBaseSession, connectionClosedForUser userID: NSNumber) {

        print("****Connection is closed for user \(userID)")

        CallManager.shared.session = nil

        self.dismiss(animated: true, completion: nil)
    }

    // MARK: 已連接session到別的user
    func session(_ session: QBRTCBaseSession, connectedToUser userID: NSNumber) {
        print("****Connection is established with user \(userID)")

    }

    // MARK: 停止連接session到別的user
    func session(_ session: QBRTCBaseSession, disconnectedFromUser userID: NSNumber) {
        print("****Disconnected from user \(userID)")
        //停止算時間
    }

    // MARK: 無法連接session
    func session(_ session: QBRTCBaseSession, connectionFailedForUser userID: NSNumber) {
        print("****Connection has failed with user \(userID)")
        CallManager.shared.session = nil
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: 停止session
    func sessionDidClose(_ session: QBRTCSession) {

        print("****Connection has closed with user")

        RingtoneManager.shared.ringPlayer.stop()

        CallManager.shared.session = nil
        self.dismiss(animated: true, completion: nil)
    }

}
