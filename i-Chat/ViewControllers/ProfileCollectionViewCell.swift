//
//  ProfileCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toProfilePage: UIButton!
    @IBAction func toSettingPage(_ sender: Any) {
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
