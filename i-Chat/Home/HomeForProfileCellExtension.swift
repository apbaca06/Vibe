//
//  HomeForProfileCellExtension.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

extension HomeViewController: CLLocationManagerDelegate {

    @objc func changeImg() {

        let imgPickerViewController = ImgPickerViewController()

        present(imgPickerViewController, animated: true, completion: nil)
    }

    @objc func toSettingPage() {

        let settingTableViewController = SettingTableViewController()

        let navSettingTableViewController = UINavigationController(rootViewController: settingTableViewController)

        present(navSettingTableViewController, animated: true, completion: nil)

    }

    func checkIfAllowTrackLocation() {

//        // 1. 還沒有詢問過用戶以獲得權限
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//
//            if  CLLocationManager.locationServicesEnabled() {
//
//                locationManager.requestAlwaysAuthorization()
//            }
//        }
//            // 2. 用戶不同意
//        else if CLLocationManager.authorizationStatus() == .denied {
//
//            DispatchQueue.main.async {
//                UIAlertController(title: NSLocalizedString("Please turn on permission for tracking", comment: ""), message: "Inorder to detect location", preferredStyle: .alert).show()
//            }
//        }
//            // 3. 用戶已經同意
//        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
//
//            locationManager.startUpdatingLocation()
//        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]

        locationManager.stopUpdatingLocation()
    }

}
