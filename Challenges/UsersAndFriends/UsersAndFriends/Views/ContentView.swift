//
//  ContentView.swift
//  UsersAndFriends
//
//  Created by Mikhail Medvedev on 11.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var users = [User]()

	var body: some View {
		NavigationView {
			List {
				ForEach(users, id: \.self) { user in
					NavigationLink(destination: DetailUserView(user: user)) {
						VStack(alignment: .leading) {
							Text(user.name)
								.font(.headline)
							Text("Age: \(user.age) from \(user.company)")
								.foregroundColor(.secondary)
						}
					}
				}
			}.onAppear() {
				self.loadUsers()
			}
		}.navigationBarTitle("Users and Friends")
	}

	private func loadUsers() {
		let fetcher = JSONFetcher()
		fetcher.fetchUsers { users in
			if let users = users {
				self.users = users
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
