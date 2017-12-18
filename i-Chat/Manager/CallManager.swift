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

    static func audioCall(toUser opponetUser: User) {

        let opponentsIDs: [NSNumber] = [opponetUser.quickbloxID]

        let newSession = QBRTCClient.instance().createNewSession(

            withOpponents: opponentsIDs,

            with: QBRTCConferenceType.audio
        )

        let userInfo: [String: String] = ["Key": "Value"]

        QBRTCConfig.setAnswerTimeInterval(15)

        newSession.startCall(userInfo)

        CallManager.shared.session = newSession
    }

}
