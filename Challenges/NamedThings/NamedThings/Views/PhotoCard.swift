//
//  PhotoCardView.swift
//  NamedThings
//
//  Created by Mikhail Medvedev on 16.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct PhotoCard: View {

	private enum ActiveSheet {
		case fullImage
		case imagePicker
		case map
	}

	@ObservedObject var cardManager: CardManager
	@State var card: Card

	private let imageSaver = ImageSaver()
	private let imagePlaceholder = UIImage(named: "placeholder")!

	@State private var activeSheet = ActiveSheet.imagePicker
	@State private var isSheetShown = false
	@State var showAlert = false

	private var color: Color { Color(self.card.color.uiColor) }

	@State private var uiImage: UIImage?
	@Binding var textFieldEnabled: Bool

	var body: some View {
		let text = Binding<String>(
			get: { (self.card.title ?? "Person Name") },
			set: {
				self.card.title = $0
				self.saveChanges()
		}
		)
		return ZStack(alignment: .leading) {
			Rectangle()
				.fill(self.color)
				.frame(height: 230)
				.cornerRadius(10)
				.padding(32)
				if textFieldEnabled {
					HStack {
						Spacer()
						Button(action: { self.showAlert = true }) {
							Image(systemName: "trash")
								.font(.subheadline)
								.foregroundColor(.white)
						}.padding(.trailing, 40)
							.padding(.bottom, 180)
					}
				}
				HStack {
					Image(uiImage: uiImage ?? imagePlaceholder)
						.renderingMode(.original)
						.resizable()
						.frame(width: 110, height: 110)
						.clipShape(Circle())
						.padding(12)
						.onTapGesture(count: 2) {
							self.activeSheet = .imagePicker
							self.isSheetShown = true
					}
					.onLongPressGesture {
						if self.uiImage != nil {
							self.activeSheet = .fullImage
							self.isSheetShown = true
						}
					}
					if textFieldEnabled {
						TextField("Person name", text: text, onEditingChanged: { editing in
							if editing {
								self.card.title = ""
							}
						}, onCommit: { self.textFieldEnabled = false })
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.foregroundColor(.black)
							.padding(.trailing, 24)
						Spacer()
					} else {
						Text(card.title!.isEmpty ? "Person name" : card.title!)
							.font(.headline)
							.bold()
							.foregroundColor(.white)
							.padding(.trailing, 32)
							.onTapGesture {
								self.textFieldEnabled = true
						}.animation(.default)
					}
				}
			Spacer()
			HStack(alignment: .center) {
				Image(systemName: "mappin")
				Button(self.card.location?.title ?? "Set location") {
					self.activeSheet = .map
					self.isSheetShown = true
				}
			}
			.padding(.leading, 64)
			.padding(.top, 180)
			.foregroundColor(.white)
		}
		.alert(isPresented: $showAlert) {
			Alert(title: Text("Delete card?"),
				  primaryButton: .destructive(Text("Delete"), action: { self.delete() }),
				  secondaryButton: .cancel())
		}
		.sheet(isPresented: $isSheetShown ) {
			if self.activeSheet == .imagePicker {
				ImagePicker(image: self.$uiImage, completion: { self.saveImage() })
			} else if self.activeSheet == .fullImage {
				ZStack {
					Image(uiImage: self.uiImage!)
						.resizable()
						.renderingMode(.original)
						.aspectRatio(contentMode: .fit)
				}.edgesIgnoringSafeArea(.all)
			} else {
				MapWrapView(selectedPlace: self.card.location, fillLocation: { location in
					self.card.location = location
					self.saveChanges()
				})
			}
		}
		.onAppear() { self.loadImage() }
	}

	private func saveChanges() {
		guard self.cardManager.storage.isEmpty == false else { return }
		let lastIndex = self.cardManager.storage.count - 1
		self.cardManager.storage[lastIndex] = self.card
		self.cardManager.saveCards()
	}

	private func delete() {
		self.textFieldEnabled = false
		self.imageSaver.removeFilesAt(filepaths: [self.cardManager.storage.last?.id.uuidString ?? "unknown"]) {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
				self.cardManager.removeLast()
			}
		}
	}

	private func saveImage() {
		guard self.card.imageName == nil else { return }
		guard let image = self.uiImage,
			self.uiImage !== self.imagePlaceholder
			else { return }
		self.imageSaver.storeImage(image, filename: self.card.id.uuidString) {
			print("saved", self.card.id.uuidString)
		}

	}

	private func loadImage() {
		if let imageName = self.card.imageName,
			let localImage = UIImage(named: imageName) {
			self.uiImage = localImage
		} else {
			self.imageSaver.loadImage(filename: self.card.id.uuidString) { image in
				if let image = image {
					self.uiImage = image
					print("loaded", self.card.id.uuidString)
				} else {
					self.uiImage = self.imagePlaceholder
				}
			}
		}
	}
}


struct PhotoCardView_Previews: PreviewProvider {
	@State static var enabled = false

	static var previews: some View {
		PhotoCard(cardManager: CardManager(),
				  card: Card(id: UUID(), color: .init(uiColor: .blue), imageName: nil, title: "New Person"), textFieldEnabled: $enabled)
	}
}
