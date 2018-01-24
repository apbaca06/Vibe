//
//  BaseCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class BaseCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

    }

    func setupViews() {

    }

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
}
