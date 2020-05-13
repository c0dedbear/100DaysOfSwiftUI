//
//  ContentView.swift
//  Instafilter
//
//  Created by Mikhail Medvedev on 12.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView: View {
	@State private var image: Image?
	@State private var inputImage: UIImage?
	@State private var showingImagePicker = false

	var body: some View {
		VStack {
			image?
				.resizable()
				.scaledToFit()
			
			Button("Select Image") {
				self.showingImagePicker = true
			}
		}
		.sheet(isPresented: $showingImagePicker, onDismiss: self.loadImage) {
			ImagePicker(image: self.$inputImage)
	}
}
	func loadImage() {
			guard let inputImage = inputImage else { return }
			image = Image(uiImage: inputImage)
			saveImage(inputImage)
		}

	func saveImage(_ image: UIImage) {
		let imageSaver = ImageSaver()
		imageSaver.writeToPhotoAlbum(image: image)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
