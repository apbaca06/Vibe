//
//  FirebaseManager.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD
import KeychainSwift

class FirebaseManager {

    static var uid: String = {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            return uid
        }
        return "no uid"
    }()

    static func logIn(withEmail email: String, withPassword password: String) {

        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in

            if error == nil {

                let keychain = KeychainSwift()

                keychain.synchronizable = true

                keychain.set(email, forKey: "userEmail")

                keychain.set(password, forKey: "userPassword")

                // MARK: Logged into Firebase successfully

                SVProgressHUD.show(withStatus: NSLocalizedString("Logging in...", comment: ""))

                // MARK: Logged into Quickblox
                QuickbloxManager.logInSync(

                    withUserEmail: email,

                    password: password
                )
            }
        }
    }

    static func signUp(name: String, withEmail email: String, withPassword password: String) {

        Auth.auth().createUser(withEmail: email, password: password) { (firebaseUser, error) in

            // MARK: Failed to sign up for Firebase
            if error != nil {

                DispatchQueue.main.async {
                    UIAlertController(error: error!).show()
                }

            }

            // MARK: Signed up for Firebase successfully
            if error == nil {

                let keychain = KeychainSwift()

                keychain.set(email, forKey: "userEmail")

                keychain.set(password, forKey: "userPassword")

                guard
                    let user = firebaseUser
                else { return }

                keychain.set(user.uid, forKey: "uid")

                // MARK: Signed up for Quickblox
                QuickbloxManager.signUpSync(name: name, email: email, password: password)

            }
        }
    }

}
