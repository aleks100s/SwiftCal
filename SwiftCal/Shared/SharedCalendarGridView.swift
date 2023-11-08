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
	var fontWeight: Font.Weight = .bold
	var foregroundColor: Color? = nil
	var showBackground: Bool = true
	var isLockScreenMode: Bool = false
	var minHeight: CGFloat = 40
	var spacing: CGFloat = 8
	let onSaveTapped: () -> Void
	
	var body: some View {
		LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: spacing) {
			ForEach(days) { day in
				if isLockScreenMode {
					if day.date?.isInCurrentMonth == false {
						Text(" ")
					} else if day.didStudy {
						Image(systemName: "swift")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 7, height: 7)
					} else {
						calendarDay(day)
					}
				} else {
					calendarDay(day)
				}
			}
		}
	}
	
	@ViewBuilder
	private func calendarDay(_ day: Day) -> some View {
		Text(day.date?.formatted(.dateTime.day()) ?? "")
			.font(font)
			.fontWeight(fontWeight)
			.foregroundStyle(foregroundColor ?? day.foregroundColor)
			.frame(maxWidth: .infinity, minHeight: minHeight)
			.background {
				if showBackground {
					Circle()
						.fill(day.backgroundColor)
				} else {
					EmptyView()
				}
			}
			.onTapGesture {
				if day.isTappable {
					day.didStudy.toggle()
					onSaveTapped()
				}
			}
	}
}

#Preview {
	SharedCalendarGridView(days: PersistenceController.generatePreivewDays(), onSaveTapped: {})
}
