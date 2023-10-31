//
//  ContentView.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import CoreData

struct CalendarView: View {
	private let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Day.date, ascending: true)],
		predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)", Date().startOfMonthWithCalendarPrefix as CVarArg, Date().endOfMonth as CVarArg),
		animation: .default)
    private var days: FetchedResults<Day>

    var body: some View {
        NavigationView {
			VStack {
				HStack {
					ForEach(daysOfWeek, id: \.self) { dayOfWeek in
						Text(dayOfWeek)
							.fontWeight(.black)
							.foregroundStyle(.orange)
							.frame(maxWidth: .infinity)
					}
				}
				
				LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
					ForEach(days) { day in
						Text(day.date?.formatted(.dateTime.day()) ?? "")
							.fontWeight(.bold)
							.foregroundStyle(day.foregroundColor)
							.frame(maxWidth: .infinity, minHeight: 40)
							.background(Circle().fill(day.backgroundColor))
							.onTapGesture {
								if day.isTappable {
									day.didStudy.toggle()
									saveContext()
								}
							}
					}
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

private extension Day {
	var foregroundColor: Color {
		if date?.isInCurrentMonth == true {
			didStudy ? .orange : .secondary
		} else {
			.secondary.opacity(0.4)
		}
	}
	
	var backgroundColor: Color {
		if date?.isInCurrentMonth == true {
			.orange.opacity(didStudy ? 0.3 : 0.0)
		} else {
			.secondary.opacity(didStudy ? 0.1 : 0.0)
		}
	}
	
	var isTappable: Bool {
		date!.dayInt <= Date().dayInt && date!.monthInt == Date().monthInt
	}
}

#Preview {
    CalendarView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
