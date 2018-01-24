//
//  MultipleTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/27.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class MultipleTableViewCell: UITableViewCell {

    @IBOutlet weak var rightLabel: UILabel!

    @IBOutlet weak var leftLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
