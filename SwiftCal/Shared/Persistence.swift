//
//  Persistence.swift
//  SwiftCal
//
//  Created by Alexander on 31.10.2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
		let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start
        for dayOffset in -4 ..< 30 {
            let newItem = Day(context: viewContext)
			newItem.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)
			newItem.didStudy = Bool.random()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
	
	static func generatePreivewDays() -> [Day] {
		let viewContext = preview.container.viewContext
		var days = [Day]()
		let startDate = Calendar.current.dateInterval(of: .month, for: .now)!.start
		for dayOffset in -4 ..< 30 {
			let newItem = Day(context: viewContext)
			newItem.date = Calendar.current.date(byAdding: .day, value: dayOffset, to: startDate)
			newItem.didStudy = Bool.random()
			days.append(newItem)
		}
		return days
	}

    let container: NSPersistentContainer
	
	private var sharedStoreURL: URL {
		let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.alextos.SwiftCal")!
		return container.appendingPathComponent("SwiftCal.sqlite")
	}
	
	private var oldStoreURL: URL {
		let directory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
		return directory.appendingPathComponent("SwiftCal.sqlite")
	}

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftCal")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		} else if !FileManager.default.fileExists(atPath: oldStoreURL.path) {
			container.persistentStoreDescriptions.first!.url = sharedStoreURL
		}
		
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
		
		migrateStore(for: container)
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
	
	func migrateStore(for container: NSPersistentContainer) {
		let coordinator = container.persistentStoreCoordinator
		guard let oldStore = coordinator.persistentStore(for: oldStoreURL) else { return }
		
		do {
			_ = try coordinator.migratePersistentStore(oldStore, to: sharedStoreURL, type: .sqlite)
		} catch {
			fatalError("Unable to migrate to shared store")
		}
		
		do {
			try FileManager.default.removeItem(at: oldStoreURL)
		} catch {
			fatalError("Unable to delete old store")
		}
	}
}
