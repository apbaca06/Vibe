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
import SVProgressHUD

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

        guard let name = keychain.get("name"),
              let profileImgURLString = keychain.get("profileImgURL")
            else { return }

        let userInfo: [String: String] = ["Name": name,
                                          "profileImgURL": profileImgURLString]

        newSession.startCall(userInfo)

        self.session = newSession
    }

}
