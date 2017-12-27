//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellName: UILabel!

    @IBOutlet weak var textfield: UITextField!

    let pickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()

        textfield.inputView = pickerView

    }

}
