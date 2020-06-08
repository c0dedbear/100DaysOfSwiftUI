//
//  RollsHistoryView.swift
//  RollDice
//
//  Created by Михаил Медведев on 08.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct RollsHistoryView: View {
	@EnvironmentObject private var history: RollsHistory

	var body: some View {
		NavigationView {
			List {
				ForEach(history.rolls, id: \.self) { roll in
					HStack {
						VStack(alignment: .leading) {
							Text("Rolled \(roll.sumString) at \(roll.formattedDate)")
								.font(.subheadline)
						}
					}
				}
			}
			.navigationBarTitle("History")
		}
	}
}

struct RollsHistoryView_Previews: PreviewProvider {
	static var previews: some View {
		RollsHistoryView()
	}
}
