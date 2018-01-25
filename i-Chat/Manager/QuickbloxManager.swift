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
import KeychainSwift

class QuickbloxManager {

    // MARK: Set APIKey for QuickBlox
    static func setting(accountKey: String, applicationID: UInt, authKey: String, authSecret: String) {
        QBRTCClient.initializeRTC()
        QBRTCConfig.setAnswerTimeInterval(45)
        QBSettings.accountKey = accountKey
        QBSettings.applicationID = applicationID
        QBSettings.authKey = authKey
        QBSettings.authSecret = authSecret
        QBSettings.logLevel = .debug
        QBSettings.enableXMPPLogging()
        QBRTCAudioSession.instance().initialize()
    }

    // MARK: Login for QuickBlox
    static func logInSync(withUserEmail email: String, password: String) {
        var error: Error?
        var uuser: QBUUser?
        let loginViewController = UIViewController.load(LogInViewController.self)

        QBRequest.logIn(withUserEmail: email, password: password, successBlock: { (response, user) in

            // MARK: User logged in with Quickblox
            uuser = user

            uuser?.email = email

            uuser?.password = password

            QBChat.instance.connect(with: uuser!, completion: { (error) in

                if error == nil {

                    let layout = UICollectionViewFlowLayout()
                    AppDelegate.shared.window?.rootViewController = HomeViewController(collectionViewLayout: layout)

                } else {
                    DispatchQueue.main.async {

                        UIAlertController(error: error!).show()
                        AppDelegate.shared.window?.rootViewController = loginViewController

                    }
                }
            })

        }) { (response) in
            SVProgressHUD.dismiss()
            error = response.error?.error
            DispatchQueue.main.async {

                UIAlertController(error: error!).show()
                AppDelegate.shared.window?.rootViewController = loginViewController
            }
        }
    }

    // MARK: Signup for QuickBlox
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
                let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

                AppDelegate.shared.window?.rootViewController = loginViewController

            }
        }

    }

    static func connectQB(toUser opponetUser: User, completionHandler: @escaping (Bool) -> Void) {

        var uuser: QBUUser?

        if QBChat.instance.isConnected == false {

            SVProgressHUD.show(withStatus: NSLocalizedString("Connecting to communication service", comment: ""))

            let keychain = KeychainSwift()

            keychain.synchronizable = true

            guard let email = keychain.get("userEmail"),
            let password = keychain.get("userPassword")

            else {
                DispatchQueue.main.async {

                    let alertController = UIAlertController(title: NSLocalizedString("Unauthorized!", comment: ""), message: "Please login again.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                    alertController.addAction(okAction)
                    alertController.show()
                    let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

                    AppDelegate.shared.window?.rootViewController = loginViewController

                }
                return }

            QBRequest.logIn(withUserEmail: email, password: password, successBlock: { (_, user) in

                // MARK: User logged in with Quickblox
                uuser = user

                uuser?.email = email

                uuser?.password = password

                QBChat.instance.connect(with: uuser!, completion: { (error) in
                    if error == nil {
                        SVProgressHUD.dismiss()
                        completionHandler(true)
                        CallManager.shared.audioCall(toUser: opponetUser)
                    } else {
                        SVProgressHUD.dismiss()
                        completionHandler(false)
                        DispatchQueue.main.async {
                            UIAlertController(error: error!).show()
                        }
                    }

                })
            })
        } else {
            completionHandler(true)
            CallManager.shared.audioCall(toUser: opponetUser)
        }
    }
}
