//
//  AnimationViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/11.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import SwiftyGif
import Firebase
import KeychainSwift
import CoreLocation

class AnimationViewController: UIViewController {

    @IBOutlet weak var animationView: UIImageView!
    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

        let gifManager2 = SwiftyGifManager(memoryLimit: 20)
        let gif2 = UIImage(gifName: "animation.gif")
        self.animationView.setGifImage(gif2, manager: gifManager2)

        if Auth.auth().currentUser != nil {

            guard let email = self.keychain.get("userEmail"),
                let password = self.keychain.get("userPassword")

                else {

                    let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

                    AppDelegate.shared.window?.rootViewController = loginViewController
                    return
            }

            QuickbloxManager.logInSync(

                withUserEmail: email,

                password: password
            )

        } else {

            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

            AppDelegate.shared.window?.rootViewController = loginViewController
        }

    }

    override func viewDidAppear(_ animated: Bool) {

    }
}
