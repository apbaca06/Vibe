//
//  Chat.swift
//  i-Chat
//
//  Created by cindy on 2017/12/12.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

class Chat: NSObject, QBChatDelegate {
    static let shared = Chat()

    func config() {
        QBChat.instance.addDelegate(self)
    }

    func chatDidConnect() {
        print("===ChatDidConnect ===")
    }

    func chatDidReconnect() {
        print("===ChatDidReConnect ===")
    }

    func chatDidReceive(_ message: QBChatMessage) {
        print("===ChatDidReceive ===")
//        NotificationCenter.default.post(name: .chatDidRecieve, object: message)
    }

    func chatDidReceiveSystemMessage(_ message: QBChatMessage) {
        print("===ChatDidReceiveSystemMessage ===")
//        NotificationCenter.default.post(name: .chatDidRecieveSystemMessage, object: message)
    }
}

extension NSNotification.Name {

    static let chatDidReceive = Notification.Name(rawValue: "chatDidReceive")

    static let chatDidReceiveSystemMessage = Notification.Name(rawValue: "chatDidReceiveSystemMessage")
}
