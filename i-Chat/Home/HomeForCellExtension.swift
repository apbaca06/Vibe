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

extension HomeViewController: CLLocationManagerDelegate, FriendCollectionViewControllerDelegate {
    func controller(_ controller: FriendCollectionViewController, didCall user: (User, String, Bool)) {
        switch user.2 {

            case true:
                let alertController = UIAlertController(title: NSLocalizedString("Unable to contact \(user.0.name)!", comment: ""), message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.show()

            case false:
            guard let callOutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallOutViewController") as? CallOutViewController
                else { return }
            callOutViewController.reciever = user.0
            callOutViewController.chatroomID = user.1
            present(callOutViewController, animated: true, completion: nil)
        }
    }

//    func controller(_ controller: FriendCollectionViewController, didCall user: (User,String) {
//
//        CallManager.shared.audioCall(toUser: user.)
//
//        guard let callOutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallOutViewController") as? CallOutViewController
//        else { return }
//        callOutViewController.reciever = user
//        present(callOutViewController, animated: true, completion: nil)
//    }

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

        let alert = UIAlertController(title: NSLocalizedString("No more cards", comment: ""), message: NSLocalizedString("Please change your preference to meet more people!", comment: ""), preferredStyle: .alert)

        alert.addAction(title: NSLocalizedString("OK", comment: ""))

        alert.show()

        self.collectionView?.reloadData()
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        // TODO: Add profile page
    }

}

// MARK: KolodaViewDataSource

extension HomeViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {

        return distanceUsers.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        guard let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView
        else {
            return UIView()
        }

        if distanceUsers.count <= index {

            let myView = UIView()
            myView.backgroundColor = .black

            return myView
        } else {

            cardView.ageLabel.text = String(describing: distanceUsers[index].0.age)
            cardView.nameLabel.text = String(describing: distanceUsers[index].0.name)
            cardView.distanceLabel.text = "\(String(describing: distanceUsers[index].1)) km"
            cardView.cityName.text = distanceUsers[index].0.cityName
            let imageURL = URL(string: distanceUsers[index].0.profileImgURL)!
            Manager.shared.loadImage(with: imageURL, into: cardView.imageView)
            return cardView
        }
    }

    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {

        guard let uid = self.keychain.get("uid")
            else { return }

        if direction == .left {

            FirebaseManager.userUnlike(uid: uid, recieverUid: distanceUsers[index].0.id)
        }

        if direction == .right {

            FirebaseManager.userLike(uid: uid, recieverUid: distanceUsers[index].0.id)
            FirebaseManager.userSwipedLike(uid: uid, recieverUid: distanceUsers[index].0.id)
            FirebaseManager.findIfWasSwiped(uid: uid, recieverUid: distanceUsers[index].0.id, completionHandler: showIsMatchedView)

        }
    }
    func showIsMatchedView(isMatch: Bool) {

        if isMatch == true {

            // swiftlint:disable force_cast
            let matchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "matchViewController") as! MatchViewController
            // swiftlint:enable force_cast

            matchViewController.modalPresentationStyle = .overFullScreen
            matchViewController.modalTransitionStyle = .crossDissolve
            self.state = matchViewController.state
            present(matchViewController, animated: true, completion: nil)
        }

    }
}
