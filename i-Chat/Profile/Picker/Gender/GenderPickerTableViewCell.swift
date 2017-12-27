//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class GenderPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!

    @IBOutlet weak var textfield: UITextField!

    let pickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()

        textfield.text = "Male"
//        textfield.text = DatabasePath.userRef.child(FirebaseManager.uid).child(<#T##pathString: String##String#>)

        textfield.inputView = pickerView

    }

}
