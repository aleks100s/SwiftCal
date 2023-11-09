//
//  InlineCalendarView.swift
//  SwiftCal
//
//  Created by Alexander on 06.11.2023.
//

import SwiftUI

struct CircularCalendarView: View {
	let entry: Entry
	
	var body: some View {
		Gauge(value: Double(entry.daysStudied), in: 1 ... Double(entry.currentCalendarDays)) {
			Image(systemName: "swift")
		} currentValueLabel: {
			Text("\(entry.daysStudied)")
		}
		.gaugeStyle(.accessoryCircular)
	}
}

import WidgetKit

struct CircularCalendarViewPreview: PreviewProvider {
	static var previews: some View {
		CircularCalendarView(entry: Entry(date: Date(), days: 
				Persistence.generatePreivewDays()))
			.containerBackground(for: .widget) {
				Color.clear
			}
			.previewContext(WidgetPreviewContext(family: .accessoryCircular))
	}
}
