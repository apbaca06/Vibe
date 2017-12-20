//
//  ProfileCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase
class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toProfilePage: UIButton!
    @IBAction func toSettingPage(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()

            print("**", Auth.auth().currentUser)
            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

            QBRequest.logOut(successBlock: { (response) in
                print("**QB Logout")
            }, errorBlock: { (_) in
                // Error handling
            })

            QBChat.instance.disconnect { [weak self] (error) in

                print("DISCONNECT RESULT RECEIVED") // breakpoint here
                if let error = error {
                    print("DISCONNECT ERROR \(error)")
                } else {
                    print("DISCONNECTED SUCCESSFULLY")
                }
            }

            AppDelegate.shared.window?.rootViewController = loginViewController
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
