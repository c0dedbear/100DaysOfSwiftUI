//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Михаил Медведев on 09.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	enum ResortSorting {
		case `default`
		case alphabetical
		case byCountry
	}
	@ObservedObject var favorites = Favorites()

	private let resorts: [Resort] = Bundle.main.decode("resorts.json")

	@State var sorting = ResortSorting.default

	private var sortedResorts: [Resort] {
		switch sorting {
		case .default:
			return resorts
		case .alphabetical:
			return self.resorts.sorted { $0.name < $1.name }
		case .byCountry:
			return self.resorts.sorted { $0.country < $1.country }
		}
	}

	var body: some View {
       NavigationView {
		VStack {
		Picker("", selection: $sorting) {
			Text("default").tag(ResortSorting.default)
			Text("by alphabetical").tag(ResortSorting.alphabetical)
			Text("by country").tag(ResortSorting.byCountry)
		}
		.pickerStyle(SegmentedPickerStyle())
		.padding()
			List(sortedResorts) { resort in
				NavigationLink(destination: ResortView(resort: resort)) {
					Image(resort.country)
						.resizable()
						.scaledToFill()
						.frame(width: 40, height: 25)
						.clipShape(
							RoundedRectangle(cornerRadius: 5)
						)
						.overlay(
							RoundedRectangle(cornerRadius: 5)
								.stroke(Color.black, lineWidth: 1)
						)

					VStack(alignment: .leading) {
						Text(resort.name)
							.font(.headline)
						Text("\(resort.runs) runs")
							.foregroundColor(.secondary)
					}
				}.layoutPriority(1)
				if self.favorites.contains(resort) {
					Spacer()
					Image(systemName: "heart.fill")
					.accessibility(label: Text("This is a favorite resort"))
						.foregroundColor(.red)
				}
			}
		}
			.navigationBarTitle("Resorts")

		 	WelcomeView()
		}.environmentObject(favorites)
//	.phoneOnlyStackNavigationView()
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
