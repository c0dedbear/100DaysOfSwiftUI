//
//  JSONFetcher.swift
//  UsersAndFriends
//
//  Created by Mikhail Medvedev on 11.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation

final class JSONFetcher
{
	private let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
	func fetchUsers(_ completion: @escaping ([User]?) -> Void) {
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { data, _, error in
			if let error = error {
				print(error.localizedDescription)
				completion(nil)
				return
			}

			if let data = data {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				do {
				let users = try decoder.decode([User].self, from: data)
					completion(users)
				} catch {
					print(error.localizedDescription)
					completion(nil)
				}
			}
		}.resume()
	}
}
