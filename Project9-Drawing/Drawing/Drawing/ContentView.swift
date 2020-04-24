//
//  ContentView.swift
//  Drawing
//
//  Created by Михаил Медведев on 22.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()

		path.move(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

		return path
	}
}
// Дуга
struct Arc: InsettableShape {
	var startAngle: Angle
	var endAngle: Angle
	var clockwise: Bool
	var insetAmount: CGFloat = 0

	// for strokeBorderAplying

	func path(in rect: CGRect) -> Path {
		let rotationAdjustment = Angle.degrees(90)
		let modifiedStart = startAngle - rotationAdjustment
		let modifiedEnd = endAngle - rotationAdjustment

		var path = Path()
		path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

		return path
	}
    // InsettableShape protocol
	func inset(by amount: CGFloat) -> some InsettableShape {
		var arc = self
		arc.insetAmount += amount
		return arc
	}
}

struct ContentView: View {
	@State private var colorCycle = 0.0

	var body: some View {
        // Rectangle with path
//		Path { path in
//			path.move(to: CGPoint(x: 200, y: 100))
//			path.addLine(to: CGPoint(x: 100, y: 300))
//			path.addLine(to: CGPoint(x: 300, y: 300))
//			path.addLine(to: CGPoint(x: 200, y: 100))
//		}.stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))

		// Rectangle with shape
//		Triangle()
//			.stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
//			.frame(width: 300, height: 300)

		// Arc Shape
//		Arc(startAngle: .degrees(0), endAngle: .degrees(300), clockwise: true)
//			.strokeBorder(Color.blue, lineWidth: 10)
//			.frame(width: 300, height: 300)

//		FlowerView()

//		VStack {
//			ColorCyclingCircle(amount: self.colorCycle)
//				.frame(width: 300, height: 300)
//				// boost performance with Metal
//				.drawingGroup()
//
//			Slider(value: $colorCycle)
//		}

//		ColorBlendingView()

//		AnimatableDataView()
//		CheckerboardView()

		SpirographView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
