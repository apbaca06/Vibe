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
import Nuke
import KeychainSwift

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var toProfilePage: UIButton!

    @IBOutlet weak var toSettingButton: UIButton!

    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var profileDescription: UILabel!

    @IBOutlet weak var settingDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        ageLabel.cornerRadius = ageLabel.bounds.width/2

        profileDescription.text = NSLocalizedString("Profile", comment: "")

        settingDescription.text = NSLocalizedString("Setting", comment: "")

        profileImg.cornerRadius = 40

        if #available(iOS 11.0, *) {
            profileImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }

        let keychain = KeychainSwift()

        guard let uid = keychain.get("uid")
            else { return }

            DatabasePath.userRef.child(uid).observeSingleEvent(of: .value) { [unowned self] (datashot) in

                guard let jsonObject = datashot.value as? [String: Any],
                      let name = jsonObject["name"] as? String,
                      let age = jsonObject["age"] as? Int,
                      let profileImgString = jsonObject["profileImgURL"]  as? String
                else { return }

                self.nameLabel.text = name

                self.ageLabel.text = String(describing: age)

                if let profileImgURL = URL(string: profileImgString) {

                    Manager.shared.loadImage(with: profileImgURL, into: self.profileImg)

                    self.reloadInputViews()

                    self.profileImg.contentMode = .center
                }

        }

    }

}
