//
//  AppIntents.swift
//  SwiftCal
//
//  Created by Alexander on 03.12.2023.
//

import AppIntents
import SwiftData

struct ToggleStudyIntent: AppIntent {
	static var title: LocalizedStringResource = "Toggle Studied"
	
	@Parameter(title: "Date")
	var date: Date
	
	init(date: Date) {
		self.date = date
	}
	
	init() {}
	
	func perform() async throws -> some IntentResult {
		let context = ModelContext(Persistence.container)
		let predicate = #Predicate<Day> { $0.date == date }
		let descriptor = FetchDescriptor(predicate: predicate)
		guard let day = try context.fetch(descriptor).first else { return .result() }
		
		day.didStudy.toggle()
		try context.save()
		return .result()
	}
}
