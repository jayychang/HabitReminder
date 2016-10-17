//
//  CalendarVC.swift
//  HabitReminder
//
//  Created by jay★ on 2016-10-07.
//  Copyright © 2016 jay★. All rights reserved.
//

import UIKit
import JTAppleCalendar
import RealmSwift

class CalendarVC: UIViewController {

    let formatter = DateFormatter()
    var testCalendar: Calendar! = Calendar(identifier: .gregorian)
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    @IBAction func completed(_ sender: AnyObject) {
        let realm = try! Realm()
        
        try! realm.write {
            let day = Day()
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy MM dd"
            let convertedDate: String = formatter.string(from: Date())
            
            day.date = convertedDate
            day.completed = true
            print("\(day)")
            realm.add(day)
        }
    }
    


    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)

        formatter.dateFormat = "yyyy MM dd"
        testCalendar.timeZone = TimeZone(abbreviation: "GMT")!
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.registerCellViewXib(file: "CalendarCell")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: false, animateScroll: false) {
            let currentDate = self.calendarView.dateSegment()
            self.setupViewsOfCalendar(
                currentDate.range.start,
                endDate: currentDate.range.end,
                month: currentDate.month
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewsOfCalendar(_ startDate: Date, endDate: Date, month: Int) {
        let Month = testCalendar.component(.month, from: startDate)
        let monthName = DateFormatter().monthSymbols[(Month-1) % 12]
        // 0 indexed array
        let year = Calendar.current.component(.year, from: startDate)
//        monthLabel.text = monthName + " " + String(year)
        
                monthLabel.text = monthName
                yearLabel.text = String(year)
    }

}

extension CalendarVC : JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) ->
        ConfigurationParameters {

//            let startDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
//            let startString = formatter.string(from: start)
//            let startDate = formatter.date(from: startString)!

//            let endDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
//            let endString = formatter.string(from: end)
//            let endDate = formatter.date(from: endString)!
//            formatter.dateFormat = "yyyy MM dd"
//            let convertedDate: String = dateFormatter.string(from: Date())
            
//            print("DATEEEEEEEE \(startDate)")
            let startDate = formatter.date(from: "2000 01 01")!
            let endDate = formatter.date(from: "2030 09 20")!
//            formatter.date(from: startDate as NSString)
            let calendar = Calendar.current
            
            let parameters = ConfigurationParameters(
                startDate: startDate,
                endDate: endDate,
                numberOfRows: 6,
                calendar: calendar,
                generateInDates: .forAllMonths,
                generateOutDates: .tillEndOfRow,
                firstDayOfWeek: .sunday
            )
            return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView,
                  willDisplayCell cell: JTAppleDayCellView,
                  date: Date, cellState: CellState) {
        (cell as? CalendarCell)?.setupCellBeforeDisplay(cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView,
                  didScrollToDateSegmentFor range: (start: Date, end: Date),
                  belongingTo month: Int, rows: Int) {
        setupViewsOfCalendar(range.start, endDate: range.end, month: month)
    }
    
}
