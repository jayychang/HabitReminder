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
        
        configureBackgroundAlpha(cellState)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let cellDate: String = formatter.string(from: date)

        print("cell date \(cellDate)")
        
        let realm = try! Realm()
        
        let day = realm.objects(Day.self).filter("date == '\(cellDate)'")
        
        print("\(day.count)")
        
        if day.count > 0 {
            configureCompletion(completion: (day.first?.completed)!)
        } else {
            dayLabel.font = UIFont(name: "Helvetica-Light", size: 20)
            dayLabel.textColor = UIColor.black
            dayLabel.text =  cellState.text
        }
    }

    func configureCompletion ( completion: Bool) {
        dayLabel.font = UIFont(name: "Zapf Dingbats", size: 40)
        if completion == true {
            dayLabel.textColor = UIColor.green
            dayLabel.text = "✔"
        } else {
            dayLabel.textColor = UIColor.red
            dayLabel.text = "✘"
        }
    }
    
    func configureBackgroundAlpha(_ cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            background.alpha = 1
        } else {
            background.alpha = 0.15
        }
    }
}
