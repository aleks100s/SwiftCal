//
//  StreakView.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import CoreData

struct StreakView: View {
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
		predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)", Date().startOfMonth as CVarArg, Date() as CVarArg),
		animation: .default)
	private var days: FetchedResults<Day>
	
	@State private var streak: Int = 0
	
	var body: some View {
		VStack {
			Text("\(streak)")
				.font(.system(size: 200, weight: .semibold, design: .rounded))
				.foregroundStyle(streak > 0 ? .orange : .pink)
			Text("Current Month Streak")
				.font(.title2)
				.bold()
				.foregroundStyle(.secondary)
		}
		.offset(y: -50)
		.onAppear {
			streak = calculateStreak()
		}
	}
	
	func calculateStreak() -> Int {
		guard !days.isEmpty else { return 0 }
		
		var counter = 0
		for day in days.reversed() {
			if day.didStudy {
				counter += 1
			} else if day.date!.dayInt != Date().dayInt {
				break
			}
		}
		return counter
	}
}

#Preview {
	StreakView()
}
