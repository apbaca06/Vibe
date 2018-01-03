//
//  FriendTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/30.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBAction func callFriend(_ sender: Any) {

    }
    @IBOutlet weak var callButton: UIButton!

    @IBOutlet weak var friendImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        friendImageView.layer.cornerRadius = friendImageView.bounds.width/2
        callButton.layer.cornerRadius = callButton.bounds.width/2
    }

}
