//
//  SizeClasses with AnyView .swift
//  Project11-Bookworm
//
//  Created by Mikhail Medvedev on 05.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct SizeClassesView: View {
	var body: some View {
		@Environment(\.horizontalSizeClass) var sizeClass

		var body: some View {
			if sizeClass == .compact {
				return AnyView(VStack {
					Text("Active size class:")
					Text("COMPACT")
				}
				.font(.largeTitle))
			} else {
				return AnyView(HStack {
					Text("Active size class:")
					Text("REGULAR")
				}
				.font(.largeTitle))
			}
		}
	}
}

struct SizeClassesViewPreviews: PreviewProvider {
	static var previews: some View {
		SizeClassesView()
	}
}
