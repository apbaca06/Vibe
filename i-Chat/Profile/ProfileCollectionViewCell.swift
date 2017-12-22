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

    override func awakeFromNib() {
        super.awakeFromNib()
            DatabasePath.userRef.child(FirebaseManager.uid).child("profileImgURL").observeSingleEvent(of: .value) { (datashot) in
                if let dic = datashot.value  as? String,
//                    let profileImgURLString = dic["profileImgURL"] as? String,
                    let profileImgURL = URL(string: dic) as? URL {
                    Manager.shared.loadImage(with: profileImgURL, into: self.profileImg)
                    self.profileImg.contentMode = .scaleAspectFit
                    self.reloadInputViews()
                }
        }

    }

}
