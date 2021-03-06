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
import Crashlytics

class PreferenceViewController: UIViewController {

    @IBOutlet weak var decriptionLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!

    let keychain = KeychainSwift()

    @IBAction func maleAction(_ sender: UIButton) {

        UserDefaults.standard.set("Male", forKey: "Preference")

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).updateChildValues(["preference": "Male"])
    }

    @IBAction func womanAction(_ sender: Any) {

        UserDefaults.standard.set("Female", forKey: "Preference")

        guard let uid = keychain.get("uid")
            else { return }

        DatabasePath.userRef.child(uid).updateChildValues(["preference": "Female"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        decriptionLabel.text = NSLocalizedString("Select preference!", comment: "")

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        maleButton.cornerRadius = maleButton.bounds.width/2

        womanButton.cornerRadius = womanButton.bounds.width/2

    }

}
