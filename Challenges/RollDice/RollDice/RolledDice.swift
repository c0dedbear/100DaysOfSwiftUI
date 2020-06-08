//
//  Dice.swift
//  RollDice
//
//  Created by Михаил Медведев on 06.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import Foundation

struct RolledDice: Codable, Hashable
{
	let sum: Int
	let date: Date

	var sumString: String {
		String(self.sum)
	}

	var formattedDate: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .medium
		return formatter.string(from: self.date)
	}
}

final class RollsHistory: ObservableObject {
	private(set) var rolls = [RolledDice]() {
		didSet {
			self.save()
		}
	}

	func save() {
		let encoder = PropertyListEncoder()
		guard let cards = try? encoder.encode(self.rolls) else { return }
		do {
			try cards.write(to: archiveURL, options: .noFileProtection)
		}
		catch {
			assertionFailure(error.localizedDescription)
		}
	}

	func addRoll(_ roll: RolledDice) {
		self.rolls.append(roll)
	}

	func load() {
		guard let data = try? Data(contentsOf: archiveURL) else { return }
		let decoder = PropertyListDecoder()
		if let rolls = try? decoder.decode([RolledDice].self, from: data) {
			self.rolls = rolls
		}
	}
}

extension RollsHistory {
	private var archiveURL: URL {
		getDocumentsDirectory()
			.appendingPathComponent("rollsHistory")
			.appendingPathExtension("plist")
	}

	private func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
}
