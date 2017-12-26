//
//  SwitchTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var `switch`: UISwitch!

    @IBOutlet weak var cellLabel: UILabel!

    @IBAction func touchSwitch(_ sender: UISwitch) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
