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
import Crashlytics

public enum UserProviderError: Error {

    case missingValueForCurrentUser

    case qeuryForGenderPreferenceError

    case loadSwipeViewError

    case notObject

}

protocol UserProviderDelegate: class {

    func userProvider(_ provider: UserProvider, didFetch distanceUser: [(User, Int)], didFetch allUsers: [(User, Int)], didFetch currentUser: User)

}

class UserProvider {

    var users: [User] = []

    typealias DistanceUser = (User, Int)

    var runOutHandel: UInt?

    var currentAuthUser: User?

    var distanceUsers: [DistanceUser] = []

    var minAgePreference: Int?

    var maxAgePreference: Int?

    weak var delegate: UserProviderDelegate?

    let keychain = KeychainSwift()

    func loadSwipeImage(prefUserObserveType: DataEventType) {

        guard let uid = keychain.get("uid")
            else { return }

        DatabasePath
            .userRef
            .child(uid)
            .observeSingleEvent(of: .value, with: { (datasnapshot) in

            let userDic = [ datasnapshot.key: datasnapshot.value]
            do {
                let currentUser =  try User(userDic)
                self.currentAuthUser = currentUser

                self.keychain.set("\(currentUser.name)", forKey: "name")
                self.keychain.set("\(currentUser.profileImgURL)", forKey: "profileImgURL")
                self.keychain.set("\(currentUser.cityName)", forKey: "cityName")
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

                DatabasePath
                    .userRef
                    .queryOrdered(byChild: "gender")
                    .queryEqual(toValue: preference)
                    .observeSingleEvent(of: prefUserObserveType) { (dataSnapshot) in

                        guard let datas = dataSnapshot.value as? [String: Any]
                            else { return }
                        self.distanceUsers = []
                        var allUsers: [(User, Int)] = []

                        for data in datas {

                            do {
                                let userDic = [data.key: data.value]
                                let user = try User(userDic)

                                let location1 = CLLocation(latitude: latitude, longitude: longitude)
                                let location2 = CLLocation(latitude: user.latitude, longitude: user.longitude)
                                let distanceBtwn = Int((location1.distance(from: location2))/1000)

                                if user.email != Auth.auth().currentUser?.email {
                                    allUsers.append((user, distanceBtwn))
                                }

                                guard let currentUser = self.currentAuthUser
                                else { return }

                                if user.email != Auth.auth().currentUser?.email && user.age >= minAge && user.age <= maxAge && distanceBtwn <= maxDistance && currentUser.likeUserID.has(key: user.id) == false {
                                    self.distanceUsers.append((user, distanceBtwn))
                                }
                            } catch {
                                print("Some user with not enough data!")
                            }
                        }
                        guard let user = self.currentAuthUser
                            else { return }
                        if self.distanceUsers.count == 0 {
                            self.delegate?.userProvider(self, didFetch: self.distanceUsers, didFetch: allUsers, didFetch: user)
                        } else {
                            self.delegate?.userProvider(self, didFetch: self.distanceUsers, didFetch: allUsers, didFetch: user)
                        }

                }

            } catch {

                return
            }
        }) { (error)  in

            print("Error", error)

        }

    }

    func runOutOfSwipeCard(completionHandler: @escaping (UInt?) -> Void) {

        guard let preference = self.keychain.get("preference"),
            let latitude = Double(self.keychain.get("latitude")!),
            let longitude = Double(self.keychain.get("longitude")!)
            else { return }

        self.runOutHandel = DatabasePath
            .userRef
            .queryOrdered(byChild: "gender")
            .queryEqual(toValue: preference)
            .observe( .value) { (dataSnapshot) in

                guard let datas = dataSnapshot.value as? [String: Any]
                    else { return }
                var allUsers: [(User, Int)] = []

                for data in datas {

                    do {
                        let userDic = [data.key: data.value]
                        let user = try User(userDic)
                        let location1 = CLLocation(latitude: latitude, longitude: longitude)
                        let location2 = CLLocation(latitude: user.latitude, longitude: user.longitude)
                        let distanceBtwn = Int((location1.distance(from: location2))/1000)
                        if user.email != Auth.auth().currentUser?.email {
                            allUsers.append((user, distanceBtwn))
                        }
                    } catch {
                        print("Some user with not enough data!")
                    }
                }

                guard let user = self.currentAuthUser
                    else { return }
                self.delegate?.userProvider(self, didFetch: [], didFetch: allUsers, didFetch: user)
                completionHandler(self.runOutHandel)
        }
    }

}
