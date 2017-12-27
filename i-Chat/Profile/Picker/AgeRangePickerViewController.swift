//
//  AgeRangePickerViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
protocol AgeRangePickerControllerDelegate: class {

    func controller(_ controller: AgeRangePickerController, minAge: Int)
}

class AgeRangePickerController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {

    static let shared = AgeRangePickerController()

    weak var ageDelegate: AgeRangePickerControllerDelegate?

    let ageArray = Array(18...55)

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return ageArray.count
    }

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {

        return String(describing: ageArray[row])
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()

        view.backgroundColor = .black
        return view
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {

        self.ageDelegate?.controller(AgeRangePickerController.shared, minAge: ageArray[row])

    }

}
