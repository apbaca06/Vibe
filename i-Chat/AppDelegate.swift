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
import KeychainSwift

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

        QBRTCConfig.setAnswerTimeInterval(45)

        QBSettings.accountKey = accountKey

        QBSettings.applicationID = applicationID

        QBSettings.authKey = authKey

        QBSettings.authSecret = authSecret

        QBSettings.logLevel = .debug

        QBSettings.enableXMPPLogging()

        SVProgressHUD.setDefaultStyle(.light)

        SVProgressHUD.setDefaultMaskType(.clear)

        QBRTCAudioSession.instance().initialize()

        IQKeyboardManager.shared().isEnabled = true

        IQKeyboardManager.shared().shouldResignOnTouchOutside = true

        Database.database().isPersistenceEnabled = true

        // MARK: Check if user signed in before
        let keychain = KeychainSwift()

        keychain.synchronizable = true

        let animationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimationViewController")

        AppDelegate.shared.window?.rootViewController = animationViewController

        return true

    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}

extension AppDelegate {

    class var shared: AppDelegate {

        //swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        //swiftlint:enable force_cast

    }

}
