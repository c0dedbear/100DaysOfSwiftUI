//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Михаил Медведев on 01.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ProspectsView: View {
	enum FilterType {
		case none, contacted, uncontacted
	}

	@EnvironmentObject private var prospects: Prospects

	var filteredProspects: [Prospect] {
		switch filter {
		case .none:
			return prospects.people
		case .contacted:
			return prospects.people.filter { $0.isContacted }
		case .uncontacted:
			return prospects.people.filter { !$0.isContacted }
		}
	}

	let filter: FilterType

	var title: String {
		switch filter {
		case .none:
			return "Everyone"
		case .contacted:
			return "Contacted people"
		case .uncontacted:
			return "Uncontacted people"
		}
	}

    var body: some View {
      NavigationView {
			List {
				ForEach(filteredProspects) { prospect in
					VStack(alignment: .leading) {
						Text(prospect.name)
							.font(.headline)
						Text(prospect.emailAddress)
							.foregroundColor(.secondary)
					}
				}
			}
				.navigationBarTitle(title)
				.navigationBarItems(trailing: Button(action: {
					let prospect = Prospect()
					prospect.name = "Paul Hudson"
					prospect.emailAddress = "paul@hackingwithswift.com"
					self.prospects.people.append(prospect)
				}) {
					Image(systemName: "qrcode.viewfinder")
					Text("Scan")
				})
		}
    }
}

struct ProspectView_Previews: PreviewProvider {
    static var previews: some View {
		ProspectsView(filter: .contacted)
    }
}
