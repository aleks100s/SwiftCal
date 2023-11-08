//
//  SwiftCalWidget.swift
//  SwiftCalWidget
//
//  Created by Alexander on 02.11.2023.
//

import WidgetKit
import SwiftUI

struct SwiftCalWidget: Widget {
    let kind: String = "SwiftCalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SwiftCalWidgetEntryView(entry: entry)
					.containerBackground(.clear, for: .widget)
            } else {
                SwiftCalWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
		.supportedFamilies(
			[
				.systemMedium,
				.accessoryInline,
				.accessoryCircular,
				.accessoryRectangular
			]
		)
    }
}

#Preview(as: .systemMedium) {
    SwiftCalWidget()
} timeline: {
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
}

#Preview(as: .accessoryInline) {
	SwiftCalWidget()
} timeline: {
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
}

#Preview(as: .accessoryCircular) {
	SwiftCalWidget()
} timeline: {
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
}

#Preview(as: .accessoryRectangular) {
	SwiftCalWidget()
} timeline: {
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
	Entry(date: .now, days: PersistenceController.generatePreivewDays())
}
