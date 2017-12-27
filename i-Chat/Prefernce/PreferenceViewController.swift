//
//  PreferenceViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Firebase
import KeychainSwift

class PreferenceViewController: UIViewController {

    @IBOutlet weak var decriptionLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!

    let keychain = KeychainSwift()

    @IBAction func maleAction(_ sender: UIButton) {

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).updateChildValues(["preference": "male"])
    }

    @IBAction func womanAction(_ sender: Any) {

        guard let uid = keychain.get("uid")
            else { return }

        DatabasePath.userRef.child(uid).updateChildValues(["preference": "female"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        maleButton.cornerRadius = maleButton.bounds.width/2

        womanButton.cornerRadius = womanButton.bounds.width/2

    }

}
