//
//  Message.swift
//  i-Chat
//
//  Created by cindy on 2018/1/5.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

struct Message {

    // MARK: Schema

    public struct Schema {

        public static let id = "id"

        public static let text = "text"

        public static let timestamp = "timestamp"

        public static let from = "from"

        public static let state = "state"

    }

    // MARK: Property

    let id: String

    let text: String

    let timestamp: String

    let from: String

    let state: Int

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
            let from = object[Schema.from] as? String
            else {

                let error: JSONError = .missingValueForKey(Schema.from)

                throw error

        }

        self.from = from

        guard
            let state = object[Schema.state] as? Int

            else {

                let error: JSONError = .missingValueForKey(Schema.state)

                throw error

        }

        self.state = state

        guard
            let timestamp = object[Schema.timestamp] as? String

            else {

                let error: JSONError = .missingValueForKey(Schema.timestamp)

                throw error

        }

        self.timestamp = timestamp

        guard
            let text = object[Schema.text] as? String

            else {

                let error: JSONError = .missingValueForKey(Schema.text)

                throw error

        }

        self.text = text

    }

}
