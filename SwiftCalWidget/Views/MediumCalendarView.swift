//
//  MediumCalendarView.swift
//  SwiftCal
//
//  Created by Alexander on 06.11.2023.
//

import SwiftUI
import AppIntents

struct MediumCalendarView: View {
	let entry: Entry
	
	private var studyTitle: String {
		entry.today.didStudy ? "Studied" : "Study"
	}
	
	private var studyButtonIcon: String {
		entry.today.didStudy ? "checkmark.circle" : "book"
	}
	
	var body: some View {
		HStack(spacing: 16) {
			VStack {
				Link(destination: URL(string: "streak")!) {
					SharedStreakView(numberFontSize: 70, textFont: .caption, days: entry.days)
				}
				
				Button(studyTitle, systemImage: studyButtonIcon, intent: ToggleStudyIntent(date: entry.today.date))
					.tint(entry.today.didStudy ? .mint : .orange)
					.fontWidth(.compressed)
			}
			.frame(width: 100)
			
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
		MediumCalendarView(entry: Entry(date: Date(), days: Persistence.generatePreivewDays()))
			.containerBackground(for: .widget) {
				Color.clear
			}
			.previewContext(WidgetPreviewContext(family: .systemMedium))
	}
}
