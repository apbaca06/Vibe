//
//  AnimationViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/11.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import SwiftyGif
import Firebase
import KeychainSwift
import CoreLocation

class AnimationViewController: UIViewController {

    let locationManager = CLLocationManager()

    @IBOutlet weak var animationView: UIImageView!
    let keychain = KeychainSwift()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()

        let gifManager1 = SwiftyGifManager(memoryLimit: 20)
        let gif1 = UIImage(gifName: "giphy (1).gif")

        self.animationView.setGifImage(gif1, manager: gifManager1)

        let gifManager2 = SwiftyGifManager(memoryLimit: 20)
        let gif2 = UIImage(gifName: "animation.gif")
        self.animationView.setGifImage(gif2, manager: gifManager2)

        if Auth.auth().currentUser != nil {

            guard let email = keychain.get("userEmail"),
                let password = keychain.get("userPassword")

                else {

                    let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

                    AppDelegate.shared.window?.rootViewController = loginViewController
                    return
            }

            QuickbloxManager.logInSync(

                withUserEmail: email,

                password: password
            )

        } else {

            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")

            AppDelegate.shared.window?.rootViewController = loginViewController
        }
    }

    override func viewDidAppear(_ animated: Bool) {

    }
}

extension AnimationViewController: CLLocationManagerDelegate {

    // MARK: Detect Location
    func setupLocationManager() {

        self.locationManager.delegate = self

        self.locationManager.distanceFilter = kCLLocationAccuracyBest

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.requestWhenInUseAuthorization()

        locationManager.startUpdatingLocation()

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
        locationManager.stopUpdatingLocation()
    }
}
