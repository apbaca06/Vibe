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

    public struct DatabasePath {

        public static let databaseRoot = Database.database().reference()

        public static let userRef = databaseRoot.child("users")

        public static let userFriendRef = databaseRoot.child("user_friend")

    }

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
                QuickBlox.logInSync(

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

                // MARK: Signed up for Quickblox
                QuickBlox.signUpSync(name: name, email: email, password: password)

            }
        }
    }

//    static func insertUserInfo(qbID:Int) {
//        
//        DatabasePath.userRef.childByAutoId().setPriority(<#T##priority: Any?##Any?#>)
//
//    }
//    
//    static func requestUserInfo(user: User) {
//        
//        DatabasePath.userRef.observe(.value) { (snapshot) in
//            <#code#>
//        }
//
//        userMessageReference.observe(.childAdded, with: { (snapshot) in
//            let messageId = snapshot.key
//            let messagesRef = FirebaseRef.databaseMessages.child(messageId)
//            messagesRef.observe(.value, with: { (snapshot) in
//                guard
//                    let messageObject = snapshot.value as? [String: AnyObject]
//                    else { return }
//        messageReference.updateChildValues(values) { (error, _) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            let messageId = messageReference.key
//            let value = [messageId: 1]
//            
//            if self.isSeller {
//                let storeID = self.store!.id
//                let userMessageReference = FirebaseRef.databaseUserProductMessages.child(toID).child(productId)
//                let storeProductMessageReference = FirebaseRef.databaseStoreProductMessages.child(storeID).child(productId).child(toID)
//                
//                userMessageReference.updateChildValues(value)
//                storeProductMessageReference.updateChildValues(value)
//            }
//
//    }

}
