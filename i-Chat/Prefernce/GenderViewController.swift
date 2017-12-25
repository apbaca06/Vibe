//
//  GenderViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Firebase

class GenderViewController: UIViewController {

    @IBOutlet weak var decriptionLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!

    @IBAction func maleAction(_ sender: UIButton) {
        DatabasePath.userRef.child(FirebaseManager.uid).updateChildValues(["gender": "male"])

    }

    @IBAction func womanAction(_ sender: Any) {
        DatabasePath.userRef.child(FirebaseManager.uid).updateChildValues(["gender": "female"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.dismiss()

        decriptionLabel.text = NSLocalizedString("Please insert your gender", comment: "")
        maleButton.tintColor = UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        maleButton.cornerRadius = maleButton.bounds.width/2

        womanButton.cornerRadius = womanButton.bounds.width/2
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        SVProgressHUD.dismiss()

    }
}
