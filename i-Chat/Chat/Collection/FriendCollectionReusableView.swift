//
//  FriendCollectionReusableView.swift
//  i-Chat
//
//  Created by cindy on 2018/1/4.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var numberOfLikeLabel: UILabel!
    @IBOutlet weak var numberOfLikeView: UIImageView!
    @IBOutlet weak var likePhoto: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        likePhoto.layer.cornerRadius = likePhoto.frame.width/2
        likePhoto.clipsToBounds = true
        likePhoto.image = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysTemplate)
        likePhoto.tintColor = .gray

        numberOfLikeView.layer.cornerRadius = numberOfLikeView.frame.width/2
        numberOfLikeView.clipsToBounds = true

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        blurEffectView.frame = likePhoto.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        likePhoto.addSubview(blurEffectView)

    }

}
