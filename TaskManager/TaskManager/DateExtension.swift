//
//  DateExtension.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI

extension Date {
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // Checking whether date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    // Fetch week based kn Given date
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calender = Calendar.current
        let startDate = calender.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekdate = calender.dateInterval(of: .weekOfMonth, for: startDate)
        guard (weekdate?.start) != nil else {
            return []
        }
        
        // Iterating to get the Full week
        (0...6).forEach { index in
            if let weekDay = calender.date(byAdding: .day, value: index, to: startDate) {
                week.append(.init(date: weekDay))
            }
        }
        return week
    }
    // Creating next week based on the last current week date
    func createNextWeek() -> [WeekDay] {
        
        let calender = Calendar.current
        let startofLastDate = calender.startOfDay(for: self)
        guard let nextDate = calender.date(byAdding: .day, value: 1, to: startofLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    // Creating previous week based on the first current week date
    func createPreviousWeek() -> [WeekDay] {
        
        let calender = Calendar.current
        let startofLastDate = calender.startOfDay(for: self)
        guard let nextDate = calender.date(byAdding: .day, value: -1, to: startofLastDate) else {
            return []
        }
        return fetchWeek(nextDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
    static func updateHour(_ value: Int) -> Date {
        let calender = Calendar.current
        return calender.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}

