//
//  SettingTableViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/20.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// MARK: Component

enum SettingComponent {

    // MARK: Case

    case search, show, slider, logout

    // MARK: Property

    var localizedString: String {

        switch self {

        case .search:

            return NSLocalizedString("Search", comment: "")

        case .show:

            return NSLocalizedString("Show on app", comment: "")

        case .slider:

            return NSLocalizedString("Notification", comment: "")

        case .logout:

            return NSLocalizedString("Logout", comment: "")

        }
    }
}

enum SearchComponent {

    // MARK: Case

    case location, maxDistance, gender, ageRange

    // MARK: Property

    static let count = 4

    var localizedString: String {

        switch self {

        case .location:

            return NSLocalizedString("Location", comment: "")

        case .maxDistance:

            return NSLocalizedString("Max Distance", comment: "")

        case .gender:

            return NSLocalizedString("Gender", comment: "")

        case .ageRange:

            return NSLocalizedString("Age Range", comment: "")

        }

    }
}

class SettingTableViewController: UITableViewController, GenderPickerControllerDelegate, AgeRangePickerControllerDelegate {

    func controller(_ controller: AgeRangePickerController, minAge: Int) {
        self.minAge = String(describing: minAge)
        tableView.reloadData()

    }

    func controller(_ controller: AgeRangePickerController, maxAge: Int) {
        self.maxAge = String(describing: maxAge)
        tableView.reloadData()

    }

    func controller(_ controller: GenderPickerController, didSelect gender: String) {

        self.gender = gender

        tableView.reloadData()
    }

    typealias Component = SettingComponent

    let components: [Component]

    var cityName: String?

    var gender: String?

    var minAge: String?

    var maxAge: String?

    // MARK: Init

    init() {
        self.components = [ .search, .show, .slider, .logout]

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifc Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        GenderPickerController.shared.genderDelegate = self
        AgeRangePickerController.shared.ageDelegate = self

        print(GenderPickerController.shared)

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
            nibName: "SwitchTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib,
            forCellReuseIdentifier: "SwitchTableViewCell"
        )

        let nib2 = UINib(
            nibName: "LabelTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib2,
            forCellReuseIdentifier: "LabelTableViewCell"
        )

        let nib3 = UINib(
            nibName: "GenderPickerTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib3,
            forCellReuseIdentifier: "GenderPickerTableViewCell"
        )

        let nib4 = UINib(
            nibName: "LogoutTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib4,
            forCellReuseIdentifier: "LogoutTableViewCell"
        )

        let nib5 = UINib(
            nibName: "AgeRangeTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib5,
            forCellReuseIdentifier: "AgeRangeTableViewCell"
        )

        let nib6 = UINib(
            nibName: "SliderTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib6,
            forCellReuseIdentifier: "SliderTableViewCell"
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

        case .show, .logout, .slider, .search:
            return component.localizedString

        }

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let component = components[section]

        switch component {

        case .search:
            return 4

        case .show, .logout, .slider :

            return 1

        }

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast

        let component = components[indexPath.section]

        switch component {

        case .search:

            switch indexPath.row {

            case 0:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "LabelTableViewCell",
                    for: indexPath
                    ) as! LabelTableViewCell

                cell.leftLabel.text = NSLocalizedString("Location", comment: "")

                cell.rightLabel.text = self.cityName

                return cell

            case 1:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SliderTableViewCell",
                    for: indexPath
                    ) as! SliderTableViewCell

                cell.leftLabel.text = NSLocalizedString("Max Distance", comment: "")

                return cell

            case 2:

                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "GenderPickerTableViewCell",
                    for: indexPath
                    ) as! GenderPickerTableViewCell

                cell.leftLabel.text = NSLocalizedString("Gender Preference", comment: "")

                let genderPickerViewController = GenderPickerController.shared

                self.addChildViewController(genderPickerViewController)

                cell.pickerView.delegate = genderPickerViewController

                cell.pickerView.dataSource = genderPickerViewController

                if self.gender != nil {
                    cell.textfield.text = gender
                }

                return cell

            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "AgeRangeTableViewCell",
                    for: indexPath
                    ) as! AgeRangeTableViewCell

                cell.leftLabel.text = NSLocalizedString("Age Range", comment: "")

                let ageRangePickerViewController = AgeRangePickerController.shared

                self.addChildViewController(ageRangePickerViewController)

                cell.minAgePickerView.delegate = ageRangePickerViewController

                cell.minAgePickerView.dataSource = ageRangePickerViewController

                cell.maxAgePickerView.delegate = ageRangePickerViewController

                cell.maxAgePickerView.dataSource = ageRangePickerViewController

                if self.minAge != nil {
                    cell.minAgeTextField.text = self.minAge
                }
                if self.maxAge != nil {
                    cell.maxAgeTextField.text = self.maxAge
                }

                return cell

            default:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SwitchTableViewCell",
                    for: indexPath
                    ) as! SwitchTableViewCell
                // swiftlint:enable force_cast
                cell.cellLabel.text = NSLocalizedString("Gender", comment: "")
                return cell

            }

        case .logout:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LogoutTableViewCell",
                for: indexPath
                ) as! LogoutTableViewCell
            // swiftlint:enable force_cast

            return cell

        case .slider:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "GenderPickerTableViewCell",
                for: indexPath
                ) as! GenderPickerTableViewCell
            // swiftlint:enable force_cast

            return cell

        case .show:

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "LabelTableViewCell",
                for: indexPath
                ) as! LabelTableViewCell
            // swiftlint:enable force_cast

            cell.rightLabel.text = self.cityName

            return cell

        }
    }

}
