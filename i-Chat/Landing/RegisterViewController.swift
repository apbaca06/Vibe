//
//  RegisterViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/13.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SwifterSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var agreeLabel: UILabel!

    @IBOutlet weak var eulaButton: UIButton!
    @IBAction func toLoginButton(_ sender: Any) {

        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

        AppDelegate.shared.window?.rootViewController = loginViewController
    }

    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var userEmail: UITextField!

    @IBOutlet weak var userPassword: UITextField!

    @IBOutlet weak var registerButton: UIButton!

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func registerButton(_ sender: UIButton) {

        if !userName.isEmpty &&
           !userEmail.isEmpty &&
           !userPassword.isEmpty {

            let email = userEmail.text!

            let password = userPassword.text!

            let name = userName.text!

            if email.isValidEmail() == true {

                if password.charactersArray.count >= 8 {

                    FirebaseManager.signUp(
                        name: name,

                        withEmail: email,

                        withPassword: password
                    )
                } else {

                        let alert = UIAlertController(title: NSLocalizedString("Invalid Password", comment: ""), message: NSLocalizedString("Please have password longer than 8 characters!", comment: ""), preferredStyle: .alert)

                        alert.addAction(title: NSLocalizedString("OK", comment: ""))

                        alert.show()

                }
            } else {

                    let alert = UIAlertController(title: NSLocalizedString("Invalid Email", comment: ""), message: NSLocalizedString("Please insert correct email!", comment: ""), preferredStyle: .alert)

                    alert.addAction(title: NSLocalizedString("OK", comment: ""))

                    alert.show()

            }
        } else {

                let alert = UIAlertController(title: NSLocalizedString("Please Insert Content", comment: ""), message: NSLocalizedString("No blank are allowed for registeration!", comment: ""), preferredStyle: .alert)
                alert.addAction(title: NSLocalizedString("OK", comment: ""))
                alert.show()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        agreeLabel.text = NSLocalizedString("Agreed on EULA when you registered", comment: "")

        setUpButton()
    }

    func setUpButton() {

        registerButton.cornerRadius = 10

        loginButton.cornerRadius = 10
    }
}

extension String {

    func isValidEmail() -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        let result = emailTest.evaluate(with: self)

        return result

    }

}
