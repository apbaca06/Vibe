//
//  GenderPickerController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import XLActionController

protocol GenderPickerControllerDelegate: class {

    func controller(_ controller: GenderPickerController, didSelect gender: String)
}

class GenderPickerController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {

    static let shared = GenderPickerController()

    weak var genderDelegate: GenderPickerControllerDelegate?

    let gender = [
        "Male", "Female"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        // 設置為陣列 meals 的第 row 項資料
        return gender[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {

        self.genderDelegate?.controller(GenderPickerController.shared, didSelect: gender[row])
    }

}
