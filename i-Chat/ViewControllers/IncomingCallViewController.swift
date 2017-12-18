//
//  IncomingCallViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class IncomingCallViewController: UIViewController, QBRTCClientDelegate {

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBAction func rejectButton(_ sender: UIButton) {

        print("***Did reject")

        CallManager.shared.session?.rejectCall(nil)

        print("****\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("拒絕通話", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func acceptButton(_ sender: UIButton) {
        print("Did accept")

        // userInfo - the custom user information dictionary for the accept call. May be nil.
        //        let userInfo: [String: String] = ["key": "value"]
        CallManager.shared.session?.acceptCall(nil)
        
        let audioViewController = AudioViewController()
        
        self.present(audioViewController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtonShape()

        QBRTCClient.instance().add(self)

    }
    func sessionDidClose(_ session: QBRTCSession) {
        print("++++sessionDidClose++++++")
       
        CallManager.shared.session = nil

        self.dismiss(animated: true, completion: nil)
    }

    func setUpButtonShape() {
        rejectButton.layer.cornerRadius = rejectButton.frame.width/2

        acceptButton.layer.cornerRadius = acceptButton.frame.width/2
    }

}
