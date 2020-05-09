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

    var body: some View {
//1       List(students, id: \.self) { student in
//            Text(student.name)
//        }
		VStack {
			List(movies, id: \.self) { movie in
				Text(movie.wrappedTitle)
			}
			Button("Add") {
				let movie = Movie(context: self.moc)
				movie.title = "Harry Potter"
			}

			Button("Save") {
				//			Conditional saving of NSManagedObjectContext
				/* every managed object is given a hasChanges property, that is true when the object has unsaved changes. And, the entire context also contains a hasChanges property that checks whether any object owned by the context has changes.
				*/
				if self.moc.hasChanges {
					do {
						try self.moc.save()
					}
					catch {
						print(error.localizedDescription)
					}
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
