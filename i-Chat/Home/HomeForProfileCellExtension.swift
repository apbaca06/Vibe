//
//  HomeForProfileCellExtension.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

extension HomeViewController {

    @objc func changeImg() {

        let imgPickerViewController = ImgPickerViewController()

        present(imgPickerViewController, animated: true, completion: nil)
    }

    @objc func toSettingPage() {

        let settingTableViewController = SettingTableViewController()

        let navSettingTableViewController = UINavigationController(rootViewController: settingTableViewController)

        present(navSettingTableViewController, animated: true, completion: nil)

    }

    @objc func toEditProfile() {

    }

}
