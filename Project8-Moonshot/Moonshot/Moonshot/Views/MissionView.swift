//
//  MissionView.swift
//  Moonshot
//
//  Created by Mikhail Medvedev on 19.04.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct MissionView: View {
	struct CrewMember {
		let role: String
		let astronaut: Astronaut
	}

	let astronauts: [CrewMember]
	let mission: Mission

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.vertical) {
				VStack {
					GeometryReader { insideGeo in
					Image(self.mission.image)
						.resizable()
						.scaledToFit()
						.scaleEffect(1.2 + CGFloat(insideGeo.frame(in: .global).midY - geometry.size.width) / 800)
						.frame(maxWidth: geometry.size.width, alignment: .center)
						.padding(.top)
					}
					Text(self.mission.formattedLaunchDate)
						.padding()

					Text(self.mission.description)
						.padding()

					Spacer(minLength: 25)

					ForEach(self.astronauts, id: \.role) { crewMember in
						HStack {
							NavigationLink(destination: AstronautView(astronaunt: crewMember.astronaut)) {
								Image(crewMember.astronaut.id)
									.resizable()
									.frame(width: 83, height: 60)
									.clipShape(Capsule())
									.overlay(Capsule().stroke(Color.primary, lineWidth: 1))

								VStack(alignment: .leading) {
									Text(crewMember.astronaut.name)
										.font(.headline)
									Text(crewMember.role)
										.foregroundColor(.secondary)
								}
							}
							Spacer()
						}
						.padding(.horizontal)
						.buttonStyle(PlainButtonStyle())
					}
				}
			}
		}
		.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
	}

	init(mission: Mission, astronauts: [Astronaut]) {
		self.mission = mission

		var matches = [CrewMember]()

		for member in mission.crew {
			if let match = astronauts.first(where: { $0.id == member.name }) {
				matches.append(CrewMember(role: member.role, astronaut: match))
			} else {
				fatalError("Missing \(member)")
			}
		}

		self.astronauts = matches
	}
}

struct MissionView_Previews: PreviewProvider {
	static let missions: [Mission] = Bundle.main.decode("missions.json")
	static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

	static var previews: some View {
		MissionView(mission: missions[1], astronauts: astronauts)
	}
}
