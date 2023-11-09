//
//  Day+.swift
//  SwiftCal
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

extension Day {
	var foregroundColor: Color {
		if date.isInCurrentMonth {
			didStudy ? .orange : .secondary
		} else {
			.secondary.opacity(0.4)
		}
	}
	
	var backgroundColor: Color {
		if date.isInCurrentMonth {
			.orange.opacity(didStudy ? 0.3 : 0.0)
		} else {
			.secondary.opacity(didStudy ? 0.1 : 0.0)
		}
	}
	
	var isTappable: Bool {
		date.dayInt <= Date().dayInt && date.monthInt == Date().monthInt
	}
}
