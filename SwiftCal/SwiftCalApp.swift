//
//  SwiftCalApp.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI

@main
struct SwiftCalApp: App {
    let persistenceController = PersistenceController.shared
	
	@State private var selectedTab = 0

    var body: some Scene {
        WindowGroup {
			TabView(selection: $selectedTab) {
				CalendarView()
					.tabItem { Label("Calendar", systemImage: "calendar") }
					.tag(0)
				
				StreakView()
					.tabItem { Label("Streak", systemImage: "swift") }
					.tag(1)
			}
			.environment(\.managedObjectContext, persistenceController.container.viewContext)
			.onOpenURL { url in
				switch url.absoluteString {
				case "streak":
					selectedTab = 1
					
				case "calendar":
					selectedTab = 0
					
				default:
					break
				}
			}
        }
    }
}
