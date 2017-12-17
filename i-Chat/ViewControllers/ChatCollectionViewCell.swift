//
//  ChatCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        setUpActionButton()

    }

    private func setUpActionButton() {

        let button = self.button!

//        button.setTitle(
//            button,
//            for: .normal
//        )

//        button.setTitleColor(
//            UIColor(
//                red: 255.0 / 255.0,
//                green: 94.0 / 255.0,
//                blue: 89.0 / 255.0,
//                alpha: 1.0
//            ),
//            for: .normal
//        )

        button.titleLabel?.font = UIFont.systemFont(
            ofSize: 16.0,
            weight: UIFont.Weight.semibold
        )

//        button.contentEdgeInsets = UIEdgeInsets(
//            top: 6.0,
//            left: 10.0,
//            bottom: 6.0,
//            right: 10.0
//        )

        button.layer.cornerRadius = 2.0

        button.layer.shadowColor = UIColor.black.cgColor

        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)

        button.layer.shadowOpacity = 0.3

        button.layer.shadowRadius = 2.0

    }

}
