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

                SVProgressHUD.show(withStatus: "Registering")

                // MARK: Logged into Firebase successfully
                guard
                    let uuser = firebaseUser
                else { return }

                // MARK: Logged into Quickblox
                QuickBlox.logInSync(

                    withUserEmail: email,

                    password: uuser.uid
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

                guard
                    let user = firebaseUser
                else { return }

                // MARK: Signed up for Quickblox
                QuickBlox.signUpSync(name: name, email: email, password: user.uid)

                // MARK: Logged in for Firebase & Quickblox
                self.logIn(

                    withEmail: email,

                    withPassword: password
                )
            }
        }
    }

}
