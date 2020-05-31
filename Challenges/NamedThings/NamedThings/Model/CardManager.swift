//
//  CardManager.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//
import SwiftUI

final class CardManager: NSObject, ObservableObject
{
	private var storageService = StorageService()

	@Published var storage: [Card]

	var lastThreeCards: [Card] {
		self.storage.suffix(3)
	}

	func removeLast() {
		self.storage.removeLast()
		self.saveCards()
	}

	func saveCards() {
		self.storageService.saveCards(self.storage)
	}

	override init() {
		self.storage = storageService.loadCards() ?? Card.samples
	}
}
extension CardManager: UISceneDelegate {

}
