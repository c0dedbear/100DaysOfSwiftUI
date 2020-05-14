//
//  MapWrapView.swift
//  BucketList
//
//  Created by Mikhail Medvedev on 14.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import MapKit
import SwiftUI

struct MapWrapView: View {
	@State private var centerCoordinate = CLLocationCoordinate2D()
	@State private var locations = [CodableMKPointAnnotation]()
	@State private var selectedPlace: CodableMKPointAnnotation?
	@State private var showingPlaceDetails = false
	@State private var showingEditScreen = false
	@State private var isUnlocked = false

	var body: some View {
		ZStack {
			MapView(selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, centerCoordinate: $centerCoordinate, annotations: locations)
				.edgesIgnoringSafeArea(.all)
			Circle()
				.fill(Color.blue)
				.opacity(0.3)
				.frame(width: 32, height: 32)
			VStack {
				Spacer()
				HStack {
					Spacer()
					Button(action: {
						// create a new location
						let newLocation = CodableMKPointAnnotation()
						newLocation.title = "Example location"
						newLocation.coordinate = self.centerCoordinate
						self.locations.append(newLocation)
						self.selectedPlace = newLocation
						self.showingEditScreen = true
					}) {
						Image(systemName: "plus")
						.padding()
						.background(Color.black.opacity(0.75))
						.foregroundColor(.white)
						.font(.title)
						.clipShape(Circle())
						.padding(.trailing)
					}
				}
			}
		}.onAppear(perform: loadData)
		.alert(isPresented: $showingPlaceDetails) {
			Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
				self.showingEditScreen = true
			})
		}
		.sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
			if self.selectedPlace != nil {
				EditView(placemark: self.selectedPlace!)
			}
		}
	}

		func getDocumentsDirectory() -> URL {
			let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
			return paths[0]
		}

		func loadData() {
			let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

			do {
				let data = try Data(contentsOf: filename)
				locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
			} catch {
				print("Unable to load saved data.")
			}
		}

		func saveData() {
			do {
				let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
				let data = try JSONEncoder().encode(self.locations)
				try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
			} catch {
				print("Unable to save data.")
			}
		}
}

