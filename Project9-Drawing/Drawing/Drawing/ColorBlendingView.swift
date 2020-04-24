//
//  ColorBlendingView.swift
//  Drawing
//
//  Created by Михаил Медведев on 24.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct ColorBlendingView: View {
	@State private var amount: CGFloat = 0.0

	var body: some View {
		VStack {
			ZStack {
				// If you want to see the full effect of blending red, green, and blue, you should use custom colors like these three:
//				    .fill(Color(red: 1, green: 0, blue: 0))
//					.fill(Color(red: 0, green: 1, blue: 0))
//					.fill(Color(red: 0, green: 0, blue: 1))
				Circle()
					.fill(Color.red)
					.frame(width: 200 * amount)
					.offset(x: -50, y: -80)
					.blendMode(.screen)

				Circle()
					.fill(Color.green)
					.frame(width: 200 * amount)
					.offset(x: 50, y: -80)
					.blendMode(.screen)

				Circle()
					.fill(Color.blue)
					.frame(width: 200 * amount)
					.blendMode(.screen)
			}
			.frame(width: 300, height: 300)

			Image("start")
				.resizable()
				.scaledToFit()
				.frame(width: 200, height: 200)
				.saturation(Double(amount))
				.blur(radius: (1 - amount) * 20)

			Slider(value: $amount)
				.padding()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.black)
		.edgesIgnoringSafeArea(.all)
	}

}

struct ColorBlendingView_Previews: PreviewProvider {
	static var previews: some View {
		ColorBlendingView()
	}
}
