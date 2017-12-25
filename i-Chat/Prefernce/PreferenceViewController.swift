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

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        SVProgressHUD.dismiss()

        maleButton.cornerRadius = maleButton.bounds.width/2

        womanButton.cornerRadius = womanButton.bounds.width/2

    }
}
