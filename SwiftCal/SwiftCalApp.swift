//
//  SwiftCalApp.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftCalApp: App {
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
			.modelContainer(Persistence.container)
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
