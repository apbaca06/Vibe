//
//  CallOutViewControllers.swift
//  i-Chat
//
//  Created by cindy on 2017/12/18.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class CallOutViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!

    @IBOutlet weak var recieverName: UILabel!

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var recieverImg: UIImageView!

    @IBAction func cancelButton(_ sender: UIButton) {

        print("Did reject")

        RingtoneManager.shared.ringPlayer.stop()

        CallManager.shared.session?.hangUp(nil)

        print("****\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("拒絕通話", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtonShape()

        RingtoneManager.shared.playRingtone()

//        ripple(CGPoint(x: recieverImg.bounds.width/2, y: recieverImg.bounds.height/2), view: recieverImg)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupViewsForRippleEffect()
    }

    func setUpButtonShape() {
        cancelButton.layer.cornerRadius = cancelButton.frame.width/2
    }

    func setupViewsForRippleEffect() {
        recieverImg.layer.zPosition = 1111

        self.recieverImg.layer.cornerRadius = self.recieverImg.frame.size.width / 2

        self.recieverImg.clipsToBounds = true

        animateRippleEffect()
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
