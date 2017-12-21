//
//  ProfileCollectionViewCell.swift
//  i-Chat
//
//  Created by cindy on 2017/12/17.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProfileCollectionViewCell: UICollectionViewCell {

//    if sender.state == .began {
//        
//        self.becomeFirstResponder()
//        self.viewForReset = sender.view
//        
//        // Configure the menu item to display
//        let menuItemTitle = NSLocalizedString("Reset", comment: "Reset menu item title")
//        let action = #selector(ViewController.resetPiece(controller:))
//        let resetMenuItem = UIMenuItem(title: menuItemTitle, action: action)
//        
//        // Configure the shared menu controller
//        let menuController = UIMenuController.shared
//        menuController.menuItems = [resetMenuItem]
//        
//        // Set the location of the menu in the view.
//        let location = sender.location(in: sender.view)
//        let menuLocation = CGRect(x: location.x, y: location.y, width: 0, height: 0)
//        menuController.setTargetRect(menuLocation, in: sender.view!)
//        
//        // Show the menu.
//        menuController.setMenuVisible(true, animated: true)
//        }

    @IBOutlet weak var toProfilePage: UIButton!

    @IBOutlet weak var toSettingButton: UIButton!

    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var profileImg: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
