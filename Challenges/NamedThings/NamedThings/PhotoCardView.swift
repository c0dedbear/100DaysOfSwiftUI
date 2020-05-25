//
//  PhotoCardView.swift
//  NamedThings
//
//  Created by Mikhail Medvedev on 16.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct PhotoCardView: View {
	@State private var degrees = 25.0

	var body: some View {
		VStack {
       RoundedRectangle(cornerRadius: 10)
		.fill(Color.yellow).opacity(0.7)
		.overlay(Text("45° Back on Y Axis")
		.font(.largeTitle).bold())
		.rotation3DEffect(Angle(degrees: 45), axis: (x: 0.0, y: 1.0, z: 0.0))

		RoundedRectangle(cornerRadius: 10)
			.fill(Color.yellow)
			.overlay(Text("-45° Forward on Y Axis")
			.font(.largeTitle).bold())
			.rotation3DEffect(Angle(degrees: -45),axis: (x: 0.0, y: 1.0, z: 0.0))

		RoundedRectangle(cornerRadius: 10)
			.fill(Color.yellow)
			.overlay(Text("Move slider to adjust rotation")
			.font(.largeTitle).bold())
			.rotation3DEffect(Angle(degrees: degrees),                      axis: (x: 0.0, y: 1.0, z: 0.0))

		Slider(value: $degrees, in: -180...180, step: 1)
			.padding()
		}
	}
}

struct PhotoCardView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCardView()
    }
}
