//
//  CallOutViewControllers.swift
//  i-Chat
//
//  Created by cindy on 2017/12/18.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class CallOutViewController: UIViewController {

    var reciever: User?

    @IBOutlet weak var rippleView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var recieverName: UILabel!

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var recieverImg: UIImageView!

    @IBAction func cancelButton(_ sender: UIButton) {

        RingtoneManager.shared.ringPlayer.stop()

        CallManager.shared.session?.hangUp(nil)

        print("****CallOutsession\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("Call rejected", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        RingtoneManager.shared.playRingtone()

        guard let urlString = reciever?.profileImgURL,
            let url = URL(string: urlString),
            let name = reciever?.name
            else { return }
        Manager.shared.loadImage(with: url, into: recieverImg)
//        Manager.shared.loadImage(with: url, into: backgroundImageView)
        recieverName.text = name

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        setupViewsForRippleEffect()
        setUpShape()

//        ripple(CGPoint(x: rippleView.frame.origin.x + rippleView.frame.width/2, y: rippleView.frame.origin.y + rippleView.frame.height/2), view: rippleView)
    }

    func setUpShape() {
        cancelButton.layer.cornerRadius = cancelButton.frame.width/2
        self.recieverImg.layer.cornerRadius = self.recieverImg.frame.size.width / 2

        self.recieverImg.clipsToBounds = true
    }

    func animateRippleEffect() {
        self.recieverImg.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.recieverImg.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                       }, completion: { _ in
                            self.animateRippleEffect()
        })
    }

}
