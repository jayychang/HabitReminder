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
    @IBOutlet weak var background: UIView!

    var normalDayColor = UIColor.black
    var weekendDayColor = UIColor.gray
    
    
    func setupCellBeforeDisplay(_ cellState: CellState, date: Date) {
        
//        background.layer.masksToBounds = true
//        background.layer.cornerRadius = background.frame.width / 2
        
        configureTextColor(cellState)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let convertedDate: String = formatter.string(from: date)

        print("cell date \(convertedDate)")
        
        let realm = try! Realm()
        
        let day = realm.objects(Day.self).filter("date == '\(convertedDate)'")
        
        print("\(day.count)")
        
        if day.count > 0 {
            configureCompletion(completion: (day.first?.completed)!)
        } else {
            dayLabel.textColor = UIColor.black
            dayLabel.text =  cellState.text
        }
    }

    func configureCompletion ( completion: Bool) {
        if completion == true {
            dayLabel.textColor = UIColor.green
            dayLabel.text = "\u{2714}"
        } else {
            dayLabel.textColor = UIColor.red
            dayLabel.text = "✘"
        }
    }
    
    func configureTextColor(_ cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            background.alpha = 1
//            dayLabel.textColor = normalDayColor
        } else {
//            dayLabel.textColor = weekendDayColor
            background.alpha = 0.2
        }
    }
}
