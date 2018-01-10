//
//  FriendCollectionReusableView.swift
//  i-Chat
//
//  Created by cindy on 2018/1/4.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var leftLabel: UILabel!

    @IBOutlet weak var numberOfFriends: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        leftLabel.text = NSLocalizedString("Friends", comment: "")

    }

}
