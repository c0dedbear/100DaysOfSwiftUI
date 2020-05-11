//
//  User.swift
//  UsersAndFriends
//
//  Created by Mikhail Medvedev on 11.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation
import SwiftUI

final class User: Codable, ObservableObject {
	enum CodingKeys: CodingKey {
		case id, isActive, name, age, company, email, address, registered, tags, friends, about
	}

	@Published var id: String
    @Published var isActive: Bool
    @Published var name: String
    @Published var age: Int
    @Published var company: String
	@Published var email: String
	@Published var address: String
	@Published var about: String
    @Published var registered: Date
    @Published var tags: [String]
    @Published var friends: [Friend]

	var formattedRegisteredDateString: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter.string(from: registered)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try container.encode(isActive, forKey: .isActive)
		try container.encode(name, forKey: .name)
		try container.encode(age, forKey: .age)
		try container.encode(company, forKey: .company)
		try container.encode(email, forKey: .email)
		try container.encode(address, forKey: .address)
		try container.encode(about, forKey: .about)
		try container.encode(registered, forKey: .registered)
		try container.encode(tags, forKey: .tags)
		try container.encode(friends, forKey: .friends)

	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.isActive = try container.decode(Bool.self, forKey: .isActive)
		self.name = try container.decode(String.self, forKey: .name)
		self.age = try container.decode(Int.self, forKey: .age)
		self.company = try container.decode(String.self, forKey: .company)
		self.email = try container.decode(String.self, forKey: .email)
		self.address = try container.decode(String.self, forKey: .address)
		self.about = try container.decode(String.self, forKey: .about)
		self.registered = try container.decode(Date.self, forKey: .registered)
		self.tags = try container.decode([String].self, forKey: .tags)
		self.friends = try container.decode([Friend].self, forKey: .friends)
	}
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }

	static func == (lhs: User, rhs: User) -> Bool {
		lhs.id == rhs.id && lhs.registered == rhs.registered
	}
}
