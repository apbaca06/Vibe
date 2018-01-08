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
import KeychainSwift

// MARK: Component

enum SettingComponent {

    // MARK: Case

    case search, logout

    //show, slider,

    // MARK: Property

    var localizedString: String {

        switch self {

        case .search:

            return NSLocalizedString("Search", comment: "")

//        case .show:
//
//            return NSLocalizedString("Show on app", comment: "")
//
//        case .slider:
//
//            return NSLocalizedString("Notification", comment: "")

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

protocol SettingTableViewControllerDelegate: class {
    func controller(_ controller: SettingTableViewController, didChanged minAge: Int)
//    func controller(_ controller: SettingTableViewController, didChanged maxAge: Int)
}

class SettingTableViewController: UITableViewController, GenderPickerControllerDelegate {

//        guard let uid = keychain.get("uid"),
//            let minAgeString = keychain.get("minAge"),
//            let minimumAge = Int(minAgeString),
//            let maxAgeString = keychain.get("maxAge"),
//            let maximumAge = Int(maxAgeString)
//            else { return }
//        if minAge > maximumAge {
//            let alertController = UIAlertController(title: NSLocalizedString("The minimum age should be smaller than maxiumum age", comment: ""), message: "Invalid setting.", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
//            alertController.addAction(okAction)
//            alertController.show()
//        } else {

//        }

    func controller(_ controller: GenderPickerController, didSelect gender: String) {

        self.gender = gender

        tableView.reloadData()
    }

    typealias Component = SettingComponent

    let components: [Component]

    weak var delegate: SettingTableViewControllerDelegate?

    var cityName: String?

    var gender: String?

    let ageArray = Array(18...55)

    let minAgePickerView = UIPickerView()

    let maxAgePickerView = UIPickerView()

    let keychain = KeychainSwift()

    // MARK: Init

    init() {
        self.components = [ .search, .logout]

        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifc Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        GenderPickerController.shared.genderDelegate = self

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

        case .search, .logout:
            return component.localizedString

        }

    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let component = components[section]

        switch component {

        case .search:
            return 4

//        case .show, .slider :
//
//            return 0
        case .logout :
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
                let keychain = KeychainSwift()
                guard let maxDistance = keychain.get("maxDistance"),
                      let distance = Float(maxDistance)
                    else {return cell}
                cell.slider.value = distance

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

                cell.minAgeTextField.inputView = minAgePickerView

                cell.maxAgeTextField.inputView = maxAgePickerView

                self.minAgePickerView.delegate = self

                self.minAgePickerView.dataSource = self

                self.maxAgePickerView.delegate = self

                self.maxAgePickerView.dataSource = self

                cell.minAgeTextField.text = self.keychain.get("minAge")

                cell.maxAgeTextField.text = self.keychain.get("maxAge")

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
    }

//        case .slider:
//
//
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: "GenderPickerTableViewCell",
//                for: indexPath
//                ) as! GenderPickerTableViewCell
//
//
//            return cell
//
//        case .show:
//
//
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: "LabelTableViewCell",
//                for: indexPath
//                ) as! LabelTableViewCell
//            
//
//            cell.rightLabel.text = self.cityName
//
//            return cell
//
//        }
    }

}

extension SettingTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == minAgePickerView {

            return ageArray.count
        }
        if pickerView == maxAgePickerView {
            return ageArray.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {

        if pickerView == minAgePickerView {

            return String(describing: ageArray[row])
        }
        if pickerView == maxAgePickerView {
            return String(describing: ageArray[row])
        }

        return nil
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {

        let keychain = KeychainSwift()

        guard let uid = keychain.get("uid"),
            let minAgeString = keychain.get("minAge"),
            let minimumAge = Int(minAgeString),
            let maxAgeString = keychain.get("maxAge"),
            let maximumAge = Int(maxAgeString)
            else { return }

        if pickerView == minAgePickerView {

            if ageArray[row] < maximumAge {
                let min = String(describing: ageArray[row])
                keychain.set(min, forKey: "minAge")
                tableView.reloadData()
            DatabasePath.userRef.child(uid).child("agePreference").updateChildValues(["min": ageArray[row]])
            } else {

                let alertController = UIAlertController(title: NSLocalizedString("The minimum age should be smaller than maxiumum age", comment: ""), message: "Invalid setting.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.show()
            }

        } else {

            if ageArray[row] > minimumAge {
                let min = String(describing: ageArray[row])
                keychain.set(min, forKey: "maxAge")
                tableView.reloadData()
                DatabasePath.userRef.child(uid).child("agePreference").updateChildValues(["max": ageArray[row]])
            } else {

                let alertController = UIAlertController(title: NSLocalizedString("The maximum age should be larger than miniumum age", comment: ""), message: "Invalid setting.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.show()
            }

        }

    }
}
