//
//  ExplainViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/17.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class ExplainViewController: UIViewController {
    @IBOutlet weak var iconImage: UIImageView!

    @IBOutlet weak var appTitle: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var setPersonalInfoButton: UIButton!

    override func viewDidLoad() {
        setPersonalInfoButton.setTitle(NSLocalizedString("Set Personal Info", comment: ""), for: .normal)

        descriptionLabel.text = NSLocalizedString("Set your personal info first, and vibe will handle the rest!", comment: "")

        setPersonalInfoButton.cornerRadius = 10
    }

}
