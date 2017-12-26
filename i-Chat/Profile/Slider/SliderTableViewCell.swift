//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var cellName: UILabel!

    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var textfield: UITextField!

    let pickerView2 = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.inputView = pickerView2

    }

}
