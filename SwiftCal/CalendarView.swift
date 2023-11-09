//
//  ContentView.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import SwiftData
import WidgetKit

struct CalendarView: View {
	private static var startDate: Date { .now.startOfMonthWithCalendarPrefix }
	private static var endDate: Date { .now.endOfMonth }
	
    @Environment(\.modelContext) private var context
	@Query(filter: #Predicate<Day> { $0.date > startDate && $0.date < endDate }, sort: \Day.date, animation: .default)
	private var days: [Day]

    var body: some View {
        NavigationView {
			VStack {
				SharedCalendarHeader()
				
				SharedCalendarGridView(days: Array(days)) {
					WidgetCenter.shared.reloadTimelines(ofKind: "SwiftCalWidget")
				}
				
				Spacer()
			}
			.padding()
			.navigationTitle(Date().formatted(.dateTime.month(.wide)))
        }
		.onAppear {
			if days.isEmpty {
				createMonthDates(date: .now.startOfPreviousMonth)
				createMonthDates(date: .now)
			} else if days.count < 10 {
				createMonthDates(date: .now)
			}
		}
    }
	
	func createMonthDates(date: Date) {
		for dayOffset in 0 ..< date.numberOfDaysInMonth {
			let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth) ?? .now
			let newDay = Day(date: date, didStudy: false)
			context.insert(newDay)
		}
	}
}

#Preview {
    CalendarView()
}
