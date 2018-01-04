//
//  FriendTableViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/30.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import UIKit

class FriendTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    func setupTableView() {
        tableView.delegate = self

        tableView.dataSource = self

        tableView.estimatedRowHeight = 100.0

        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 15)

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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        headerView.backgroundColor = .white

        let labelView: UILabel = UILabel(frame: CGRect(x: 15, y: 0, width: UIScreen.main.bounds.width - 15, height: 40))
        labelView.text = NSLocalizedString("History", comment: "")
        labelView.font = UIFont.boldSystemFont(ofSize: 17)
        labelView.textColor = UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)
        headerView.addSubview(labelView)

        return headerView
    }

}
