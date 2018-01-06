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
import Firebase

class QuickbloxManager {

    static func logInSync(withUserEmail email: String, password: String) {

        let layout = UICollectionViewFlowLayout()

        AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)

        var error: Error?
        var uuser: QBUUser?

        SVProgressHUD.show(withStatus: NSLocalizedString("Connecting to server", comment: ""))

        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { (response, user) in

            // MARK: User logged in with Quickblox
            uuser = user

            uuser?.email = email

            uuser?.password = password

            QBChat.instance.connect(with: uuser!, completion: { (error) in

                if error == nil {
                    SVProgressHUD.dismiss()

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
    }

    static func signUpSync(name: String, email: String, password: String) {

        var error: Error?
        let uuser = QBUUser()

        uuser.email = email

        uuser.password = password

        uuser.fullName = name

        SVProgressHUD.show(withStatus: NSLocalizedString("Signing up...", comment: ""))

        QBRequest.signUp(uuser, successBlock: { (response, user) in
            if let firebaseUser = Auth.auth().currentUser {

                DatabasePath.userRef
                    .child(firebaseUser.uid)
                    .setValue(["name": name,
                               "email": email,
                               "qbID": user.id,
                               "createdTime": user.createdAt?.iso8601String], withCompletionBlock: { (error, _) in
                            if error == nil {
                                let navGenderViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PreferenceNav")

                                AppDelegate.shared.window?.rootViewController = navGenderViewController
                            } else {
                                SVProgressHUD.dismiss()
                                let alertController = UIAlertController(title: NSLocalizedString("\(error)", comment: ""), message: "Sign up error, we will fixed it soon!", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                                alertController.addAction(okAction)
                                alertController.show()
                            }
                })

            }

        }) { (response) in

            SVProgressHUD.dismiss()

            error = response.error?.error

            let user = Auth.auth().currentUser

            user?.delete { error in
                if let error = error {
                    // An error happened.
                } else {
                    // Account deleted.
                }
            }

            DispatchQueue.main.async {

                UIAlertController(error: error!).show()

            }
        }

    }
}
