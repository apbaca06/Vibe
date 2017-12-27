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

    static func logIn(withEmail email: String, withPassword password: String) {

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in

            if error == nil {

                let keychain = KeychainSwift()

                keychain.set(email, forKey: "userEmail")

                keychain.set(password, forKey: "userPassword")

                keychain.set((user?.uid)!, forKey: "uid")

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

//    static func fetchFirstNode(nodeName: String) -> URL? {
//        var urlString: URL?
//        DatabasePath.userRef.child(nodeName).child("profileImgURL").observeSingleEvent(of: .value) { (datashot) in
//            if let dic = datashot.value  as? [ String : Any ],
//                let profileImgURLString = dic["profileImgURL"] as? String,
//                let profileImgURL = URL(string: profileImgURLString) as? URL {
//                    urlString = profileImgURL
//            }
//        }
//        return urlString
//    }
//
//    static func fetchStoragePic(pathName: String) {
//    
//    }

}
