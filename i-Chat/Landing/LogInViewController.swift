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
import Crashlytics
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!

    @IBOutlet weak var emailBottomLine: UIView!

    @IBOutlet weak var userPassword: UITextField!

    @IBOutlet weak var passwordBottomLine: UIView!

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var loginButton: UIButton!

    @IBOutlet weak var forgotPasswordButton: UIButton!

    @IBOutlet weak var createButton: UIButton!

    @IBOutlet weak var dontHaveAccountLabel: UILabel!

    @IBAction func forgetPassword(_ sender: Any) {

        let alertController = UIAlertController(title: NSLocalizedString("Forget password?", comment: ""), message: "Enter your email and we'll send a reset link!", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = NSLocalizedString("e-mail", comment: "")
        }
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (_) in
            let emailTextfield =
                (alertController.textFields?.first)!
                as UITextField
            if emailTextfield.hasText == false {
                let alertController = UIAlertController(title: NSLocalizedString("Please insert email!", comment: ""), message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }

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

        forgotPasswordButton.setTitle(NSLocalizedString("Forgot password?", comment: ""), for: .normal)

        dontHaveAccountLabel.text = NSLocalizedString("Don't have an account?", comment: "")

    }

    func setUpButton() {

        loginButton.cornerRadius = 10

        createButton.cornerRadius = 10
    }

}
