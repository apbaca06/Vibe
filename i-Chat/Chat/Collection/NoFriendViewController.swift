//
//  NoFriendViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/5.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class NoFriendViewController: UIViewController {

    @IBOutlet weak var cupidImageView: UIImageView!
    @IBOutlet weak var goSwipeButton: UIButton!
    @IBOutlet weak var matchLabel: UILabel!

    @IBAction func goSwipe(_ sender: Any) {

        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        matchLabel.text = NSLocalizedString("No friends yet!", comment: "")

        goSwipeButton.layer.cornerRadius = 10
        goSwipeButton.setTitle(NSLocalizedString("Go swipe!", comment: ""), for: .normal)
    }

}
