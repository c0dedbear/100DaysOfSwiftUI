//
//  Movie+CoreDataProperties.swift
//  Project12-ExploreCoreData
//
//  Created by Mikhail Medvedev on 09.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16

	/*
	you might want to consider adding computed properties that help us access the optional values safely, while also letting us store your nil coalescing code all in one place. For example, adding this as a property on Movie ensures that we always have a valid title string to work with:
	*/

	public var wrappedTitle: String {
		title ?? "Unknown Title"
	}

}
