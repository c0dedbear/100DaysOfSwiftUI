//
//  CodableColor.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import UIKit

struct CodableColor {
    let uiColor: UIColor
}

extension CodableColor: Encodable {

	func encode(to encoder: Encoder) throws {
		let nsCoder = NSKeyedArchiver(requiringSecureCoding: true)
		uiColor.encode(with: nsCoder)
		var container = encoder.unkeyedContainer()
		try container.encode(nsCoder.encodedData)
	}
}

extension CodableColor: Decodable {

	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		let decodedData = try container.decode(Data.self)
		let nsCoder = try NSKeyedUnarchiver(forReadingFrom: decodedData)
		guard let color = UIColor(coder: nsCoder) else {
			struct UnexpectedlyFoundNilError: Error {}
			throw UnexpectedlyFoundNilError()
		}
		self.uiColor = color
	}
}

extension UIColor {
    func codable() -> CodableColor {
        return CodableColor(uiColor: self)
    }
}
