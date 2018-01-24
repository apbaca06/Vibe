//
//  CardView.swift
//  i-Chat
//
//  Created by cindy on 2017/12/29.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var bottomView: UIView!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var separatorView: UIView!

    @IBOutlet weak var locationImg: UIImageView!

    @IBOutlet weak var cursorImg: NSLayoutConstraint!

    @IBOutlet weak var backgounrdView: UIView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var cityName: UILabel!

    @IBOutlet weak var reportButton: UIButton!

    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        reportButton.backgroundColor = .gray
        reportButton.layer.cornerRadius = reportButton.frame.width/2

    }

}
