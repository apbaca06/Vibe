//
//  MenuCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: BaseCell {

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 240/255, green: 200/255, blue: 8/255, alpha: 0.3)
        return iv
    }()

    override var isHighlighted: Bool {

        didSet {
            imageView.tintColor = isHighlighted ? UIColor(red: 240/255, green: 200/255, blue: 8/255, alpha: 1) : UIColor(red: 240/255, green: 200/255, blue: 8/255, alpha: 0.3)
        }
    }

    override var isSelected: Bool {

        didSet {
            imageView.tintColor = isSelected ? UIColor(red: 240/255, green: 200/255, blue: 8/255, alpha: 1) : UIColor(red: 240/255, green: 200/255, blue: 8/255, alpha: 0.3)
        }

    }

    override func setupViews() {

        super.setupViews()

        addSubview(imageView)

        addConstraints(withFormat: "H:[v0(28)]", views: imageView)

        addConstraints(withFormat: "V:[v0(28)]", views: imageView)

        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
