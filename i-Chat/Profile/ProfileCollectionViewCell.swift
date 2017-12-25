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

            DatabasePath.userRef.child(FirebaseManager.uid).child("profileImgURL").observeSingleEvent(of: .value) { (datashot) in
                if let profileImgString = datashot.value  as? String,
                    let profileImgURL = URL(string: profileImgString) {

                    Manager.shared.loadImage(with: profileImgURL, into: self.profileImg)

                    self.profileImg.contentMode = .scaleAspectFit

                    self.reloadInputViews()
                }

        }

    }

}
