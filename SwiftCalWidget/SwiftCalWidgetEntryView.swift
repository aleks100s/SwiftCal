//
//  SwiftCalWidgetEntryView.swift
//  SwiftCalWidgetExtension
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

struct SwiftCalWidgetEntryView : View {
	var entry: Entry

	var body: some View {
		HStack(spacing: 16) {
			SharedStreakView(numberFontSize: 70, textFont: .caption, days: entry.days)
			
			VStack {
				SharedCalendarHeader(font: .caption)
				SharedCalendarGridView(days: entry.days, font: .caption2, minHeight: 20, spacing: 2, onSaveTapped: {})
			}
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
