//
//  Card.swift
//  NamedThings
//
//  Created by Михаил Медведев on 26.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import UIKit

struct Card: Identifiable, Codable
{
	let id: UUID
	let color: CodableColor
	var location: CodableMKPointAnnotation?
	var imageName: String?
	var title: String?

	var isPlaceholder: Bool {
		return imageName == "placeholder"
	}

	static let samples = [
		Card(id: UUID(), color: UIColor.systemBlue.codable(), imageName: "marc-aupont", title: "Marc Aupont"),
		Card(id: UUID(), color: UIColor.systemGreen.codable(), imageName: "zach-fuller", title: "Zach Fuller"),
		Card(id: UUID(), color: UIColor.systemOrange.codable(), imageName: "caleb-basinger", title: "Caleb Basinger"),
	]
}

