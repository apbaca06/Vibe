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
import Crashlytics
import SwiftyGif

class RegisterViewController: UIViewController {

    @IBOutlet weak var centerImage: UIImageView!

    @IBOutlet weak var agreeButton: UIButton!

    @IBOutlet weak var alreadyHaveLabel: UILabel!
    @IBOutlet weak var eulaButton: UIButton!

    var agreedByUser: Bool = false
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

        if agreedByUser == true {

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
    } else {
        let alert = UIAlertController(title: NSLocalizedString("Please agree with EULA", comment: ""), message: NSLocalizedString("Touch check button to agree with EULA", comment: ""), preferredStyle: .alert)
        alert.addAction(title: NSLocalizedString("OK", comment: ""))

        alert.show()
        }
    }

    @IBAction func agreeOnEULA(_ sender: Any) {
        if agreedByUser == false {

            agreeButton.tintColor = UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)
            agreedByUser = true
        } else {
            agreeButton.tintColor = .gray
            agreedByUser = false
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let agreeImage = #imageLiteral(resourceName: "checked").withRenderingMode(.alwaysTemplate)
        agreeButton.setImage(agreeImage, for: .normal)
        agreeButton.tintColor = .gray

        alreadyHaveLabel.text = NSLocalizedString("Already have an account?", comment: "")

        eulaButton.setTitle(NSLocalizedString("Tap to read EULA", comment: ""), for: .normal)

        setUpButton()
    }

    func setUpButton() {

        registerButton.setTitle(NSLocalizedString("Register", comment: ""), for: .normal)

        loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)

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
