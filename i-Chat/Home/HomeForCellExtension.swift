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
import KeychainSwift
import Koloda
import Nuke

extension HomeViewController: CLLocationManagerDelegate {

    // MARK: Funtion for Profile Cell
    @objc func changeImg() {

        let imgPickerViewController = ImgPickerViewController()

        present(imgPickerViewController, animated: true, completion: nil)
    }

    @objc func toSettingPage() {

        let settingTableViewController = SettingTableViewController()

        settingTableViewController.cityName = self.cityName

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

        guard let uid = self.keychain.get("uid")
            else { return }

        DatabasePath.userRef.child(uid).child("location").updateChildValues(["latitude": locationManager.location?.coordinate.latitude,
                                                    "longitude": locationManager.location?.coordinate.longitude])

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
            DatabasePath.userRef.child(uid).child("location").updateChildValues(["cityName": city])
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]

        locationManager.stopUpdatingLocation()
    }

}

// MARK: KolodaViewDelegate

extension HomeViewController: KolodaViewDelegate {

    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {

        let position = koloda.currentCardIndex
        //        for i in 1...4 {
        //            dataSource.append(UIImage(named: "Card_like_\(i)")!)
        //        }
        //        koloda.insertCardAtIndexRange(position..<position + 4, animated: true)
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }

}

// MARK: KolodaViewDataSource

extension HomeViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return userArray.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        guard let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView
        else {
            return UIView()
        }

        if userArray.count <= index {

            let myView = UIView()
            myView.backgroundColor = .black

            return myView
        } else {

            cardView.ageLabel.text = String(describing: userArray[index].age)
            cardView.nameLabel.text = String(describing: userArray[index].name)
            cardView.distanceLabel.text = "\(String(describing: distanceBtwnArray[index])) km"
            let imageURL = URL(string: userArray[index].profileImgURL)!
            Manager.shared.loadImage(with: imageURL, into: cardView.imageView)
    //        cardView.cityName.text = String(describing: userArray[index].name)
            return cardView
        }
    }

    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
