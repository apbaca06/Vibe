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

    case search, show, notification, logout

    // MARK: Property

    var localizedString: String {

        switch self {

        case .search:

            return NSLocalizedString("Search", comment: "")

        case .show:

            return NSLocalizedString("Show on app", comment: "")

        case .notification:

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
        self.components = [ .search, .show, .notification, .logout]

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifc Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()

        setupNavBar()
    }

    func setupNavBar() {

        self.navigationItem.title = NSLocalizedString("Setting", comment: "")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(backToProfileCell)
        )

        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    @objc func backToProfileCell() {
        self.dismiss(animated: true, completion: nil)
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


    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {

        return components.count

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let component = components[section]
        
        switch component {
            
        case .show, .logout, .notification, .search:
            return component.localizedString
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let component = components[section]

        switch component {

        case .show, .logout, .notification, .search:

            return 1

        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let component = components[indexPath.section]

        switch component {

        case .logout:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LogoutTableViewCell",
                for: indexPath
                ) as! LogoutTableViewCell
            // swiftlint:enable force_cast

            return cell

        case .notification:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "NotificationTableViewCell",
                for: indexPath
                ) as! NotificationTableViewCell
            // swiftlint:enable force_cast

            return cell

        case .show:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "ShowTableViewCell",
                for: indexPath
                ) as! ShowTableViewCell
            // swiftlint:enable force_cast

            return cell
        case .search:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SearchTableViewCell",
                for: indexPath
                ) as! SearchTableViewCell
            // swiftlint:enable force_cast

            return cell
        }
    }

}
