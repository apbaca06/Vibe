//
//  CallManager.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

class CallManager {

    static let shared = CallManager()

    var fromUser: User?

    var toUser: User?

    var session: QBRTCSession?

    func audioCall(toUser opponetUser: User) {

        let opponentsIDs: [NSNumber] = [opponetUser.qbID]

        let newSession = QBRTCClient.instance().createNewSession(

            withOpponents: opponentsIDs,

            with: QBRTCConferenceType.audio
        )
        let keychain = KeychainSwift()

        guard let name = Auth.auth().currentUser?.email
            else { return }

        let userInfo: [String: String] = ["Name": name,
                                          "profileImgURL": "https://firebasestorage.googleapis.com/v0/b/i-chat-v2.appspot.com/o/profileImg%2Fc3ywbmhKGXPBK9ih3FkLHF29pPX2?alt=media&token=dd95a3c3-6389-4bc5-9c01-ee7a5abeafc2"]

        newSession.startCall(userInfo)

        self.session = newSession
    }

}
