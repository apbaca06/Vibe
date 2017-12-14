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

class FirebaseManager {

    static func logIn(withEmail email: String, withPassword password: String) {

        Auth.auth().signIn(withEmail: email, password: password) { (firebaseUser, error) in

            if error == nil {

                // MARK: Logged into Firebase successfully
                guard
                    let uuser = firebaseUser
                else { return }

                // MARK: Logged into Quickblox
                QuickBlox.logInSync(withUserLogin: email, password: uuser.uid)
            }
        }
    }

    static func signUp(withEmail email: String, withPassword password: String) {

        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in

            // MARK: Failed to sign up for Firebase
            if error != nil {

                DispatchQueue.main.async {
                    UIAlertController(error: error!).show()
                }

            }

            // MARK: Signed up for Firebase successfully
            if error == nil {

                // MARK: Signed up for Quickblox
                QuickBlox.signUpSync(name: "cindy", uid: "12345", email: email, password: password)

                // MARK: Logged in for Firebase & Quickblox
//                self.logIn(
//
//                    withEmail: email,
//
//                    withPassword: password
//                )
            }
        }
    }

}
