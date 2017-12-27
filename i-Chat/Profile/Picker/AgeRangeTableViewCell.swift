//
//  AgeRangeTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class AgeRangeTableViewCell: UITableViewCell {

    @IBOutlet weak var maxAgeTextField: UITextField!
    @IBOutlet weak var minAgeTextField: UITextField!

    let pickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()

        minAgeTextField.inputView = pickerView

        maxAgeTextField.inputView = pickerView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
