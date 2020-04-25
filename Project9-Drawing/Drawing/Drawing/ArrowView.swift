//
//  ArrowView.swift
//  Drawing
//
//  Created by Михаил Медведев on 25.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {

	var lineWidth: CGFloat = 1

	var animatableData: CGFloat {
		get { lineWidth }
		set { self.lineWidth = newValue }
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()

		path.move(to: CGPoint(x: 200, y: 100))
		path.addLine(to: CGPoint(x: 100, y: 300))
		path.addLine(to: CGPoint(x: 300, y: 300))
		path.addLine(to: CGPoint(x: 200, y: 100))

		path.addRect(CGRect(x: 150, y: 300, width: 100, height: 300))

		return path
	}

}

struct ArrowView: View {
	@State private var lineWidth: CGFloat = 1

	var body: some View {
		VStack {
			Arrow(lineWidth: lineWidth)
				.stroke(Color.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))

			Slider(value: $lineWidth, in: 1.0...20.0)
				.padding(.horizontal)
		}
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
