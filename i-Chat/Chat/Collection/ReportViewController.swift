//
//  ReportViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/5.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import KeychainSwift

class ReportViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    var reportedID: String?

    let keychain = KeychainSwift()

    @IBOutlet weak var reportTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!

    @IBAction func reportAction(_ sender: Any) {
        guard let uid = keychain.get("uid"),
              let reportID = reportedID
        else { return }
        if reportTextView.hasText {
            DatabasePath.reportRef.child(uid).child(reportID).updateChildValues([Date().iso8601StringNew: reportTextView.text])
            let alertController = UIAlertController(title: NSLocalizedString("It's been reported!", comment: ""), message: "We will further investigate. Thank you!", preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
            alertController.addAction(action)
            alertController.show()
            self.dismiss(animated: true, completion: nil)

        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Please insert content!", comment: ""), message: "We need more information to investigate. Thank you!", preferredStyle: .alert)
            let oKaction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
            alertController.addAction(oKaction)
            present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var backgroundView: UIView!

    override func viewDidLoad() {

        super.viewDidLoad()
        titleLabel.text = NSLocalizedString("Insert Report Content", comment: "")

        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)

        reportButton.setTitle(NSLocalizedString("Report", comment: ""), for: .normal)

    }

}
