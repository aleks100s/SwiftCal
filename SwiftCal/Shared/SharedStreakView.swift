//
//  SharedStreakView.swift
//  SwiftCal
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

struct SharedStreakView: View {
	let numberFontSize: CGFloat
	let textFont: Font
	
	var days: [Day]
	
	@State private var streak: Int = 0
	
	var body: some View {
		VStack {
			Text("\(streak)")
				.font(.system(size: numberFontSize, weight: .semibold, design: .rounded))
				.foregroundStyle(streak > 0 ? .orange : .pink)
			Text("Month Streak")
				.font(textFont)
				.bold()
				.foregroundStyle(.secondary)
		}
		.onAppear {
			streak = StreakCalculator.calculateStreak(days: days)
		}
	}
}

#Preview {
	SharedStreakView(numberFontSize: 200, textFont: .title2, days: PersistenceController.generatePreivewDays())
}
