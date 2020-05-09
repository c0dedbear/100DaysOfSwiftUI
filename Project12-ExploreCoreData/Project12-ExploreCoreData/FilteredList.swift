//
//  FilteredList.swift
//  Project12-ExploreCoreData
//
//  Created by Mikhail Medvedev on 09.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
	enum Predicate: String {
		case beginsWith = "BEGINSWITH"
	}
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

	init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], predicate: Predicate, @ViewBuilder content: @escaping (T) -> Content) {
		fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
