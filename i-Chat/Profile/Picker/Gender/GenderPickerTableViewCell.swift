//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import KeychainSwift

class GenderPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!

    @IBOutlet weak var textfield: UITextField!

    let pickerView = UIPickerView()

    let keychain = KeychainSwift()

    override func awakeFromNib() {
        super.awakeFromNib()

        textfield.text = self.keychain.get("preference")

        textfield.inputView = pickerView

    }

}
