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
		predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)", Date().startOfMonth as CVarArg, Date().endOfMonth as CVarArg),
		animation: .default)
	private var days: FetchedResults<Day>
	
	
	var body: some View {
		SharedStreakView(numberFontSize: 200, textFont: .title2, days: Array(days))
			.offset(y: -50)
	}
}

#Preview {
	StreakView()
}
