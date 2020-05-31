//
//  PhotoCards.swift
//  NamedThings
//
//  Created by Михаил Медведев on 30.05.2020.
//  Copyright © 2020 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

enum DragState {
	case inactive
	case dragging(translation: CGSize)

	var translation: CGSize {
		switch self {
		case .inactive:
			return .zero
		case .dragging(let translation):
			return translation
		}
	}

	var isActive: Bool {
		switch self {
		case .inactive:
			return false
		case .dragging:
			return true
		}
	}

	var state: DragState {
		switch self {
		case .inactive:
			return .inactive
		case .dragging(let translation):
			return .dragging(translation: translation)
		}
	}
}

struct PhotoCards: View {
	@ObservedObject var cardManager = CardManager()
	@GestureState var dragState = DragState.inactive

	@State private var isTextFieldEnabled = false
	@State private var namePhotoAlertIsShown = false
	@State private var attempts: Int = 0
	var body: some View {
		ZStack {
			ZStack {
				RadialGradient(gradient: Gradient(colors: [.white, .yellow]),
							   center: UnitPoint.center, startRadius: 10, endRadius: 420)
					.edgesIgnoringSafeArea(.vertical)
			}
			.onTapGesture {
				self.isTextFieldEnabled = false
			}
			ZStack {
				ForEach(cardManager.lastThreeCards.numbered(), id: \.element.id) { index, card in
					PhotoCard(cardManager: self.cardManager,
							  card: card,
							  showAlert: self.namePhotoAlertIsShown,
							  textFieldEnabled: self.$isTextFieldEnabled)
						.onDisappear() {
							self.cardManager.saveCards()
					}
						.if(self.isLast(index)) { photoCard in
							photoCard
								.shadow(radius: self.dragState.isActive ? 8 : 4)
								.rotationEffect(Angle(degrees: Double(self.dragState.translation.width / 10)))
								.offset(x: self.dragState.translation.width,
										y: self.dragState.translation.height)
								.gesture(DragGesture().updating(self.$dragState) { (value, state, transaction) in
									state = .dragging(translation: value.translation)
								})
								.animation(.spring())
								.modifier(Shake(animatableData: CGFloat(self.attempts)))
								.transition(.slide)
					}
					.if(self.isMiddle(index)) { photoCard in
						photoCard
							.shadow(radius: self.dragState.isActive ? 8 : 0)
							.rotation3DEffect(Angle(degrees: 0), axis: (x: 10.0, y: 10.0, z: 10.0))
							.padding(self.dragState.isActive ?  16 : 32)
							.padding(.bottom, self.dragState.isActive ? 0 : 32)
							.animation(.spring())
					}
					.if(self.isFirst(index)) { photoCard in
						photoCard
							.shadow(radius: self.dragState.isActive ? 8 : 0)
							.rotation3DEffect(Angle(degrees: 0), axis: (x: 10.0, y: 10.0, z: 10.0))
							.padding(self.dragState.isActive ?  32 : 64)
							.padding(.bottom, self.dragState.isActive ? 32 : 64)
							.animation(.spring())
					}
				}
			}
			AddButton(action: {
				self.isTextFieldEnabled = false
				self.addNewCard()
			})
		}
	}
}

private extension PhotoCards
{
	func addNewCard() {
		if self.cardManager.storage.last?.title != "Person name" {
			self.cardManager.storage.append(Card(id: UUID(),
												 color: UIColor.init(red: CGFloat.random(in: 0...1),
																	 green: CGFloat.random(in: 0...1),
																	 blue: CGFloat.random(in: 0...1),
																	 alpha: 1).codable(),
												 imageName: nil,
												 title: "Person name"))
		} else {
			withAnimation(.default) {
				self.attempts += 1
				self.isTextFieldEnabled = true
			}
		}
	}

	func isFirst(_ index: Int) -> Bool {
		if self.cardManager.lastThreeCards.count > 2 { return index == 0 }
		return false
	}

	func isMiddle(_ index: Int) -> Bool {
		if self.cardManager.lastThreeCards.count > 2 {
			return index == 1
		}
		else if self.cardManager.lastThreeCards.count == 2 && index == 0 {
			return true
		}
		return false
	}

	func isLast(_ index: Int) -> Bool {
		if self.cardManager.lastThreeCards.count == 1 { return true }
		else if self.cardManager.lastThreeCards.count == 2 && index == 1 { return true }
		return index == 2
	}
}

struct PhotoCards_Previews: PreviewProvider {
	static var previews: some View {
		PhotoCards()
	}
}
