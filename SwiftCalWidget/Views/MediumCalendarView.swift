//
//  MediumCalendarView.swift
//  SwiftCal
//
//  Created by Alexander on 06.11.2023.
//

import SwiftUI

struct MediumCalendarView: View {
	let entry: Entry
	
	var body: some View {
		HStack(spacing: 16) {
			Link(destination: URL(string: "streak")!) {
				SharedStreakView(numberFontSize: 70, textFont: .caption, days: entry.days)
			}
			
			VStack {
				SharedCalendarHeader(font: .caption)
				Link(destination: URL(string: "calendar")!) {
					SharedCalendarGridView(days: entry.days, font: .caption2, minHeight: 20, spacing: 2, onSaveTapped: {})
				}
			}
		}
	}
}

import WidgetKit

struct MediumCalendarViewPreview: PreviewProvider {
	static var previews: some View {
		MediumCalendarView(entry: Entry(date: Date(), days: PersistenceController.generatePreivewDays()))
			.containerBackground(for: .widget) {
				Color.clear
			}
			.previewContext(WidgetPreviewContext(family: .systemMedium))
	}
}
