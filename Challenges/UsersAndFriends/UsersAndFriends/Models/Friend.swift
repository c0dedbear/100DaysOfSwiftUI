//
//  Friend.swift
//  UsersAndFriends
//
//  Created by Mikhail Medvedev on 11.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation

final class Friend: Codable, Hashable, ObservableObject {
	enum CodingKeys: CodingKey {
		case id
		case name
	}

	@Published var id: String
	@Published var name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.id, forKey: .id)
		try container.encode(self.name, forKey: .name)
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
	}

	static func == (lhs: Friend, rhs: Friend) -> Bool {
		return lhs.id == rhs.id && lhs.name == rhs.name
	}
}
