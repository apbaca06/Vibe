//
//  UserProvider.swift
//  i-Chat
//
//  Created by cindy on 2017/12/29.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import Nuke

protocol UserProviderDelegate: class {

    func userProvider(_ provider: UserProvider, didFetch users: [User])

}

class UserProvider {

    var users: [User] = []

    weak var delegate: UserProviderDelegate?

    func loadSwipeImage() {
        DatabasePath.userRef.observe(.value) { (dataSnapshot) in
            do {

                guard let datas = dataSnapshot.value as? [String: Any]

                    else { return }

                for data in datas {

                    let userDic = [data.key: data.value]

                    let user = try User(userDic)

                    self.users.append(user)
                    self.delegate?.userProvider(self, didFetch: self.users)
                }

            } catch {
                print(error, "**")
            }
        }
    }
}
