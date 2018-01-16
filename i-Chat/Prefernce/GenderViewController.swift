//
//  GenderViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/21.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD
import Firebase
import KeychainSwift
import CoreLocation
import Crashlytics

class GenderViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    var cityName: String?

    @IBOutlet weak var decriptionLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!

    let keychain = KeychainSwift()

    @IBAction func maleAction(_ sender: UIButton) {

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).updateChildValues(["gender": "Male"]) { (_, _) in

        }

    }

    @IBAction func womanAction(_ sender: Any) {

        guard let uid = keychain.get("uid")
            else { return }
        DatabasePath.userRef.child(uid).updateChildValues(["gender": "Female"]) { (error, _) in

            if error != nil {
                let preferenceViewController = PreferenceViewController()
                self.navigationController?.pushViewController(preferenceViewController, completion: nil)
            } else {

            }
        }

//        DatabasePath.userRef.child(uid).updateChildValues(["gender": "Female"])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.dismiss()

        decriptionLabel.text = NSLocalizedString("Please insert your gender", comment: "")
        maleButton.tintColor = UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        maleButton.cornerRadius = maleButton.bounds.width/2

        womanButton.cornerRadius = womanButton.bounds.width/2
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        SVProgressHUD.dismiss()
        setupLocationManager()

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

        SVProgressHUD.show(withStatus: NSLocalizedString("Updating profile", comment: ""))

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
                        self.cityName = city
                        DatabasePath.userRef.child(uid).child("location")
                            .updateChildValues(["cityName": city], withCompletionBlock: { (error, _) in
                                if error == nil {
                                    SVProgressHUD.dismiss()
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
