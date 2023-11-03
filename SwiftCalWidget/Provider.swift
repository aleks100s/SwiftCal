//
//  Provider.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexander on 03.11.2023.
//

import WidgetKit

struct Provider: TimelineProvider {
	private let viewContext = PersistenceController.shared.container.viewContext
	
	func placeholder(in context: Context) -> Entry {
		Entry(date: Date(), days: [])
	}

	func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
		let days = fetchDays()
		let entry = Entry(date: Date(), days: days)
		completion(entry)
	}

	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		let days = fetchDays()
		let entry = Entry(date: Date(), days: days)
		let timeline = Timeline(entries: [entry], policy: .after(.now.endOfDay))
		completion(timeline)
	}
	
	private func fetchDays() -> [Day] {
		let request = Day.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(keyPath: \Day.date, ascending: true)]
		request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", Date().startOfMonthWithCalendarPrefix as CVarArg, Date().endOfMonth as CVarArg)
		do {
			let days = try viewContext.fetch(request)
			return days
		} catch {
			return []
		}
	}
}
