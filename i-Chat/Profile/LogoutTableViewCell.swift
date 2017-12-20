//
//  LogoutTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase

class LogoutTableViewCell: UITableViewCell {

    @IBAction func logoutAction(_ sender: Any) {

        let firebaseAuth = Auth.auth()

        do {
            // MARK: Firebase Logout
            try firebaseAuth.signOut()

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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
