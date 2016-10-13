//
//  CalendarCell.swift
//  HabitReminder
//
//  Created by jay★ on 2016-10-07.
//  Copyright © 2016 jay★. All rights reserved.
//

import JTAppleCalendar
import RealmSwift

class CalendarCell: JTAppleDayCellView {

    @IBOutlet weak var dayLabel: UILabel!

    var normalDayColor = UIColor.black
    var weekendDayColor = UIColor.gray
    
    
    func setupCellBeforeDisplay(_ cellState: CellState, date: Date) {
        
        dayLabel.text =  cellState.text
        configureTextColor(cellState)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let convertedDate: String = dateFormatter.string(from: date)

        print("cell date \(convertedDate)")
        
        let realm = try! Realm()
        
        let tanDogs = realm.objects(Day.self).filter("date == '\(convertedDate)'")
        
        print("\(tanDogs.count)")

    }

    
    func configureTextColor(_ cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.textColor = weekendDayColor
        }
    }
}
