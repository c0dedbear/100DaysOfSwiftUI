//
//  DiceView.swift
//  RollDice
//
//  Created by Михаил Медведев on 06.06.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

enum DiceValue: Int, CaseIterable {
	case one = 1, two, three, four, five, six
}

struct DiceView: View {
	@Binding var value: DiceValue
	private let radius: CGFloat = 10

	var body: some View {
		ZStack(alignment: .topLeading) {
			RoundedRectangle(cornerRadius: 20)
				.frame(width: 100, height: 100)
			RoundedRectangle(cornerRadius: 20)
						.strokeBorder(Color.white, lineWidth: 1)
						.frame(width: 90, height: 90)
						.opacity(0.35)
						.offset(x: 5, y: 5)
			ForEach(0..<value.rawValue, id: \.self) { index in
				Circle()
					.frame(width: self.radius, height: self.radius)
					.padding(self.makePadding())
					.foregroundColor(Color.white)
					.offset(self.calculatedCircleOffset(index: index))
			}
		}
	}


	func makePadding() -> CGFloat {
		switch value {
		case .one: return 0
		case .two, .six: return 20
		case .three, .four: return 24
		case .five: return .pi * 6.5
		}
	}

	func calculatedCircleOffset(index: Int) -> CGSize {
		switch value {
		case .one: return CGSize(width: 45, height: 45)
		case .two: return CGSize(width: radius * 5 * CGFloat(index), height: radius * 5 * CGFloat(index))
		case .three: return CGSize(width: radius * CGFloat(index * 2), height: radius * CGFloat(index * 2))
		case .four: return CGSize(
			width: (index == 1 || index == 3) ? radius * 2 * CGFloat(index) - radius * 2 : radius * CGFloat(index * 2),
			height: (index == 1 || index == 3) ? radius * CGFloat(value.rawValue) : 0
			)
		case .five: return CGSize(
			width: index == 4 ? radius * 2 * 1.2 : (index == 1 || index == 3) ? (radius * 2 * CGFloat(index) - radius * 2) * 1.2 : (radius * CGFloat(index * 2)) * 1.2,
			height: index == 4 ? radius * 2 + radius / 2 : (index == 1 || index == 3) ? radius * CGFloat(value.rawValue) : 0
			)
		case .six: return CGSize(
			width: index > 2 ? 0 : radius * CGFloat(value.rawValue) - radius,
			height: index > 2 ? radius * CGFloat(index * 2) - radius * 6 + CGFloat(value.rawValue / 2) : radius * CGFloat(index * 2) + CGFloat(value.rawValue / 2)
		)
		}
	}
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
		DiceView(value: .constant(.five))
    }
}
