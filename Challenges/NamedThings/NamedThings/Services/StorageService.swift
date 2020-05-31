//
//  StorageService.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation

final class StorageService
{
	private var archiveURL: URL {
		getDocumentsDirectory()
			.appendingPathComponent("images")
			.appendingPathExtension("plist")
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}

	func saveCards(_ cards: [Card]) {
		let encoder = PropertyListEncoder()
		guard let cards = try? encoder.encode(cards) else { return }
		do {
			try cards.write(to: archiveURL, options: .noFileProtection)
		}
		catch {
			assertionFailure(error.localizedDescription)
		}
	}

	func loadCards() -> [Card]? {
		guard let data = try? Data(contentsOf: archiveURL) else { return nil }
		let decoder = PropertyListDecoder()
		let cards = try? decoder.decode([Card].self, from: data)
		return cards
	}
}
