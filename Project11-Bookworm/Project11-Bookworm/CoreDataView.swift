//
//  CoreDataView.swift
//  Project11-Bookworm
//
//  Created by Mikhail Medvedev on 05.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct CoreDataView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

	var body: some View {
		VStack {
			List {
				ForEach(students, id: \.id) { student in
					Text(student.name ?? "Unknown")
				}
			}
			
			Button("Add") {
				let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
				let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
				
				let chosenFirstName = firstNames.randomElement()!
				let chosenLastName = lastNames.randomElement()!
				
				let student = Student(context: self.moc)
				student.id = UUID()
				student.name = "\(chosenFirstName) \(chosenLastName)"
				
				try? self.moc.save()
			}
		}
	}
}

struct CoreDataView_Previews: PreviewProvider {
	static var previews: some View {
		CoreDataView()
	}
}
