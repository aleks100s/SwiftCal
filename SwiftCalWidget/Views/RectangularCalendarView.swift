//
//  RectangularCalendarView.swift
//  SwiftCal
//
//  Created by Alexander on 06.11.2023.
//

import SwiftUI

struct RectangularCalendarView: View {
	let entry: Entry
	
	var body: some View {
		SharedCalendarGridView(
			days: entry.days,
			font: .system(size: 7),
			fontWeight: .medium,
			foregroundColor: .primary,
			showBackground: false,
			isLockScreenMode: true,
			minHeight: 10,
			spacing: 4,
			onSaveTapped: {}
		)
	}
}

import WidgetKit

struct RectangularCalendarViewPreview: PreviewProvider {
	static var previews: some View {
		RectangularCalendarView(entry: Entry(date: Date(), days: PersistenceController.generatePreivewDays()))
			.containerBackground(for: .widget) {
				Color.clear
			}
			.previewContext(WidgetPreviewContext(family: .accessoryRectangular))
	}
}
