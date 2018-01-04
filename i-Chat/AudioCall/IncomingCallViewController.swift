//
//  IncomingCallViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Nuke

class IncomingCallViewController: UIViewController {

    var userInfo: [String: String]?

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var backgroundView: UIImageView!

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var acceptButton: UIButton!

    @IBOutlet weak var rejectButton: UIButton!

    @IBAction func rejectButton(_ sender: UIButton) {

        RingtoneManager.shared.ringPlayer.stop()

        print("***Did reject")

        CallManager.shared.session?.rejectCall(nil)

        print("****\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("Reject Call", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func acceptButton(_ sender: UIButton) {

        print("Did accept")

        RingtoneManager.shared.ringPlayer.stop()

        CallManager.shared.session?.acceptCall(nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        RingtoneManager.shared.playRingtone()

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = backgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurEffectView)

        guard let dict = userInfo,
            let name = dict["Name"],
            let urlString = dict["profileImgURL"],
            let url = URL(string: urlString)
            else { return }

        self.name.text = name

        Manager.shared.loadImage(with: url, into: profileImageView)
//        Manager.shared.loadImage(with: url, into: backgroundView)

    }

    override func viewWillLayoutSubviews() {
        setUpShape()
    }

    func setUpShape() {
        rejectButton.layer.cornerRadius = rejectButton.frame.width/2

        acceptButton.layer.cornerRadius = acceptButton.frame.width/2

        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        self.profileImageView.clipsToBounds = true
    }

}
