//
//  BordersWithImage.swift
//  Drawing
//
//  Created by Михаил Медведев on 23.04.2020.
//  Copyright © 2020 Михаил Медведев. All rights reserved.
//

import SwiftUI

struct BordersWithImage: View {
    var body: some View {
		VStack {
		Text("Hello World")
			.frame(width: 300, height: 300)
//			.background(Image("start"))
//			.border(ImagePaint(image: Image("start"), scale: 0.2), width: 30)
		    .border(ImagePaint(image: Image("start"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)

		Capsule()
			.strokeBorder(ImagePaint(image: Image("start"), scale: 0.1), lineWidth: 20)
			.frame(width: 300, height: 200)
		}
    }
}

struct BordersWithImage_Previews: PreviewProvider {
    static var previews: some View {
        BordersWithImage()
    }
}
