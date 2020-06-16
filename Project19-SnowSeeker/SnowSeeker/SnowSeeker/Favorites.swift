//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Михаил Медведев on 09.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

final class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

	private var archiveURL: URL {
		getDocumentsDirectory()
			.appendingPathComponent(saveKey)
			.appendingPathExtension("plist")
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}

    init() {
		self.resorts = []
		guard let data = try? Data(contentsOf: archiveURL) else { return }
		let decoder = PropertyListDecoder()
		if let resorts = try? decoder.decode(Set<String>.self, from: data) {
			self.resorts = resorts
		}
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
       let encoder = PropertyListEncoder()
		guard let resorts = try? encoder.encode(self.resorts) else { return }
		do {
			try resorts.write(to: archiveURL, options: .noFileProtection)
		}
		catch {
			assertionFailure(error.localizedDescription)
		}
    }
}
