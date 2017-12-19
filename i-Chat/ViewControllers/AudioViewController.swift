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

class AudioViewController: UIViewController {

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

        print("****\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var mutedButton: UIButton!

    @IBOutlet weak var speakerButton: UIButton!

    @IBOutlet weak var hangUpButton: UIButton!

    @IBOutlet weak var timerLabel: MZTimerLabel!

    override func viewDidLoad() {

        setUpButtonShape()

    }

    func setUpButtonShape() {

        speakerButton.layer.cornerRadius = speakerButton.frame.width/2

        hangUpButton.layer.cornerRadius = hangUpButton.frame.width/2

        mutedButton.layer.cornerRadius = mutedButton.frame.width/2
    }

}
