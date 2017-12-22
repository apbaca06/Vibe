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

    // MARK: Funtion for Profile Cell
    @objc func changeImg() {

        let imgPickerViewController = ImgPickerViewController()

        present(imgPickerViewController, animated: true, completion: nil)
    }

    @objc func toSettingPage() {

        let settingTableViewController = SettingTableViewController()

        settingTableViewController.cityName = self.cityName

        print(settingTableViewController.cityName, "***")

        let navSettingTableViewController = UINavigationController(rootViewController: settingTableViewController)

        present(navSettingTableViewController, animated: true, completion: nil)

    }

    // MARK: Detect Location
    func setupLocationManager() {

        self.locationManager.delegate = self

        self.locationManager.distanceFilter = kCLLocationAccuracyBest

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

        DatabasePath.userRef.child(FirebaseManager.uid).child("location").updateChildValues(["latitude": locationManager.location?.coordinate.latitude,
                                                    "logitude": locationManager.location?.coordinate.longitude])

        let geoCoder = CLGeocoder()

        guard let location = locationManager.location

            else { return }

        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in

            if error != nil {

                print(error)
                return
            }
            guard let existPlacemarks = placemarks
                else { return }
            let placemark = existPlacemarks[0] as CLPlacemark
            let cityName = placemark.locality

            guard let city = cityName
                else { return }
            self.cityName = city
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print("***", location)

        locationManager.stopUpdatingLocation()
    }

}
