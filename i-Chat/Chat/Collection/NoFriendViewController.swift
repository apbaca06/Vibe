//
//  NoFriendViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/5.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Crashlytics

class NoFriendViewController: UIViewController {

    @IBOutlet weak var cupidImageView: UIImageView!
    @IBOutlet weak var goSwipeButton: UIButton!
    @IBOutlet weak var matchLabel: UILabel!

    @IBAction func goSwipe(_ sender: Any) {

        // swiftlint:disable force_cast

        let parentCollectionVC = parent as! FriendCollectionViewController
        let grandParentVC = parentCollectionVC.parent as! HomeViewController
        // swiftlint:enable force_cast

        grandParentVC.scrollToMenuIndex(1)
        grandParentVC.menuBar.collectionView.selectItem(
            at: [0, 1],

            animated: true,

            scrollPosition: UICollectionViewScrollPosition()
        )

        self.removeFromParentViewController()

        self.view.removeFromSuperview()

        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        matchLabel.text = NSLocalizedString("No friends yet!", comment: "")

        goSwipeButton.layer.cornerRadius = 10
        goSwipeButton.setTitle(NSLocalizedString("Go swipe!", comment: ""), for: .normal)
    }

}
