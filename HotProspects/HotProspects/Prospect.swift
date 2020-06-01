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
    var isContacted = false
}

final class Prospects: ObservableObject {
	@Published var people: [Prospect]

	init() {
		self.people = []
	}
}
