//
//  MatchViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/30.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    var willGoChat: Bool = false

    @IBOutlet weak var staySwipeButton: UIButton!
    @IBOutlet weak var heatImageView: UIImageView!

    @IBOutlet weak var goChatButton: UIButton!
    @IBOutlet weak var matchLabel: UILabel!

    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }

    @IBAction func staySwipe(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }

    @IBAction func goChat(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        matchLabel.text = NSLocalizedString("It's a Match", comment: "")
        staySwipeButton.setTitle(NSLocalizedString("Keep swiping!", comment: ""), for: .normal)
        staySwipeButton.layer.cornerRadius = 10

        goChatButton.layer.cornerRadius = 10
        goChatButton.setTitle(NSLocalizedString("Go chat!", comment: ""), for: .normal)

    }

}
