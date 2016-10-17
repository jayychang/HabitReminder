//
//  dataModel.swift
//  HabitReminder
//
//  Created by jay★ on 2016-10-11.
//  Copyright © 2016 jay★. All rights reserved.
//

import RealmSwift

class Day: Object {
    dynamic var date = ""
    dynamic var completed = false
}
