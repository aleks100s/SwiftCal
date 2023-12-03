//
//  Persistence.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftData
import Foundation

enum Persistence {
	static let container: ModelContainer = {
		let config = ModelConfiguration(url: sharedStoreURL)
		return try! ModelContainer(for: Day.self, configurations: config)
	}()
	
	static let previewContainer: ModelContainer = {
		let sharedStoreURL = URL(fileURLWithPath: "/dev/null")
		let config = ModelConfiguration(url: sharedStoreURL)
		return try! ModelContainer(for: Day.self, configurations: config)
	}()

	private static var sharedStoreURL: URL {
		let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.alextos.SwiftCal")!
		return container.appendingPathComponent("SwiftCal.sqlite")
	}
	
	static func generatePreivewDays() -> [Day] {
		let context = ModelContext(previewContainer)
		var days = [Day]()
		let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start
		for dayOffset in -4 ..< 30 {
			let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate) ?? .now
			let newItem = Day(date: date, didStudy: Bool.random())
			days.append(newItem)
			context.insert(newItem)
		}
		return days
	}
}


