//
//  SwipingCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Koloda

class SwipingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var separatorView: UILabel!

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cursorImageView: UIImageView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var dislikeButton: UIButton!

    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var swipeView: KolodaView!

    @IBAction func dislikeIt(_ sender: UIButton) {
        swipeView.swipe(.left)
    }
    @IBAction func likeIt(_ sender: UIButton) {
        swipeView.swipe(.right)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
