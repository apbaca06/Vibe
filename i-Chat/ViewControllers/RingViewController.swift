//
//  RingViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class RingViewController: UIViewController {

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var name: UILabel!

    @IBAction func rejectButton(_ sender: UIButton) {

        print("Did reject")

        CallManager.shared.session?.rejectCall(nil)

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("拒絕通話", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func acceptButton(_ sender: UIButton) {
        print("Did accept")

        // userInfo - the custom user information dictionary for the accept call. May be nil.
        //        let userInfo: [String: String] = ["key": "value"]
        CallManager.shared.session?.acceptCall(nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
//
//extension RingViewController {
//
//    // MARK: 停止連接session到別的user
//    func session(_ session: QBRTCBaseSession, disconnectedFromUser userID: NSNumber) {
//        print("Disconnected from user \(userID)")
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
