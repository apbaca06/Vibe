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

protocol UserProviderDelegate: class {

    func userProvider(_ provider: UserProvider, didFetch users: [User])
    func userProvider(_ provider: UserProvider, didFetch user: User?)

}

class UserProvider {

    var users: [User] = []

    var minAgePreference: Int?

    var maxAgePreference: Int?

    weak var delegate: UserProviderDelegate?

    let keychain = KeychainSwift()

    func fetchCurrentUser() {
//
//        guard let uid = keychain.get("uid")
//            else { return }
//
//        DatabasePath.userRef.child(uid).observeSingleEvent(of: .value) { [unowned self] (datashot) in
//            do {
//                let user = try User(datashot)
//
//                self.keychain.set("\(user.minAge)", forKey: "minAge")
//                self.keychain.set("\(user.maxAge)", forKey: "maxAge")
//                self.keychain.set("\(user.preference)", forKey: "preference")
//
//                self.delegate?.userProvider(self, didFetch: user)
//                } catch {
//
//            }
//        }
    }

    func loadSwipeImage() {

        guard let uid = keychain.get("uid")
            else { return }

        DatabasePath.userRef.child(uid).observeSingleEvent(of: .value) { [unowned self] (datashot) in
            do {

                    let userDic = [ datashot.key: datashot.value]

                    let user = try User(userDic)

                    self.keychain.set("\(user.minAge)", forKey: "minAge")
                    self.keychain.set("\(user.maxAge)", forKey: "maxAge")
                    self.keychain.set("\(user.preference.rawValue)", forKey: "preference")

                    self.delegate?.userProvider(self, didFetch: user)

                guard let minAge = Int(self.keychain.get("minAge")!),
                    let maxAge = Int(self.keychain.get("maxAge")!),
                    let preference = self.keychain.get("preference")
                    else { return }

                DatabasePath.userRef.queryOrdered(byChild: "gender").queryEqual(toValue: preference).observe(.value) { (dataSnapshot) in
                    do {

                        guard let datas = dataSnapshot.value as? [String: Any]

                            else { return }

                        for data in datas {

                            let userDic = [data.key: data.value]

                            let user = try User(userDic)

                            if user.email != Auth.auth().currentUser?.email && user.age >= minAge && user.age <= maxAge {
                                self.users.append(user)
                                self.delegate?.userProvider(self, didFetch: self.users)
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
