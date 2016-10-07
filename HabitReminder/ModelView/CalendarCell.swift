//
//  CalendarCell.swift
//  HabitReminder
//
//  Created by jay★ on 2016-10-07.
//  Copyright © 2016 jay★. All rights reserved.
//

import JTAppleCalendar

class CalendarCell: JTAppleDayCellView {

    @IBOutlet weak var dayLabel: UILabel!

    var normalDayColor = UIColor.black
    var weekendDayColor = UIColor.gray
    
    
    func setupCellBeforeDisplay(_ cellState: CellState, date: Date) {
        
        dayLabel.text =  cellState.text
        configureTextColor(cellState)
    }

    
    func configureTextColor(_ cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            dayLabel.textColor = normalDayColor
        } else {
            dayLabel.textColor = weekendDayColor
        }
    }
}
