//
//  SharedCalendarHeader.swift
//  SwiftCal
//
//  Created by Alexander on 03.11.2023.
//

import SwiftUI

struct SharedCalendarHeader: View {
	var font: Font = .body
	
	private let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]

	var body: some View {
		HStack {
			ForEach(daysOfWeek, id: \.self) { dayOfWeek in
				Text(dayOfWeek)
					.font(font)
					.fontWeight(.black)
					.foregroundStyle(.orange)
					.frame(maxWidth: .infinity)
			}
		}
	}
}

#Preview {
	SharedCalendarHeader()
}
