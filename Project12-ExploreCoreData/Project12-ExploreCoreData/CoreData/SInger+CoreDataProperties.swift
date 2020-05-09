//
//  SInger+CoreDataProperties.swift
//  Project12-ExploreCoreData
//
//  Created by Mikhail Medvedev on 09.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//
//

import Foundation
import CoreData


extension SInger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SInger> {
        return NSFetchRequest<SInger>(entityName: "SInger")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

	var wrappedFirstName: String {
		firstName ?? "Unknown"
	}

	var wrappedLastName: String {
		lastName ?? "Unknown"
	}
}
