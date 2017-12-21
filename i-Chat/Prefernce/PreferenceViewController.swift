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

class PreferenceViewController: UIViewController {

    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!

    @IBAction func maleAction(_ sender: UIButton) {
        DatabasePath.userRef.child(FirebaseManager.uid).updateChildValues(["preference": "male"])
    }

    @IBAction func womanAction(_ sender: Any) {
        DatabasePath.userRef.child(FirebaseManager.uid).updateChildValues(["preference": "female"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        maleButton.titleLabel?.text = NSLocalizedString("Male", comment: "")
        womanButton.titleLabel?.text = NSLocalizedString("Woman", comment: "")

    }
}
