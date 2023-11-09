//
//  StreakCalculator.swift
//  SwiftCal
//
//  Created by Alexander on 03.11.2023.
//

import Foundation

enum StreakCalculator {
	static func calculateStreak(days: [Day]) -> Int {
		guard !days.isEmpty else { return 0 }
				
		let days = days.filter { $0.date.dayInt <= Date().dayInt }
		var counter = 0
		for day in days.reversed() {
			if day.didStudy {
				counter += 1
			} else if day.date.dayInt != Date().dayInt {
				break
			}
		}
		return counter
	}
}
