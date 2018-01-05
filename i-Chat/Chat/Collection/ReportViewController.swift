//
//  ReportViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/5.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class ReportViewController: UIViewController {

    var reportedID: String?

    @IBAction func reportAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textfield: UITextView!

    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.placeholder = NSLocalizedStr
    }

}
