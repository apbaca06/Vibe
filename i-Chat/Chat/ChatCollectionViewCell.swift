//
//  ChatCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase
import Nuke

class ChatCollectionViewCell: UICollectionViewCell {

    var friendList: [User] = []

    override func awakeFromNib() {
        super.awakeFromNib()
//        FirebaseManager.getFriendList(completionHandler: friendList)

//        setUpCallButton()

    }

}
