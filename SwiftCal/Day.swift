//
//  Day.swift
//  SwiftCal
//
//  Created by Alexander on 09.11.2023.
//
//

import Foundation
import SwiftData

@Model 
public class Day {
    var date: Date
    var didStudy: Bool
    
	public init(date: Date, didStudy: Bool) {
		self.date = date
		self.didStudy = didStudy
	}
}
