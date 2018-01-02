//
//  FriendViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/30.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        func friendList(friends: [User]) {
//            print("friends**", friends)
//            for friend in friends {
//                guard let url = URL(string: friend.profileImgURL)
//                    else { return }
//                //            Manager.shared.loadImage(with: url, into: friendImage)
//            }
//            
//        }
//        
//        @IBAction func callAction(_ sender: UIButton) {
//            DatabasePath.userRef.child("c3ywbmhKGXPBK9ih3FkLHF29pPX2").observe(.value) { (datasnapshot) in
//                do {
//                    let user = try User(datasnapshot)
//                    
//                    CallManager.shared.audioCall(toUser: user)
//                } catch {
//                    
//                }
//            }
//            //        User(id: 1234, name: "cindy", gender: .female, imgURL: "ee", email: "cindy@gmail.com", qbID: 39258896)
//            print("****,\(CallManager.shared.session)")
//            
//        }

        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self

        tableView.dataSource = self

        tableView.estimatedRowHeight = 100.0

        tableView.rowHeight = UITableViewAutomaticDimension

        let nib = UINib(
            nibName: "FriendTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib,
            forCellReuseIdentifier: "FriendTableViewCell"
        )

        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)

        view.addSubview(tableView)

        let tableViewTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)

        let tableViewLeading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let tableViewHeight = NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)

        let tableViewWidth = NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addConstraints([tableViewTop, tableViewLeading, tableViewHeight, tableViewWidth])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FriendTableViewCell",
            for: indexPath
            ) as! FriendTableViewCell

        // swiftlint:enable force_cast

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
