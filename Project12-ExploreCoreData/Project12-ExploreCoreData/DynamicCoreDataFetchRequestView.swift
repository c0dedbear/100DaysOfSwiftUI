//
//  DynamicCoreDataFetchRequestView.swift
//  Project12-ExploreCoreData
//
//  Created by Mikhail Medvedev on 09.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct DynamicCoreDataFetchRequestView: View {
	@Environment(\.managedObjectContext) var moc
	@State private var lastNameFilter = "A"

    var body: some View {
        VStack {
			// list of matching singers
			FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: SInger) in
				Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
			}

			Button("Add Examples") {
				let taylor = SInger(context: self.moc)
				taylor.firstName = "Taylor"
				taylor.lastName = "Swift"

				let ed = SInger(context: self.moc)
				ed.firstName = "Ed"
				ed.lastName = "Sheeran"

				let adele = SInger(context: self.moc)
				adele.firstName = "Adele"
				adele.lastName = "Adkins"

				try? self.moc.save()
			}

			Button("Show A") {
				self.lastNameFilter = "A"
			}

			Button("Show S") {
				self.lastNameFilter = "S"
			}
		}
    }
}

struct DynamicCoreDataFetchRequestView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicCoreDataFetchRequestView()
    }
}
