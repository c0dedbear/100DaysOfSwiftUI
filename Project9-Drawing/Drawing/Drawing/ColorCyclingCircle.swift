//
//  ColorCyclingCircle.swift
//  Drawing
//
//  Created by Михаил Медведев on 23.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
	var amount = 0.0
	var steps = 100

	var body: some View {
		ZStack {
			ForEach(0..<steps) { value in
				Circle()
					.inset(by: CGFloat(value))
					.strokeBorder(LinearGradient(gradient: Gradient(colors: [
					self.color(for: value, brightness: 1),
					self.color(for: value, brightness: 0.5)
				]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
			}
		}
	}

	func color(for value: Int, brightness: Double) -> Color {
		var targetHue = Double(value) / Double(self.steps) + self.amount

		if targetHue > 1 {
			targetHue -= 1
		}

		return Color(hue: targetHue, saturation: 1, brightness: brightness)
	}
}

struct ColorCyclingCircle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingCircle()
    }
}
