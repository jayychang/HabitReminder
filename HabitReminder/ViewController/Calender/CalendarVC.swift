//
//  CalendarVC.swift
//  HabitReminder
//
//  Created by jay★ on 2016-10-07.
//  Copyright © 2016 jay★. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC: UIViewController {

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = DateFormatter()
    var testCalendar: Calendar! = Calendar(identifier: .gregorian)
    var numberOfRows = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "yyyy MM dd"
        testCalendar.timeZone = TimeZone(abbreviation: "GMT")!

        calendarView.delegate = self
        calendarView.dataSource = self
        
        self.calendarView.registerCellViewXib(fileName: "CalendarCell")

        // Do any additional setup after loading the view.
        
        calendarView.direction = .horizontal                                 // default is horizontal
        calendarView.cellInset = CGPoint(x: 0, y: 0)                         // default is (3,3)
        calendarView.allowsMultipleSelection = false                         // default is false
        calendarView.firstDayOfWeek = .sunday                                // default is Sunday
        calendarView.scrollEnabled = true                                    // default is true
        calendarView.scrollingMode = .stopAtEachCalendarFrameWidth           // default is .StopAtEachCalendarFrameWidth
        calendarView.itemSize = nil                                          // default is nil. Use a value here to change the size of your cells
        calendarView.rangeSelectionWillBeUsed = false                        // default is false

        calendarView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CalendarVC : JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> (startDate: Date, endDate: Date, numberOfRows: Int, calendar: Calendar) {
        
        let firstDate = formatter.date(from: "2016 01 01")
        let secondDate = Date()
        let aCalendar = Calendar.current
        return (startDate: firstDate!, endDate: secondDate, numberOfRows: numberOfRows, calendar: aCalendar)
    }
    
    func calendar(_ calendar : JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date:Date, cellState: CellState) {
        (cell as? CalendarCell)?.setupCellBeforeDisplay(cellState, date: date)
    }
}
