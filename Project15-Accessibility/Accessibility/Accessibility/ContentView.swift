//
//  ContentView.swift
//  Accessibility
//
//  Created by Михаил Медведев on 15.05.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	// MARK: Identifying views with useful labels
	/*
	let pictures = [
	"ales-krivec-15949",
	"galina-n-189483",
	"kevin-horstmann-141705",
	"nicolas-tissot-335096"
	]

	let labels = [
	"Tulips",
	"Frozen tree buds",
	"Sunflowers",
	"Fireworks",
	]

	@State private var selectedPicture = Int.random(in: 0...3)

	var body: some View {
	Image(pictures[selectedPicture])
	.resizable()
	.scaledToFit()
	.onTapGesture {
	self.selectedPicture = Int.random(in: 0...3)
	}
	.accessibility(label: Text(labels[selectedPicture]))
	.accessibility(addTraits: .isButton)
	.accessibility(removeTraits: .isImage)
	}

	//The last way to hide content from VoiceOver is through grouping, which lets us control how the system reads several views that are related. As an example, consider this layout:

	VStack {
	Text("Your score is")
	Text("1000")
	.font(.title)
	}
	.accessibilityElement(children: .combine)

	With that modifier the image becomes invisible to VoiceOver regardless of what traits it has. Obviously you should only use this if the view in question really does add nothing – if you had placed a view offscreen so that it wasn’t currently visible to users, you should mark it inaccessible to VoiceOver too.
	Image(decorative: "character")
	.accessibility(hidden: true)

	*/

	// MARK: Reading the value of controls
	@State private var estimate = 25.0
	@State private var rating = 3

	var body: some View {
		VStack {
			Slider(value: $estimate, in: 0...50)
				.padding()
				.accessibility(value: Text("\(Int(estimate))"))
			Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
				.accessibility(value: Text("\(rating) out of 5"))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
