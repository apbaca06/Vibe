//
//  AppDelegate.swift
//  i-Chat
//
//  Created by cindy on 2017/12/12.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import IQKeyboardManager
import SVProgressHUD
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

         FirebaseApp.configure()

        // MARK: Get APIKey from plist
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),

              let dic = NSDictionary(contentsOfFile: path) as? [String: Any],

              let values = dic["APIKey"] as? NSDictionary

        else { return true }

        // swiftlint:disable force_cast
        let accountKey = values["accountKey"] as! String

        let applicationIDString = values["applicationID"] as! String

        let applicationID = UInt(applicationIDString)!

        let authKey = values["authKey"] as! String

        let authSecret = values["authSecret"] as! String
        // swiftlint:enable force_cast

        // MARK: Set APIKey for QuickBlox

        QBRTCClient.initializeRTC()

        QBRTCConfig.setAnswerTimeInterval(30)

        QBSettings.accountKey = accountKey

        QBSettings.applicationID = applicationID

        QBSettings.authKey = authKey

        QBSettings.authSecret = authSecret

        QBSettings.logLevel = .debug

        QBSettings.enableXMPPLogging()

        SVProgressHUD.setDefaultStyle(.light)

        SVProgressHUD.setDefaultMaskType(.clear)

        QBRequest.logOut(successBlock: nil, errorBlock: nil)

        if
            let user = Auth.auth().currentUser,
            let email = user.email {

            QuickBlox.logInSync(withUserEmail: email, password: user.uid)
        }

        // IQKeyBoardManager
        IQKeyboardManager.shared().isEnabled = true

        IQKeyboardManager.shared().shouldResignOnTouchOutside = true

        return true

    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

        if QBChat.instance.isConnected == false {

            SVProgressHUD.show(withStatus: NSLocalizedString("Connecting to communication service", comment: ""))

            guard let user = Auth.auth().currentUser

            else {
                    let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")

                    AppDelegate.shared.window?.rootViewController = registerViewController

                    return
            }

            QuickBlox.logInSync(withUserEmail: user.email!, password: user.uid)

//            UIApplication.shared.beginIgnoringInteractionEvents()

        }

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {

    class var shared: AppDelegate {

        //swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        //swiftlint:enable force_cast

    }

}
