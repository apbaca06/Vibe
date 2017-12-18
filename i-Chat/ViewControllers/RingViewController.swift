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

        CallManager.shared.session?.hangUp(nil)
        
//        CallManager.shared.session = nil
        print("****\(CallManager.shared.session)")

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

extension RingViewController: QBRTCClientDelegate {

    // MARK: 當別人掛掉你的電話
    func session(_ session: QBRTCSession, hungUpByUser userID: NSNumber, userInfo: [String: String]? = nil) {
        //For example:Update GUI
        // Or
        /**
         HangUp when initiator ended a call
         */
        if session.initiatorID.isEqual(to: userID) {

            session.hangUp(userInfo)

            print("****Hung up by user \(userID)")

            CallManager.shared.session = nil

            self.dismiss(animated: true, completion: nil)
        }

    }
    
    func hangUpCall(_ userInfo: [String: String]?) {
    
        
        CallManager.shared.session?.hangUp(userInfo)
        
        CallManager.shared.session = nil
        
    }

}
