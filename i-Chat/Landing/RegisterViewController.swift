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

    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var userEmail: UITextField!

    @IBOutlet weak var userPassword: UITextField!

    @IBAction func registerButton(_ sender: UIButton) {

        if !userName.isEmpty &&
           !userEmail.isEmpty &&
           !userPassword.isEmpty {

            let email = userEmail.text!

            let password = userPassword.text!

            let name = userName.text!

            FirebaseManager.signUp(
                name: name,

                withEmail: email,

                withPassword: password
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
