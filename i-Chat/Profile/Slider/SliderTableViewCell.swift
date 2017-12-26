//
//  SliderTableViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {

    @IBOutlet weak var ageRangeLabel: UILabel!

//    @IBAction func changeSliderValue(_ sender: UISlider) {
//
//        sliderRange.text = "\(Int(sender.value))"
//
//        if Int(sender.value) == 55 {
//            sliderRange.text = "55+"
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()

        ageRangeLabel.text = NSLocalizedString("Age Range", comment: "")

//        sliderRange.text = "25"
//        slider.minimumValue = 18
//        slider.maximumValue = 55
//        slider.value = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
