//
//  StreakView.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import SwiftData

struct StreakView: View {
	static var startDate: Date { .now.startOfMonthWithCalendarPrefix }
	static var endDate: Date { .now.endOfMonth }
	
	@Query(filter: #Predicate<Day> { $0.date > startDate && $0.date < endDate }, sort: \Day.date, animation: .default)
	var days: [Day]
	
	var body: some View {
		SharedStreakView(numberFontSize: 200, textFont: .title2, days: Array(days))
			.offset(y: -50)
	}
}

#Preview {
	StreakView()
}
