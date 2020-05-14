//
//  ContentView.swift
//  BucketList
//
//  Created by Mikhail Medvedev on 14.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
	@State private var isUnlocked = false
	@State private var showAuthAlert = false

	var body: some View {
		VStack {
			if isUnlocked {
				MapWrapView()
			} else {
				Button("Unlock Places") {
					self.authenticate()
				}
				.padding()
				.background(Color.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
			}
		}.alert(isPresented: $showAuthAlert) {
			Alert(title: Text("Authentication failed"), message: Text("Please try again"), dismissButton: .cancel())
		}
	}

	func authenticate() {
		let context = LAContext()
		var error: NSError?

		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			let reason = "Please authenticate yourself to unlock your places."

			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

				DispatchQueue.main.async {
					if success {
						self.isUnlocked = true
					} else {
						self.showAuthAlert = true
					}
				}
			}
		} else {
			self.showAuthAlert = true
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
