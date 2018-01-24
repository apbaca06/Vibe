//
//  HomeForProfileCellExtension.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift
import Koloda
import Nuke
import CoreLocation
import SVProgressHUD

extension HomeViewController: FriendCollectionViewControllerDelegate {

    @objc func callOther() {

        QBRTCAudioSession.instance().currentAudioDevice = .receiver

        // swiftlint:disable force_cast
        let callOutViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CallOutViewController") as! CallOutViewController
        // swiftlint:enable force_cast

        self.present(callOutViewController, animated: true, completion: nil)
    }

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
            self.userInfo = ["Name": user.0.name, "profileImgURL": user.0.profileImgURL]
//            CallManager.shared.audioCall(toUser: user.0)
            QuickbloxManager.connectQB(toUser: user.0, completionHandler: { (response) in
                if response == true {
                    self.present(callOutViewController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: NSLocalizedString("Unable to contact \(user.0.name)!", comment: ""), message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                    alertController.addAction(okAction)
                    alertController.show()
                }
            })
//            present(callOutViewController, animated: true, completion: nil)
        }
    }

    // MARK: Funtion for Profile Cell
    @objc func showSelfProfile() {

        let editProfileTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileTableViewController")

        let navEditProfileTableViewController = UINavigationController(rootViewController: editProfileTableViewController)

        present(navEditProfileTableViewController, animated: true, completion: nil)

    }

    @objc func toSettingPage() {

        if let cityName = keychain.get("cityName") {

            settingTableViewController.cityName = cityName
        }

        let navSettingTableViewController = UINavigationController(rootViewController: settingTableViewController)

        present(navSettingTableViewController, animated: true, completion: nil)
    }

}

// MARK: KolodaViewDelegate

extension HomeViewController: KolodaViewDelegate {

    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {

        distanceUsers = []
//        allUsers = []

//        userProvider.runOutOfSwipeCard { (handle) in
//            guard let preference = self.keychain.get("preference"),
//                  let handle = handle
//                else { return }
//            DatabasePath
//                .userRef
//                .queryOrdered(byChild: "gender")
//                .queryEqual(toValue: preference)
//                .removeObserver(withHandle: handle)
//        }

        let alert = UIAlertController(title: NSLocalizedString("No more cards", comment: ""), message: NSLocalizedString("Please change your preference to meet more people!", comment: ""), preferredStyle: .alert)

        alert.addAction(title: NSLocalizedString("OK", comment: ""))

        alert.show()
        self.collectionView?.reloadData()

    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {

        if wantToReport == true {
            guard let uid = self.keychain.get("uid")
                else { return }

        }
    }

}

// MARK: KolodaViewDataSource

extension HomeViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {

        if distanceUsers.count == 0 {
//            self.collectionView?.reloadData()
//            let alert = UIAlertController(title: NSLocalizedString("No more cards", comment: ""), message: NSLocalizedString("Please change your preference to meet more people!", comment: ""), preferredStyle: .alert)
//
//            alert.addAction(title: NSLocalizedString("OK", comment: ""))
//
//            alert.show()
            return distanceUsers.count

        } else {
            return distanceUsers.count
        }

//        if distanceUsers.count == 0 {
//            return allUsers.count
//        } else {
//            return distanceUsers.count
//        }
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }

    @objc func reportUser(_ sender: UIButton) {

        let index = sender.tag
        reportViewController.reportedID = self.distanceUsers[index].0.id

//        guard let uid = self.keychain.get("uid")
//            else { return }

        let actionSheetController = UIAlertController(title: NSLocalizedString("Please select", comment: "" ), message: "", preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let reportActionSheet = UIAlertAction(title: NSLocalizedString("Report", comment: "" ), style: .default) { _ -> Void in

            self.present(self.reportViewController, animated: true, completion: nil)

            print("Report")
        }
        actionSheetController.addAction(reportActionSheet)

        self.present(actionSheetController, animated: true, completion: nil)

    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        guard let cardView = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? CardView
        else {
            return UIView()
        }
        cardView.reportButton.tag = koloda.currentCardIndex

        cardView.reportButton.addTarget(self, action: #selector(reportUser(_ :)), for: .touchUpInside)

        if self.distanceUsers.count != 0 {
            cardView.ageLabel.text = String(describing: distanceUsers[index].0.age)
            cardView.nameLabel.text = String(describing: distanceUsers[index].0.name)
            cardView.distanceLabel.text = "\(String(describing: distanceUsers[index].1)) km"
            cardView.cityName.text = distanceUsers[index].0.cityName
            let imageURL = URL(string: distanceUsers[index].0.profileImgURL)!
            Manager.shared.loadImage(with: imageURL, into: cardView.imageView)
            return cardView
        } else {
            cardView.ageLabel.text = String(describing: allUsers[index].0.age)
            cardView.nameLabel.text = String(describing: allUsers[index].0.name)
            cardView.distanceLabel.text = "\(String(describing: allUsers[index].1)) km"
            cardView.cityName.text = allUsers[index].0.cityName
            let imageURL = URL(string: allUsers[index].0.profileImgURL)!
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

            if distanceUsers.count != 0 {

            FirebaseManager.userUnlike(uid: uid, recieverUid: distanceUsers[index].0.id)
            } else {
                FirebaseManager.userUnlike(uid: uid, recieverUid: allUsers[index].0.id)
            }
        }

        if direction == .right {
            if distanceUsers.count != 0 {
                FirebaseManager.userLike(uid: uid, recieverUid: distanceUsers[index].0.id)
                FirebaseManager.userSwipedLike(uid: uid, recieverUid: distanceUsers[index].0.id)
                FirebaseManager.findIfWasSwiped(uid: uid, recieverUid: distanceUsers[index].0.id, completionHandler: showIsMatchedView)
            } else {
                FirebaseManager.userLike(uid: uid, recieverUid: allUsers[index].0.id)
                FirebaseManager.userSwipedLike(uid: uid, recieverUid: allUsers[index].0.id)
                FirebaseManager.findIfWasSwiped(uid: uid, recieverUid: allUsers[index].0.id, completionHandler: showIsMatchedView)
            }
        }
    }

    func showIsMatchedView(isMatch: Bool) {

        if isMatch == true {
            // swiftlint:disable force_cast
            let matchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "matchViewController") as! MatchViewController
            // swiftlint:enable force_cast

            matchViewController.modalPresentationStyle = .overFullScreen
            matchViewController.modalTransitionStyle = .crossDissolve

            self.addChildViewController(matchViewController)

            self.view.addSubview(matchViewController.view)
            matchViewController.didMove(toParentViewController: self)
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {

    // MARK: Detect Location
    func setupLocationManager() {

        guard let uid = self.keychain.get("uid")
            else { return }

        DatabasePath.userRef
            .child(uid)
            .child("location")
            .updateChildValues(["latitude": locationManager.location?.coordinate.latitude, "longitude": locationManager.location?.coordinate.longitude]) { (error, _) in
                if error == nil {

                    let geoCoder = CLGeocoder()

                    guard let location = self.locationManager.location
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
                        DatabasePath.userRef.child(uid).child("location")
                            .updateChildValues(["cityName": city], withCompletionBlock: { (error, _) in
                                if error == nil {

                                }
                            })
                    }

                }
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        setupLocationManager()
        locationManager.stopUpdatingLocation()
    }
}
