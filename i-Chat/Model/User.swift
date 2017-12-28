//
//  User.swift
//  i-Chat
//
//  Created by cindy on 2017/12/15.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import MapKit

public enum JSONError: Error {

    case notObject

    case missingValueForKey(String)

    case invalidValueForKey(String)

}

struct User {

    // MARK: Schema

    public struct Schema {

        public static let id = "id"

        public static let age = "age"

        public static let agePreference = "agePreference"

        public static let minAge = "min"

        public static let maxAge = "max"

        public static let email = "email"

        public static let gender = "gender"

        public static let location = "location"

        public static let latitude = "latitude"

        public static let longitude = "longitude"

        public static let maxDistance = "maxDistance"

        public static let name = "name"

        public static let preference = "preference"

        public static let profileImgURL = "profileImgURL"

        public static let qbID = "qbID"

    }

    enum Gender: String {

        case female

        case male
    }

    // MARK: Property

    let id: String

    let age: Int

    let minAge: Int

    let maxAge: Int

    let email: String

    let gender: Gender

    let latitude: Double

    let longitude: Double

    let maxDistance: Int

    let name: String

    let preference: Gender

    var profileImgURL: String

    let qbID: NSNumber

    var infoDictionary: [String: Any] {

        let id = String(describing: self.id)

        let qbID = String(describing: self.qbID)

        let userInfo: [String: Any] = [ Schema.id: id,
                                           Schema.name: self.name,
                                           Schema.gender: self.gender.rawValue,
                                           Schema.profileImgURL: self.profileImgURL,
                                           Schema.email: self.email,
                                           Schema.qbID: qbID ]
        return userInfo
    }

    // MARK: Init

    init(_ json: Any) throws {

        guard
            let objects = json as? [String: Any]
            else {

                let error: JSONError = .notObject

                throw error

        }

        guard
            let id = objects.keys.first as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.id)

                throw error

        }

        self.id = id

        guard
        let object = objects.values.first as? [String: Any]
            else {

                let error: JSONError = .missingValueForKey(Schema.id)

                throw error

        }

        guard
            let age = object["age"] as? Int
            else {

                let error: JSONError = .missingValueForKey(Schema.age)

                throw error

        }

        self.age = age

        guard
            let agePreference = object[Schema.agePreference] as? [String: Any],
            let minAge = agePreference[Schema.minAge] as? Int,
            let maxAge = agePreference[Schema.maxAge] as? Int

            else {

                let error: JSONError = .missingValueForKey(Schema.agePreference)

                throw error

        }

        self.minAge = minAge

        self.maxAge = maxAge

        guard
            let email = object[Schema.email] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.email)

                throw error

        }

        self.email = email

        guard
            let gender = object[Schema.gender] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.gender)

                throw error

        }

        let genderLowercase = gender.lowercased()

        guard let genderLower = Gender(rawValue: genderLowercase)
            else {
                let error: JSONError = .missingValueForKey(Schema.gender)

                throw error

        }
        self.gender = genderLower

        guard
            let location = object[Schema.location] as? [String: Any],
            let latitude = location[Schema.latitude] as? Double,
            let longitude = location[Schema.longitude] as? Double
            else {

                let error: JSONError = .missingValueForKey(Schema.location)

                throw error

        }

        self.latitude = latitude
        self.longitude = longitude

        guard
            let maxDistance = object[Schema.maxDistance] as? Int
            else {

                let error: JSONError = .missingValueForKey(Schema.maxDistance)

                throw error

        }

        self.maxDistance = maxDistance

        guard
            let name = object[Schema.name] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.name)

                throw error

        }

        self.name = name

        guard
            let preference = object[Schema.preference] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.preference)

                throw error

        }

        let preferenceLowercase = gender.lowercased()

        guard let preferenceLower = Gender(rawValue: preferenceLowercase)
            else {
                let error: JSONError = .missingValueForKey(Schema.preference)

                throw error

        }

        self.preference = preferenceLower

        guard
            let profileImgURL = object[Schema.profileImgURL] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.profileImgURL)

                throw error

        }

        self.profileImgURL = profileImgURL

        guard
            let qbID = object[Schema.qbID] as? NSNumber
            else {

                let error: JSONError = .missingValueForKey(Schema.qbID)

                throw error

        }

        self.qbID = qbID
    }

}
