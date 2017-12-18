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

    @IBOutlet weak var recieverName: UILabel!

    @IBOutlet weak var callDescription: UILabel!

    @IBOutlet weak var cancelButton: UIButton!

    @IBAction func cancelButton(_ sender: UIButton) {

        print("Did reject")

        CallManager.shared.session?.hangUp(nil)

        print("****\(CallManager.shared.session)")

        CallManager.shared.session = nil

        self.callDescription.text = NSLocalizedString("拒絕通話", comment: "")

        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtonShape()

    }

    func setUpButtonShape() {
        cancelButton.layer.cornerRadius = cancelButton.frame.width/2

    }

}
