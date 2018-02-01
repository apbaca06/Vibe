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
//        animation()

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
    func animation() {
        let arrow = #imageLiteral(resourceName: "Arrow")
        let arrowView = UIImageView.init(image: arrow)
        arrowView.frame = CGRect(x: -50, y: self.view.center.y, width: 60, height: 30)
        
        view.addSubview(arrowView)
        
        let centerY = self.view.frame.height / 2
        let steps = 2
        let stepX = self.view.frame.width / CGFloat(steps)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 300, y: centerY))

        for i in 0...steps {
            let x = CGFloat(i) * stepX
            let y = Double(centerY)
            path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = MAXFLOAT
        animation.duration = 2.8
        arrowView.layer.add(animation, forKey: "wave")
    }
}
