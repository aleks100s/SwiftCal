//
//  ContentView.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import CoreData
import WidgetKit

struct CalendarView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
		predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)", Date().startOfMonthWithCalendarPrefix as CVarArg, Date().endOfMonth as CVarArg),
		animation: .default)
    private var days: FetchedResults<Day>

    var body: some View {
        NavigationView {
			VStack {
				SharedCalendarHeader()
				
				SharedCalendarGridView(days: Array(days)) {
					saveContext()
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
			let newDay = Day(context: viewContext)
			newDay.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)
			newDay.didStudy = false
		}
		saveContext()
	}
	
	func saveContext() {
		do {
			try viewContext.save()
		} catch {
			print("Failed to saved context: \(error.localizedDescription)")
		}
	}
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
