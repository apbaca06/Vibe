//
//  FriendCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2018/1/2.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let userImage = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysTemplate)
        profileImageView.image = userImage
        profileImageView.tintColor = .yellow

        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.clipsToBounds = true

        let image = #imageLiteral(resourceName: "pickup").withRenderingMode(.alwaysTemplate)
        callButton.setImage(image, for: .normal)

        callButton.tintColor = UIColor(red: 215/255.0, green: 38/255.0, blue: 56/255.0, alpha: 1)

    }

}
