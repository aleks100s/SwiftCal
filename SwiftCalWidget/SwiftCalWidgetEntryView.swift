//
//  SwiftCalWidgetEntryView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

struct SwiftCalWidgetEntryView : View {
	let entry: Entry
	
	@Environment(\.widgetFamily) var widgetFamily

	var body: some View {
		switch widgetFamily {
		case .systemMedium:
			MediumCalendarView(entry: entry)
			
		case .accessoryInline:
			Label("Streak - \(StreakCalculator.calculateStreak(days: entry.days))", systemImage: "swift")
				.widgetURL(URL(string: "streak"))
			
		case .accessoryCircular:
			CircularCalendarView(entry: entry)
				.widgetURL(URL(string: "streak"))
			
		case .accessoryRectangular:
			RectangularCalendarView(entry: entry)
				.widgetURL(URL(string: "calendar"))
			
		default:
			EmptyView()
		}
	}
}

import WidgetKit

struct SwiftCalWidgetEntryViewPreview: PreviewProvider {
	static var previews: some View {
		SwiftCalWidgetEntryView(entry: Entry(date: Date(), days: PersistenceController.generatePreivewDays()))
			.containerBackground(for: .widget) {
				Color.clear
			}
			.previewContext(WidgetPreviewContext(family: .systemMedium))
	}
}
