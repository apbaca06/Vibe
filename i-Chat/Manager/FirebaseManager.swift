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

    static func userUnlike(uid: String, recieverUid: String) {
        DatabasePath.userUnlikeRef.child(uid).setValue([recieverUid: 0])
    }

    static func userLike(uid: String, recieverUid: String) {
        DatabasePath.userLikeRef.child(uid).setValue([recieverUid: 0])
    }

    static func userSwipedLike(uid: String, recieverUid: String) {
        DatabasePath.userSwipedLikeRef.child(recieverUid).setValue([uid: 0])
    }

    static func findIfWasSwiped(uid: String, recieverUid: String, completionHandler: @escaping (Bool) -> Void) {
        DatabasePath.userLikeRef.child(recieverUid).queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value) { (datasnapshot) in
            print("if is matched", datasnapshot)

            let exist = datasnapshot.exists()

            switch exist {
            case true :

                DatabasePath.userFriendRef.child(uid).setValue([recieverUid: "\(uid)_\(recieverUid)"])

                DatabasePath.userFriendRef.child(recieverUid).setValue([uid: "\(uid)_\(recieverUid)"])
                completionHandler(true)

            case false:

                completionHandler(false)
            }
        }
    }

}
