//
//  AgeViewController.swift
//  i-Chat
//
//  Created by cindy on 2017/12/26.
//  Copyright © 2017年 Jui-hsin.Chen. All rights reserved.
//

import Foundation

class AgeViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var ageLabel: UILabel!

    @IBOutlet weak var button: UIButton!

    @IBAction func pickDate(_ sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        dateLabel.text = "\(formatter.string(from: sender.date))"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date

        let formatter = DateFormatter()
        // 可以選擇的最早日期時間
        let fromDateTime = formatter.date(from: "1940-01-01")

        let tillDateTime = formatter.date(from: "2000-01-01")

        // 設置可以選擇的最早日期時間
        datePicker.minimumDate = fromDateTime
        datePicker.maximumDate = Date()

//        let now = Date()
//        let nowCalendar = Calendar.current
//        let nowComponents = nowCalendar.dateComponents([.day, .month, .year], from: now)
//
//        //Compare if date is lesser than now and then create a new date
//        if nowCalendar.compare(datePicker.date, to: now, toGranularity: [.day, .month, .year])
//        compareDate(datePicker.date, toDate: now, toUnitGranularity: [.Day, .Month, .Year]) == ComparisonResult.OrderedAscending {
//
//            let dateCalendar = Calendar.current
//            let dateComponents = dateCalendar.components([.Day, .Month, .Year], fromDate: datePicker.date)
//
//            dateComponents.year = nowComponents.year + 1
//            let newDate = dateCalendar.dateFromComponents(dateComponents)
//            datePicker.date = newDate!
//        }

    }

}
