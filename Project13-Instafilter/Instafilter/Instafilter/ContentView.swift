//
//  ContentView.swift
//  Instafilter
//
//  Created by Mikhail Medvedev on 12.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import CoreImage

struct ContentView: View {
	@State private var inputImage: UIImage?
	@State private var processedImage: UIImage?
	@State private var image: Image?
	@State private var filterIntensity = 0.5
	@State private var filterScale = 0.5
	@State private var filterRadius = 0.5
	@State private var showingImagePicker = false
	@State private var showingFilterSheet = false
	@State private var showingAlert = false

	@State private var currentFilter: CIFilter = CIFilter.sepiaTone()
	private let context = CIContext()

	var body: some View {
		let intensity = Binding<Double> (get: { self.filterIntensity},
										 set: {
											self.filterIntensity = $0
											self.applyProcessing()
		})

		let radius = Binding<Double> (get: { self.filterRadius},
										 set: {
											self.filterRadius = $0
											self.applyProcessing()
		})

		let scale = Binding<Double> (get: { self.filterScale},
										 set: {
											self.filterScale = $0
											self.applyProcessing()
		})
		return NavigationView {
			VStack {
				ZStack {
					Rectangle()
						.fill(Color.secondary)

					if image != nil {
						image?
							.resizable()
							.scaledToFit()
					} else {
						Text("Tap to select a picture")
							.foregroundColor(.white)
							.font(.headline)
					}
				}
				.onTapGesture {
					self.showingImagePicker = true
				}

				HStack {
					Text("Intensity")
					Slider(value: intensity)
				}.padding(.vertical)

				HStack {
					Text("Radius")
					Slider(value: radius)
				}.padding(.vertical)

				HStack {
					Text("Scale")
					Slider(value: scale)
				}.padding(.vertical)

				HStack {
					Button(currentFilter.name.dropFirst(2)) {
						self.showingFilterSheet = true
					}

					Spacer()

					Button("Save") {
						guard let processedImage = self.processedImage else {
							self.showingAlert = true
							return
						}

						let imageSaver = ImageSaver()

						imageSaver.resultHandler = {
							print($0?.localizedDescription ?? "Success")
						}
						imageSaver.writeToPhotoAlbum(image: processedImage)

					}
				}
			}
			.padding([.horizontal, .bottom])
			.navigationBarTitle("Instafilter")
		}.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
			ImagePicker(image: self.$inputImage)
		}
		.actionSheet(isPresented: $showingFilterSheet) {
			ActionSheet(title: Text("Select a filter"), buttons: [
				.default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
				.default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
				.default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
				.default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
				.default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
				.default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
				.default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
				.cancel()
			])
		}
		.alert(isPresented: $showingAlert) {
			Alert(title: Text("Ooops"),
				  message: Text("There is no image to save"),
				  dismissButton: .cancel())
		}
	}

	func loadImage() {
		guard let inputImage = inputImage else { return }

		let beginImage = CIImage(image: inputImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}

	func setFilter(_ filter: CIFilter) {
		currentFilter = filter
		loadImage()
	}

	func applyProcessing() {
		let inputKeys = currentFilter.inputKeys

		if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
		if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
		if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

		guard let outputImage = currentFilter.outputImage else { return }

		if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage = UIImage(cgImage: cgimg)
			image = Image(uiImage: uiImage)
			processedImage = uiImage
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
