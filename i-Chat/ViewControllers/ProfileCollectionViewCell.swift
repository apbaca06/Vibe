//
//  ProfileCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toProfilePage: UIButton!
    @IBAction func toSettingPage(_ sender: Any) {

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
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImg: UIButton!

    @IBAction func changeImg(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
