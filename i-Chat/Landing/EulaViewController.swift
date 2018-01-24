//
//  EulaViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/4.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class EulaViewController: UIViewController {

    @IBAction func agreeEula(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var agreeButton: UIButton!

    @IBOutlet weak var eulaTextfield: UITextView!

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = NSLocalizedString("EULA", comment: "")
        agreeButton.setTitle(NSLocalizedString("Back", comment: ""), for: .normal)
        eulaTextfield.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
