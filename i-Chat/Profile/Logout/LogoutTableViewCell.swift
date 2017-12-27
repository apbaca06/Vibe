//
//  LogoutTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class LogoutTableViewCell: UITableViewCell {

    let keychain = KeychainSwift()

    @IBAction func logoutAction(_ sender: Any) {

        let firebaseAuth = Auth.auth()

        keychain.clear()

        do {
            // MARK: Firebase Logout
            try firebaseAuth.signOut()
            print("***", Auth.auth().currentUser)

            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

            AppDelegate.shared.window?.rootViewController = loginViewController

            // MARK: Quickblox Logout
            QBRequest.logOut(successBlock: { (_) in

            }, errorBlock: { (_) in
                // Error handling
            })

            // MARK: Disconnect From Quickblox (Prevent user is blocked by loging again really soon)
            QBChat.instance.disconnect { [weak self] (error) in

                if let error = error {
                    print("DISCONNECT ERROR \(error)")
                } else {
                    print("DISCONNECTED SUCCESSFULLY")
                }
            }

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    @IBOutlet weak var logoutButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        logoutButton.setTitleForAllStates(NSLocalizedString("Logout", comment: ""))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
