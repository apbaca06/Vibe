//
//  MatchViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/30.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBAction func dismiss(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var heatImageView: UIImageView!

    @IBOutlet weak var matchLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

}
