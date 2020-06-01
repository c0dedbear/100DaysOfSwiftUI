//
//  Prospect.swift
//  HotProspects
//
//  Created by Михаил Медведев on 01.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

final class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

final class Prospects: ObservableObject {
	static let saveKey = "SavedData"

	@Published private(set) var people: [Prospect]

	init() {
		if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
			if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
				self.people = decoded
				return
			}
		}

		self.people = []
	}

	func add(_ prospect: Prospect) {
		people.append(prospect)
		save()
	}

	func toggle(_ prospect: Prospect) {
		objectWillChange.send()
		prospect.isContacted.toggle()
		self.save()
	}

	private func save() {
		if let encoded = try? JSONEncoder().encode(people) {
			UserDefaults.standard.set(encoded, forKey: Self.saveKey)
		}

	}
}
