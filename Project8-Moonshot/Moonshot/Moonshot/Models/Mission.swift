//
//  Mission.swift
//  Moonshot
//
//  Created by Mikhail Medvedev on 18.04.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

	var displayName: String {
		"Apollo \(id)"
	}

	var image: String {
		"apollo\(id)"
	}

	var crewNames: String {
		self.crew.map {$0.name }.joined(separator: ", ")
	}

	var formattedLaunchDate: String {
		if let date = launchDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			return formatter.string(from: date)
		}
		else {
			return "N/A"
		}
	}
}
