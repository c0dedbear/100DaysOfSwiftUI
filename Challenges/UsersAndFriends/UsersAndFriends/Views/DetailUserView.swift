//
//  DetailUserView.swift
//  UsersAndFriends
//
//  Created by Mikhail Medvedev on 11.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct DetailUserView: View {
	@Environment(\.managedObjectContext) var moc
	@Environment(\.presentationMode) var presentationMode

	@State private var showingFriendInfo = false

	let user: User

	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack {
					ZStack(alignment: .bottomTrailing) {
						Image("user")
							.resizable()
							.frame(maxWidth: geometry.size.width / 2, maxHeight: geometry.size.width / 2)

						Text("Age: \(self.user.age)")
							.font(.caption)
							.fontWeight(.black)
							.padding(8)
							.foregroundColor(.white)
							.background(Color.black.opacity(0.75))
							.clipShape(Capsule())
							.offset(x: -10, y: -5)
					}

					HStack {
						Text("from ")
							.font(.headline)
							.foregroundColor(.secondary)
						Text("\(self.user.company) company")
							.font(.title)
							.foregroundColor(.secondary)
					}

					Text("\(self.user.about)").font(.body).padding()

					VStack(alignment: .leading) {
						Text("Registered: \(self.user.formattedRegisteredDateString)")
						Text("Email: \(self.user.email)")
						Text("Address: \(self.user.address)")
					}.padding()

					VStack(spacing: 8) {
						Text("Friends: ")
						.font(.title)
						.foregroundColor(.secondary)
						ForEach(self.user.friends, id: \.self) { friend in
							Button(friend.name) {
								self.showingFriendInfo = true
							}
							.padding()
							.background(Color.blue)
							.foregroundColor(.white)
							.cornerRadius(10)
							.shadow(radius: 2)
							}
						}

					Spacer()
				}
			}
		}
		.navigationBarTitle(Text(user.name), displayMode: .inline)
		.sheet(isPresented: $showingFriendInfo) {
			DetailUserView(user: self.user)
		}
	}

	init(user: User) {
		self.user = user
	}
}

//struct DetailUserView_Previews: PreviewProvider {
//    static var previews: some View {
//		DetailUserView(user: User())
//    }
//}
