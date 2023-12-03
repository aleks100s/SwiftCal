//
//  Entry.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexander on 03.11.2023.
//

import WidgetKit

struct Entry: TimelineEntry {
	let date: Date
	let days: [Day]
	let currentCalendarDays: Int
	let daysStudied: Int
	let today: Day
	
	init(date: Date, days: [Day]) {
		self.date = date
		self.days = days
		currentCalendarDays = days.filter { $0.date.isInCurrentMonth }
			.count
		daysStudied = days.filter { $0.date.isInCurrentMonth }
			.filter { $0.didStudy }
			.count
		today = days.first(where: { day in
			Calendar.current.isDateInToday(day.date)
		}) ?? Day(date: Date(), didStudy: false)
	}
}
