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

    @IBAction func tapMute(_ sender: Any) {

    }

    @IBAction func tapSpeaker(_ sender: Any) {

    }
    @IBOutlet weak var mutedButton: UIButton!
    @IBAction func hangUpAction(_ sender: UIButton) {
    }

    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var hangUpButton: UIButton!

    @IBOutlet weak var timerLabel: MZTimerLabel!

    override func viewDidLoad() {

        timerLabel.start()

    }

}
