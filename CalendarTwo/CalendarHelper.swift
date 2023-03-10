//
//  CalendarHelper.swift
//  CalendarTwo
//
//  Created by Samuel Fuentes Navarrete on 05/03/23.
//

import Foundation

extension Date {
    
    var calendar: Calendar { Calendar.current }
    
    var plusMonth: Date {
        calendar.date(byAdding: .month, value: 1, to: self)!
    }
    
    var minusMonth: Date {
        calendar.date(byAdding: .month, value: -1, to: self)!
    }
    
    
    
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    var yearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var dayNameString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: self)!.count
    }

//    Date {
//       let components = DateComponents(day:1)
//       let startOfNextMonth = calendar.nextDate(after:Date(), matching: components, matchingPolicy: .nextTime)!
//       return calendar.date(byAdding:.day, value: -1, to: startOfNextMonth)!
//    }
    
    
   
    
    var dayOfMonth: Int {
        calendar.dateComponents([.day], from: self).day!
    }
    
    var firstDayOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    var weekDay: Int {
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday! - 1
    }
    
   
    
    var lastDayInMonth: Date {
        let startOfNextMonth = calendar.nextDate(after:Date(), matching: DateComponents(day:1), matchingPolicy: .nextTime)!
        return calendar.date(byAdding:.day, value: -1, to: startOfNextMonth)!
    }
    
    
    var aditionalDaysOfNextMonth: Int {
        let additionalDays = 8 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else { return 0 }
        return additionalDays
    }

//    var aditionalDaysOfPreviusMonth: Date {
//        let date = calendar.date(byAdding: .day, value: -1, to: firstDayOfMonth)!
//        return date
//    }
}

extension String {
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d LLLL yyyy"
        return dateFormatter.date(from:self)!
    }
}
