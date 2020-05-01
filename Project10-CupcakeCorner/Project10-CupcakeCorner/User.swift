//
//  User.swift
//  Project10-CupcakeCorner
//
//  Created by Михаил Медведев on 30.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import Foundation


class User: ObservableObject, Codable
{
	enum CodingKeys: CodingKey {
		case name
	}

	@Published var name = "Mikhail Medvedev"

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
	}
}
