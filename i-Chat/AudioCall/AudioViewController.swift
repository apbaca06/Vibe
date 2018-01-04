//
//  AudioViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/14.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import MZTimerLabel
import Nuke

class AudioViewController: UIViewController {

    var userInfo: [String: String]?

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    var speakerOn: Bool = false

    var mutedOn: Bool = false

    @IBAction func tapMute(_ sender: Any) {

        switch mutedOn {

        case false:

            // MARK: User muted the local microphone

            mutedOn = true

            mutedButton.tintColor = UIColor.darkGray

            mutedButton.layer.borderColor = UIColor.darkGray.cgColor

            mutedButton.setImage(#imageLiteral(resourceName: "muted"), for: .normal)

            CallManager.shared.session?.localMediaStream.audioTrack.isEnabled = false

        case true:

            // MARK: User enabled the local microphone

            mutedOn = false

            mutedButton.tintColor = UIColor.white

            mutedButton.layer.borderColor = UIColor.white.cgColor

            mutedButton.setImage(#imageLiteral(resourceName: "microphone"), for: .normal)

            CallManager.shared.session?.localMediaStream.audioTrack.isEnabled = true

        }

    }

    @IBAction func tapSpeaker(_ sender: Any) {

        switch speakerOn {

        case false:

            // MARK: User enable the speaker

            speakerOn = true

            speakerButton.tintColor = UIColor.white

            speakerButton.layer.borderColor = UIColor.white.cgColor

            QBRTCAudioSession.instance().currentAudioDevice = QBRTCAudioDevice.speaker

        case true:

            // MARK: User disable the speaker

            speakerOn = false

            speakerButton.tintColor = UIColor.darkGray

            speakerButton.layer.borderColor = UIColor.darkGray.cgColor

            QBRTCAudioSession.instance().currentAudioDevice = QBRTCAudioDevice.receiver

        }

    }

    @IBAction func hangUpAction(_ sender: UIButton) {

        print("***Did reject")

        CallManager.shared.session?.hangUp(nil)

        print("****HungUpSession\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var mutedButton: UIButton!

    @IBOutlet weak var speakerButton: UIButton!

    @IBOutlet weak var hangUpButton: UIButton!

    @IBOutlet weak var timerLabel: MZTimerLabel!

    override func viewDidLoad() {

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = backgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurEffectView)

        guard let dict = self.userInfo,
            let name = dict["Name"],
            let urlString = dict["profileImgURL"],
            let url = URL(string: urlString)
            else { return }

        self.nameLabel.text = name

        Manager.shared.loadImage(with: url, into: profileImgView)
//        Manager.shared.loadImage(with: url, into: backgroundView)

    }

    override func viewDidAppear(_ animated: Bool) {

        timerLabel.start()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        setUpShape()
    }

    func setUpShape() {

        speakerButton.layer.cornerRadius = speakerButton.frame.width/2

        hangUpButton.layer.cornerRadius = hangUpButton.frame.width/2

        mutedButton.layer.cornerRadius = mutedButton.frame.width/2

        profileImgView.layer.cornerRadius = profileImgView.bounds.width/2
        self.profileImgView.clipsToBounds = true
    }

}
