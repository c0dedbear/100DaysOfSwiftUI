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
	let date = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

final class Prospects: ObservableObject {
	static let saveKey = "SavedData"

	@Published private(set) var people: [Prospect]

	init() {
		self.people = []
		guard let data = try? Data(contentsOf: archiveURL) else { return }
		let decoder = PropertyListDecoder()
		if let people = try? decoder.decode([Prospect].self, from: data) {
			self.people = people
		}
	}

	func sort(by condition: (Prospect, Prospect) throws -> Bool) {
		if let sorted = try? self.people.sorted(by: condition) {
			self.people = sorted
		}
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
}

private extension Prospects {
	private var archiveURL: URL {
		getDocumentsDirectory()
			.appendingPathComponent(Self.saveKey)
			.appendingPathExtension("plist")
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}

	func save() {
		let encoder = PropertyListEncoder()
		guard let cards = try? encoder.encode(people) else { return }
		do {
			try cards.write(to: archiveURL, options: .noFileProtection)
		}
		catch {
			assertionFailure(error.localizedDescription)
		}

	}
}
