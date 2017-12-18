//
//  QB.swift
//  i-Chat
//
//  Created by cindy on 2017/12/13.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class QuickBlox {

    static func logInSync(withUserEmail email: String, password: String) {

        var error: Error?
        var uuser: QBUUser?

        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { (response, user) in

            SVProgressHUD.show(withStatus: NSLocalizedString("Logging in...", comment: ""))

            // MARK: User logged in with Quickblox
            uuser = user

            uuser?.email = email

            uuser?.password = password

            QBChat.instance.connect(with: uuser!, completion: { (error) in

                if error == nil {

                    SVProgressHUD.show(withStatus: NSLocalizedString("Login Successfully", comment: ""))

                    let layout = UICollectionViewFlowLayout()

                    AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)

                } else {

                    SVProgressHUD.dismiss()

                    DispatchQueue.main.async {
                        UIAlertController(error: error!).show()
                    }

                }

            })

        }) { (response) in

            SVProgressHUD.dismiss()

            // Todo: Error handling
            error = response.error?.error

            DispatchQueue.main.async {

                UIAlertController(error: error!).show()
            }

        }

//        SVProgressHUD.show(withStatus: "Logging In")
//
//        SVProgressHUD.dismiss()

    }

    static func signUpSync(name: String, email: String, password: String) {

        var error: Error?
        let uuser = QBUUser()

        uuser.email = email

        uuser.password = password

        uuser.fullName = name

        SVProgressHUD.show(withStatus: NSLocalizedString("Signing up...", comment: ""))

        QBRequest.signUp(uuser, successBlock: { (response, error) in

            SVProgressHUD.show(withStatus: NSLocalizedString("SignUp Successed", comment: ""))

            let layout = UICollectionViewFlowLayout()

            AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)

        }) { (response) in

            SVProgressHUD.dismiss()

            error = response.error?.error

            DispatchQueue.main.async {

                UIAlertController(error: error!).show()
            }
        }

    }
}
