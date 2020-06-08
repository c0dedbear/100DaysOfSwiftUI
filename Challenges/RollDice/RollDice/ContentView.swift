//
//  ContentView.swift
//  RollDice
//
//  Created by Михаил Медведев on 06.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	private var history = RollsHistory()
	@State var dicesCount = 2

	var body: some View {
		TabView {
			Dices_View(dicesCount: $dicesCount)
				.tabItem {
					Image(systemName: "cube")
					Text("Roll")
			}
			RollsHistoryView()
				.tabItem {
					Image(systemName: "book")
					Text("History")
			}
		}.environmentObject(history)
		.onAppear {
			self.history.load()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
