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
	
	var currentCalendarDays: Int {
		days.filter { $0.date.isInCurrentMonth }
			.count
	}
	
	var daysStudied: Int {
		days.filter { $0.date.isInCurrentMonth }
			.filter { $0.didStudy }
			.count
	}
}
