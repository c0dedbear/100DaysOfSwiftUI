//
//  AstronautView.swift
//  Moonshot
//
//  Created by Mikhail Medvedev on 19.04.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct AstronautView: View, Identifiable {

	var id: String {
		return self.astronaut.id
	}

	let astronaut: Astronaut
	let missions: [Mission]

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					Image(self.astronaut.id)
						.resizable()
						.scaledToFit()
						.frame(width: geometry.size.width)
						.clipShape(Circle())
						.padding()

					Text(self.astronaut.description)
					.padding()
					Spacer()
					ForEach(self.missions, id: \.id) { mission in
						HStack {
							Image(mission.image)
								.resizable()
								.frame(width: 83, height: 60)
								.clipShape(Circle())

							VStack(alignment: .leading) {
								Text(mission.displayName)
									.font(.headline)
							}
							Spacer()
						}
						.padding(.horizontal)
					}
				}
			}
		}
		.navigationBarTitle(Text(astronaut.name), displayMode: .inline)
	}

	init(astronaunt: Astronaut){
		let missions: [Mission] = Bundle.main.decode("missions.json")

		var matches = [Mission]()

		for mission in missions {
			if let _ = mission.crew.first(where: { $0.name == astronaunt.id }) {
				matches.append(mission)
			}
		}

		self.astronaut = astronaunt
		self.missions = matches
	}
}

struct AstronautView_Previews: PreviewProvider {
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
	static let missions: [Mission] = Bundle.main.decode("missions.json")

	static var previews: some View {
		AstronautView(astronaunt: astronauts[0])
	}
}
