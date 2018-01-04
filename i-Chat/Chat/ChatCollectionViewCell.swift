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

    @IBOutlet weak var label: UILabel!

    var friendList: [User] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = NSLocalizedString("Friends", comment: "")
        label.textColor = UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)

    }

}
