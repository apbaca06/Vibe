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

    override func viewDidLoad() {
        super.viewDidLoad()

//        SVProgressHUD.dismiss()

//        // self class must conform to QBRTCClientDelegate protocol
//        QBRTCClient.instance().add(self)
//
//        QBRTCAudioSession.instance().initialize()

    }

    @IBAction func callAction(_ sender: UIButton) {

        CallManager.audioCall(toUser: User(id: 1234, name: "john", gender: .male, imgURL: "ee", email: "john@gmail.com", quickbloxID: 38855767))

        //開始嘟嘟聲

        //切換到打電話畫面

        // swiftlint:disable force_cast
        let ringViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RingViewController") as! RingViewController
        // swiftlint:enable force_cast

        self.present(ringViewController, animated: true, completion: nil)

    }

}
