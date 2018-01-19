//
//  SwipingCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Koloda
import Firebase
import KeychainSwift

class SwipingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var warningLabel: UILabel!

    @IBOutlet weak var buttonView: UIView!

    @IBOutlet weak var dislikeButton: UIButton!

    @IBOutlet weak var likeButton: UIButton!

    @IBOutlet weak var swipeView: KolodaView!

    let keychain = KeychainSwift()

    @IBAction func dislikeIt(_ sender: UIButton) {
        swipeView.swipe(.left)
    }
    @IBAction func likeIt(_ sender: UIButton) {
        swipeView.swipe(.right)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {
        super.prepareForReuse()

    }

}
