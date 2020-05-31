//
//  ContentView.swift
//  NamedThings
//
//  Created by Mikhail Medvedev on 16.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		ZStack {
		PhotoCards()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
