//
//  UserProvider.swift
//  i-Chat
//
//  Created by cindy on 2017/12/29.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Nuke
import KeychainSwift
import Firebase
import MapKit

protocol UserProviderDelegate: class {

    func userProvider(_ provider: UserProvider, didFetch users: [User], didGet distanceBtwn: [Int], didFetch currentUser: User)

}

class UserProvider {

    var users: [User] = []

    var distanceBtwn: [Int] = []

    var minAgePreference: Int?

    var maxAgePreference: Int?

    weak var delegate: UserProviderDelegate?

    let keychain = KeychainSwift()

    func loadSwipeImage() {

        guard let uid = keychain.get("uid")
            else { return }

        DatabasePath.userRef.child(uid).observeSingleEvent(of: .value) { [unowned self] (datashot) in
            do {

                    let userDic = [ datashot.key: datashot.value]

                    let currentUser = try User(userDic)

                    self.keychain.set("\(currentUser.gender)", forKey: "gender")
                    self.keychain.set("\(currentUser.minAge)", forKey: "minAge")
                    self.keychain.set("\(currentUser.maxAge)", forKey: "maxAge")
                    self.keychain.set("\(currentUser.preference.rawValue)", forKey: "preference")
                    self.keychain.set("\(currentUser.maxDistance)", forKey: "maxDistance")
                    self.keychain.set("\(currentUser.latitude)", forKey: "latitude")
                    self.keychain.set("\(currentUser.longitude)", forKey: "longitude")

                guard let minAge = Int(self.keychain.get("minAge")!),
                    let maxAge = Int(self.keychain.get("maxAge")!),
                    let preference = self.keychain.get("preference"),
                    let maxDistance = Int(self.keychain.get("maxDistance")!),
                    let latitude = Double(self.keychain.get("latitude")!),
                    let longitude = Double(self.keychain.get("longitude")!)
                    else { return }

                DatabasePath.userRef.queryOrdered(byChild: "gender").queryEqual(toValue: preference).observe(.value) { (dataSnapshot) in
                    do {

                        guard let datas = dataSnapshot.value as? [String: Any]

                            else { return }

                        for data in datas {

                            let userDic = [data.key: data.value]

                            let user = try User(userDic)

                            let location1 = CLLocation(latitude: latitude, longitude: longitude)
                            let location2 = CLLocation(latitude: user.latitude, longitude: user.longitude)

                            let distanceBtwn = Int((location1.distance(from: location2))/1000)

                            if user.email != Auth.auth().currentUser?.email && user.age >= minAge && user.age <= maxAge && distanceBtwn <= maxDistance {
                                self.users.append(user)
                                self.distanceBtwn.append(distanceBtwn)
                                self.delegate?.userProvider(self, didFetch: self.users, didGet: self.distanceBtwn, didFetch: currentUser)
                            }
                        }

                    } catch {
                        print(error, "**")
                    }
                }
            } catch {
                print(error, "**")
            }
        }
    }
}
