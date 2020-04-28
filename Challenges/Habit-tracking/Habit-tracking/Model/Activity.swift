//
//  Activity.swift
//  Habit-tracking
//
//  Created by Михаил Медведев on 26.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import Foundation

struct Activity: Identifiable, Hashable, Codable
{
	var id: Int
	var title: String
	var description: String
	var completionCount = 0
	var completed = false
}

final class ActivityList: ObservableObject
{
	@Published var activities = [
		Activity(id: 0, title: "Eat", description: "Get some food"),
		Activity(id: 1, title: "Learn Swift", description: "100 Days of SwiftUI"),
		Activity(id: 2, title: "Shopping", description: "Go to the mall for some cloth"),
	]

	func save() {
		let defaults = UserDefaults()
		let encoder = JSONEncoder()
		if let data = try? encoder.encode(self.activities) {
		defaults.set(data, forKey: "activities")
		}
	}

	static func load() -> [Activity]? {
		let defaults = UserDefaults()
		let decoder = JSONDecoder()
		guard let data = defaults.data(forKey: "activities") else { return nil }
		if let activities = try? decoder.decode([Activity].self, from: data) {
			return activities
		}
		return nil
	}
}

