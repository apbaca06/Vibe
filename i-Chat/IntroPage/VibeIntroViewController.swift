//
//  VibeIntroViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/26.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class VibeIntroViewController: UIViewController {

    @IBOutlet weak var goVibeButton: UIButton!
    @IBOutlet weak var vibeIcon: UIImageView!

    @IBAction func goSwipePage(_ sender: Any) {
        let layout = UICollectionViewFlowLayout()

        let home = HomeViewController(collectionViewLayout: layout)

        AppDelegate.shared.window?.rootViewController = home

    }

}
