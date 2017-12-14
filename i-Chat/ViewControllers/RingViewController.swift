//
//  RingViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class RingViewController: UIViewController, QBRTCClientDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        QBRTCClient.initializeRTC()

        // self class must conform to QBRTCClientDelegate protocol
        QBRTCClient.instance().add(self)

    }

    var session: QBRTCSession?

    @IBAction func rejectButton(_ sender: UIButton) {
        print("Did reject")

        // userInfo - the custom user information dictionary for the reject call. May be nil.
        let userInfo: [String: String] = ["key": "value"]
        self.session?.rejectCall(userInfo)

        // and release session instance
        self.session = nil
    }

    @IBAction func acceptButton(_ sender: UIButton) {
        print("Did accept")

        // userInfo - the custom user information dictionary for the accept call. May be nil.
        let userInfo: [String: String] = ["key": "value"]
        self.session?.acceptCall(userInfo)
    }

}
