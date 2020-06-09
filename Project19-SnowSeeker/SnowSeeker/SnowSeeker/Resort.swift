//
//  Resort.swift
//  SnowSeeker
//
//  Created by Михаил Медведев on 09.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]

	var facilityTypes: [Facility] {
		facilities.map(Facility.init)
	}

	static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
	static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
