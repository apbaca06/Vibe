//
//  AgeRangePickerViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import KeychainSwift

protocol AgeRangePickerControllerDelegate: class {

    func controller(_ controller: AgeRangePickerController, minAge: Int)

    func controller(_ controller: AgeRangePickerController, maxAge: Int)
}

class AgeRangePickerController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {

    static let shared = AgeRangePickerController()

    weak var ageDelegate: AgeRangePickerControllerDelegate?

    let minAgeArray = Array(18...55)

    let maxAgeArray = Array(22...55)

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView.tag == 1 {

            return minAgeArray.count
        }
        if pickerView.tag == 2 {
            return maxAgeArray.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {

        if pickerView.tag == 1 {

            return String(describing: minAgeArray[row])
        }
        if pickerView.tag == 2 {
            return String(describing: maxAgeArray[row])
        }

        return nil
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {

        let keychain = KeychainSwift()

       guard let uid = keychain.get("uid")
        else { return }

        if pickerView.tag == 1 {

            self.ageDelegate?.controller(AgeRangePickerController.shared, minAge: minAgeArray[row])

            DatabasePath.userRef.child(uid).child("agePreference").updateChildValues(["min": minAgeArray[row]])

        }

        if pickerView.tag == 2 {

           self.ageDelegate?.controller(AgeRangePickerController.shared, maxAge: maxAgeArray[row])
            DatabasePath.userRef.child(uid).child("agePreference").updateChildValues(["max": maxAgeArray[row]])

        }

    }
}
