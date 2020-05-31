//
//  Sequence+Extension.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import Foundation

extension Sequence {
	/// Numbers the elements in `self`, starting with the specified number.
	/// - Returns: An array of (Int, Element) pairs.
	func numbered(startingAt start: Int = 0) -> [(number: Int, element: Element)] {
		Array(zip(start..., self))
	}
}
