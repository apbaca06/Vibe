//
//  SettingTableViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

// MARK: Component

enum SettingComponent {

    // MARK: Case

    case search, show, nottification, logout

    // MARK: Property

    var localizedString: String {

        switch self {

        case .search:

            return NSLocalizedString("Search", comment: "")

        case .show:

            return NSLocalizedString("Show on app", comment: "")

        case .nottification:

            return NSLocalizedString("Notification", comment: "")

        case .logout:

            return NSLocalizedString("Logout", comment: "")

        }

    }

}

class SettingTableViewController: UITableViewController {

    typealias Component = SettingComponent

    let components: [Component]

    // MARK: Init

    init() {
        self.components = [ .search, .show, .nottification, .logout]

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifc Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()

    }

    // MARK: Set Up

    private func setUpTableView() {

        // Todo: better way to register cells
        let nib = UINib(
            nibName: "SearchTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib,
            forCellReuseIdentifier: "SearchTableViewCell"
        )

        let nib2 = UINib(
            nibName: "ShowTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib2,
            forCellReuseIdentifier: "ShowTableViewCell"
        )

        let nib3 = UINib(
            nibName: "NotificationTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib3,
            forCellReuseIdentifier: "NotificationTableViewCell"
        )

        let nib4 = UINib(
            nibName: "LogoutTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib4,
            forCellReuseIdentifier: "LogoutTableViewCell"
        )

        tableView.estimatedRowHeight = 44.0

        tableView.rowHeight = UITableViewAutomaticDimension
    }

}
