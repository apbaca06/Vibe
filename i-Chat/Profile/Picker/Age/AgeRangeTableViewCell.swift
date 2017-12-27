//
//  AgeRangeTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class AgeRangeTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!

    @IBOutlet weak var maxLabel: UILabel!

    @IBOutlet weak var minLabel: UILabel!

    @IBOutlet weak var maxAgeTextField: UITextField!

    @IBOutlet weak var minAgeTextField: UITextField!

    let minAgePickerView = UIPickerView()

    let maxAgePickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()

        minAgeTextField.text = "18"

        maxAgeTextField.text = "55"

        minAgeTextField.inputView = minAgePickerView

        minAgePickerView.tag = 1

        maxAgeTextField.inputView = maxAgePickerView

        maxAgePickerView.tag = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
