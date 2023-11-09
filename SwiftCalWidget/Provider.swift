//
//  Provider.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexander on 03.11.2023.
//

import WidgetKit
import SwiftData

struct Provider: TimelineProvider {	
	func placeholder(in context: Context) -> Entry {
		Entry(date: Date(), days: [])
	}

	@MainActor
	func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
		let days = fetchDays()
		let entry = Entry(date: Date(), days: days)
		completion(entry)
	}

	@MainActor
	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		let days = fetchDays()
		let entry = Entry(date: Date(), days: days)
		let timeline = Timeline(entries: [entry], policy: .after(.now.endOfDay))
		completion(timeline)
	}
	
	@MainActor
	private func fetchDays() -> [Day] {
		do {
			let startDate = Date.now.startOfMonthWithCalendarPrefix
			let endDate = Date.now.endOfMonth
			let predicate = #Predicate<Day> { $0.date > startDate && $0.date < endDate }
			let descriptor = FetchDescriptor<Day>(predicate: predicate, sortBy: [.init(\.date)])
			let days = try Persistence.container.mainContext.fetch(descriptor)
			return days
		} catch {
			return []
		}
	}
}
