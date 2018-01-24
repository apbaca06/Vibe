//
//  AlertExtension.swift
//  i-Chat
//
//  Created by cindy on 2018/1/8.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
