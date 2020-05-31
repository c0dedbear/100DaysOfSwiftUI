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
	@Environment(\.presentationMode) var presentationMode
	@State private var locationManager = LocationFetcher()
	@State private var centerCoordinate = CLLocationCoordinate2D()
	@State var selectedPlace: CodableMKPointAnnotation?
	@State private var showingPlaceDetails = false
	@State private var showingEditScreen = false
	@State private var isRegionChanged = false

	var fillLocation: (_ location: CodableMKPointAnnotation?) -> Void

	var body: some View {
		ZStack {
			MapView(selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, centerCoordinate: $centerCoordinate, isRegionChanged: $isRegionChanged, annotation: selectedPlace)
				.edgesIgnoringSafeArea(.all)
			Circle()
				.fill(Color.blue)
				.opacity(0.3)
				.frame(width: 32, height: 32)
				.onTapGesture {
					self.createNewPin()
			}
			VStack {
				Button(action: {
					 self.presentationMode.wrappedValue.dismiss()
				}) {
					Image(systemName: "xmark").foregroundColor(.black)
						.font(.title)
						.padding()
						.padding(.trailing, 360)
				}
				Spacer()
				VStack {
					Spacer()
					Button(action: {
						self.createNewPin()
					}) {
						Image(systemName: "plus")
						.padding()
						.background(Color.black.opacity(0.75))
						.foregroundColor(.white)
						.font(.title)
						.clipShape(Circle())
					}
					.padding()
					Button(action: {
						self.setCurrentLocation()
					}) {
						Image(systemName: "location")
						.padding()
						.background(Color.black.opacity(0.75))
						.foregroundColor(.white)
						.font(.title)
						.clipShape(Circle())
					}
				}.padding(.leading, 300)
			}
		}.onAppear {
			self.locationManager.start()
			DispatchQueue.main.async {
				withAnimation {
					if self.selectedPlace != nil {
						self.setSelectedPlace()
					}
//					else {
//						self.setCurrentLocation()
//					}
				}
			}
		}
		.alert(isPresented: $showingPlaceDetails) {
			Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."),
				  primaryButton: .destructive(Text("Delete"), action: {
					self.selectedPlace = nil
					self.fillLocation(self.selectedPlace)
			}), secondaryButton: .default(Text("Edit")) {
				self.showingEditScreen = true
			})
		}
		.sheet(isPresented: $showingEditScreen, onDismiss: { self.fillLocation(self.selectedPlace)}) {
			if self.selectedPlace != nil {
				EditView(placemark: self.selectedPlace!)
			}
		}
	}

//	private	func getDocumentsDirectory() -> URL {
//			let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//			return paths[0]
//		}

//	private	func loadData() {
//			let filename = getDocumentsDirectory().appendingPathComponent("SavedPlace")
//
//			do {
//				let data = try Data(contentsOf: filename)
//				selectedPlace = try JSONDecoder().decode(CodableMKPointAnnotation.self, from: data)
//			} catch {
//				print("Unable to load saved data.")
//			}
//		}
//
//	private func saveData() {
//			guard let location = selectedPlace else { return }
//			do {
//				let filename = getDocumentsDirectory().appendingPathComponent("SavedPlace")
//				let data = try JSONEncoder().encode(location)
//				try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
//			} catch {
//				print("Unable to save data.")
//			}
//		}

	private func createNewPin() {
		let newLocation = CodableMKPointAnnotation()
		newLocation.title = "Example location"
		newLocation.coordinate = self.centerCoordinate
		self.selectedPlace = newLocation
		self.showingEditScreen = true
	}
	private func setSelectedPlace() {
		if let location = self.selectedPlace {
			self.centerCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
			self.isRegionChanged = true
		  }
	}

	private func setCurrentLocation()  {
		if let location = self.locationManager.lastKnownLocation {
			self.centerCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
			self.isRegionChanged = true
		  }
	}
}

