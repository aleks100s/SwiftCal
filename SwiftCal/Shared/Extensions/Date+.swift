//
//  Date+.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import Foundation

extension Date {

	var startOfMonth: Date {
		Calendar.current.dateInterval(of: .month, for: self)!.start
	}

	var endOfMonth: Date {
		Calendar.current.dateInterval(of: .month, for: self)!.end
	}

	var endOfDay: Date {
		Calendar.current.dateInterval(of: .day, for: self)!.end
	}

	var startOfPreviousMonth: Date {
		let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
		return dayInPreviousMonth.startOfMonth
	}

	var startOfNextMonth: Date {
		let dayInNextMonth = Calendar.current.date(byAdding: .month, value: 1, to: self)!
		return dayInNextMonth.startOfMonth
	}

	var numberOfDaysInMonth: Int {
		// endOfMonth returns the 1st of next month at midnight.
		// An adjustment of -1 is necessary to get last day of current month
		let endDateAdjustment = Calendar.current.date(byAdding: .day, value: -1, to: self.endOfMonth)!
		return Calendar.current.component(.day, from: endDateAdjustment)
	}

	var dayInt: Int {
		Calendar.current.component(.day, from: self)
	}

	var monthInt: Int {
		Calendar.current.component(.month, from: self)
	}

	var monthFullName: String {
		self.formatted(.dateTime.month(.wide))
	}
	
	var startOfMonthWithCalendarPrefix: Date {
		let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
		let offset = if startOfMonthWeekday == 1 { 6 } else { startOfMonthWeekday - 2 }
		let startDate = Calendar.current.date(byAdding: .day, value: -offset, to: startOfMonth)
		return startDate ?? Date()
	}
	
	var isInCurrentMonth: Bool {
		monthInt == Date().monthInt
	}
}