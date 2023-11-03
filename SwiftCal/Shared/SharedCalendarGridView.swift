//
//  SharedCalendarGridView.swift
//  SwiftCal
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

struct SharedCalendarGridView: View {
	let days: [Day]
	var font: Font = .body
	var minHeight: CGFloat = 40
	var spacing: CGFloat = 8
	let onSaveTapped: () -> Void
	
	var body: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: spacing) {
			ForEach(days) { day in
				Text(day.date?.formatted(.dateTime.day()) ?? "")
					.font(font)
					.fontWeight(.bold)
					.foregroundStyle(day.foregroundColor)
					.frame(maxWidth: .infinity, minHeight: minHeight)
					.background {
						Circle()
							.fill(day.backgroundColor)
					}
					.onTapGesture {
						if day.isTappable {
							day.didStudy.toggle()
							onSaveTapped()
						}
					}
			}
		}
	}
}

#Preview {
	SharedCalendarGridView(days: PersistenceController.generatePreivewDays(), onSaveTapped: {})
}
