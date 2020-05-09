//
//  ContentView.swift
//  Project12-ExploreCoreData
//
//  Created by Mikhail Medvedev on 09.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

/*
1
Hashable is a bit like Codable: if we want to make a custom type conform to Hashable, then as long as everything it contains also conforms to Hashable then we don’t need to do any work. To demonstrate this, we could create a custom struct that conforms to Hashable rather than Identifiable, and use \.self to identify it:
*/
struct Student: Hashable {
    let name: String
}

struct ContentView: View {
//1 let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
	// sample predicates
//	 NSPredicate(format: "universe == %@", "Star Wars"))
//	As well as ==, we can also use comparisons such as < and > to filter our objects. For example this will return Defiant, Enterprise, and Executor:
//	NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
//	%@ is doing a lot of work behind the scenes, particularly when it comes to converting native Swift types to their Core Data equivalents. For example, we could use an IN predicate to check whether the universe is one of three options from an array, like this:
//	NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
//	We can also use predicates to examine part of a string, using operators such as BEGINSWITH and CONTAINS. For example, this will return all ships that start with a capital E:
//	NSPredicate(format: "name BEGINSWITH %@", "E"))
//	That predicate is case-sensitive; if you want to ignore case you need to modify it to this:
//	NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
//	CONTAINS[c] works similarly, except rather than starting with your substring it can be anywhere inside the attribute. Finally, you can flip predicates around using NOT, to get the inverse of their regular behavior. For example, this finds all ships that don’t start with an E:
	 @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>

    var body: some View {
//1       List(students, id: \.self) { student in
//            Text(student.name)
//        }
//		VStack {
//			List(movies, id: \.self) { movie in
//				Text(movie.wrappedTitle)
//			}
//			Button("Add") {
//				let movie = Movie(context: self.moc)
//				movie.title = "Harry Potter"
//			}
//
//			Button("Save") {
//				//			Conditional saving of NSManagedObjectContext
//				/* every managed object is given a hasChanges property, that is true when the object has unsaved changes. And, the entire context also contains a hasChanges property that checks whether any object owned by the context has changes.
//				*/
//				if self.moc.hasChanges {
//					do {
//						try self.moc.save()
//					}
//					catch {
//						print(error.localizedDescription)
//					}
//				}
//			}
//		}

//		VStack {
//            List(ships, id: \.self) { ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: self.moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: self.moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: self.moc)
//                ship3.name = "Millennium Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: self.moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? self.moc.save()
//            }
//        }
		DynamicCoreDataFetchRequestView()
//		CountriesCandiesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
