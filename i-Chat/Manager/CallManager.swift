//
//  CallManager.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase

class CallManager {

    static let shared = CallManager()

    var fromUser: User?

    var toUser: User?

    var session: QBRTCSession?

    func audioCall(toUser opponetUser: User) {

        QBRTCAudioSession.instance().currentAudioDevice = .receiver

        let opponentsIDs: [NSNumber] = [opponetUser.quickbloxID]

        let newSession = QBRTCClient.instance().createNewSession(

            withOpponents: opponentsIDs,

            with: QBRTCConferenceType.audio
        )

        let userInfo: [String: String] = ["Key": "Value"]

        newSession.startCall(userInfo)

        self.session = newSession
    }

}
