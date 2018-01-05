//
//  LogInViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/12.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SVProgressHUD
import MapKit

class LogInViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!

    @IBOutlet weak var emailBottomLine: UIView!

    @IBOutlet weak var userPassword: UITextField!

    @IBOutlet weak var passwordBottomLine: UIView!

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var forgotPasswordLabel: UILabel!

    @IBOutlet weak var createButton: UIButton!

    @IBOutlet weak var dontHaveAccountLabel: UILabel!

    @IBAction func toRegisterButton(_ sender: UIButton) {

        let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")

        AppDelegate.shared.window?.rootViewController = registerViewController
    }
    @IBAction func loginButton(_ sender: Any) {

        if !userEmail.isEmpty &&
           !userPassword.isEmpty {

            let email = userEmail.text!

            let password = userPassword.text!

            FirebaseManager.logIn(

                withEmail: email,

                withPassword: password
            )

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButton()

        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)

        createButton.setTitle(NSLocalizedString("Create", comment: ""), for: .normal)

        forgotPasswordLabel.text = NSLocalizedString("Forgot password?", comment: "")
        dontHaveAccountLabel.text = NSLocalizedString("Don't have an account?", comment: "")

    }

    func setUpButton() {

        loginButton.cornerRadius = 10

        createButton.cornerRadius = 10
    }

}
