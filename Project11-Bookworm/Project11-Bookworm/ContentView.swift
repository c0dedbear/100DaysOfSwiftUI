//
//  ContentView.swift
//  Project11-Bookworm
//
//  Created by Mikhail Medvedev on 05.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	var body: some View {
		VStack() {
			Text("Creating a custom component with @Binding")
			CustomComponentwithBindingView().padding()
			Text("Combine Core Data and SwiftUI")
			CoreDataView()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
