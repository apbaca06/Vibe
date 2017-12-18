//
//  User.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

struct User {

    // MARK: Schema

    public struct Schema {

        public static let id = "id"

        public static let name = "name"

        public static let gender = "gender"

        public static let imgURL = "imgURL"

        public static let email = "e-mail"

        public static let quickbloxID = "quickbloxID"

    }

    enum Gender: String {

        case female

        case male
    }

    // MARK: Property

    let id: UInt

    let name: String

    let gender: Gender

    var imgURL: String

    let email: String

    let quickbloxID: NSNumber

    var infoDictionary: [String: String] {

        let id = String(describing: self.id)

        let quickbloxID = String(describing: self.quickbloxID)

        let userInfo: [String: String] = [ Schema.id: id,
                                           Schema.name: self.name,
                                           Schema.gender: self.gender.rawValue,
                                           Schema.imgURL: self.imgURL,
                                           Schema.email: self.email,
                                           Schema.quickbloxID: quickbloxID ]
        return userInfo
    }

}
