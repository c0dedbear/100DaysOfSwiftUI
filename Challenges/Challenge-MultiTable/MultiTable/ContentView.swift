//
//  ContentView.swift
//  MultiTable
//
//  Created by Mikhail Medvedev on 28.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct AnimatedGradientView: View {

	let colors: [Color]

	@State var startPoint = UnitPoint(x: 0, y: 0)
	@State var endPoint = UnitPoint(x: 0, y: 2)

	var body: some View {
		LinearGradient(gradient: Gradient(colors: colors), startPoint: self.startPoint, endPoint: self.endPoint).edgesIgnoringSafeArea(.all)
			.onAppear {
				withAnimation (Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)
				){
					self.startPoint = UnitPoint(x: 1, y: -1)
					self.endPoint = UnitPoint(x: 1, y: 1)
				}
		}
	}

	init(colors: [Color]) {
		self.colors = colors
	}
}

struct QuestionsView: View {
	var body: some View {
		ZStack {
			AnimatedGradientView(colors: [.orange, .yellow])
		}
	}
}

struct CardView: View
{
	let images: [String]
	let game: Game
	let angle: Double
	let number: Int
	let multiplier: Int

	@State var text = "?"

	var body: some View {
		ZStack {
			Text("\(number) x \(multiplier)").font(.system(size: 50, weight: .bold, design: .rounded)).offset(x: 0, y: 12)
			HStack {
				Image(self.images[number]).renderingMode(.original)
				Text(self.text).font(.largeTitle)
			}.offset(x: 0, y: -60)
		//	Text("☆☆☆☆☆").offset(x: 0, y: 80).font(.system(size: 20, weight: .light, design: .serif))
		}.frame(width: 200, height: 200)
			.background(RadialGradient(gradient: Gradient(colors: [.yellow,.orange]), center: .center, startRadius: 10, endRadius: 100))
			.cornerRadius(40)
			.foregroundColor(.purple)
			.clipped()
			.rotation3DEffect(.degrees(self.angle), axis: (x: 1, y: 0, z: 0))
			.shadow(radius: 10)
			.padding()
	}
}

struct Numbers: View {

	let images = ["cow", "chick", "chicken", "frog", "parrot", "penguin", "bear", "monkey", "narwhal", "panda", "elephant"]

	@State private var game = Game()
	@State private var angle = -10.0
	@State private var opacity = 1.0
	@State private var isGameStarted = false
	@State private var answers = [Int]()
	@State private var scaleAmount: CGFloat = 1.0
	@State private var text = "="
	@State private var isDisabled = false

	var body: some View {
		ZStack {
			AnimatedGradientView(colors: [.purple, .blue])
			if !isGameStarted {
				ScrollView(.vertical, showsIndicators: false) {
					VStack {
						Text("Help animals to multiply").font(.system(size: 25, weight: .bold, design: .rounded)).foregroundColor(.white).padding()
						ForEach(1..<game.numbers.count + 1) { number in
							VStack {
								Button(action: {
									//action
									print("tapped")
									self.cardTapped(on: number)
									withAnimation(.easeInOut(duration: 1)) {
										self.isGameStarted.toggle()
									}
								}) {
									ZStack {
										Text("\(number) x").font(.system(size: 50, weight: .bold, design: .rounded)).offset(x: 0, y: 12)
										HStack {
											Image(self.images[number]).renderingMode(.original)
											Text("?").font(.largeTitle)
										}.offset(x: 0, y: -60)
//										Text("☆☆☆☆☆").offset(x: 0, y: 80).font(.system(size: 20, weight: .light, design: .serif))
									}.frame(width: 200, height: 200)
										.background(RadialGradient(gradient: Gradient(colors: [.yellow,.orange]), center: .center, startRadius: 10, endRadius: 100))
										.foregroundColor(.purple)
										.cornerRadius(40)
										.clipped()
										.rotation3DEffect(.degrees(self.angle), axis: (x: 1, y: 0, z: 0))
										.shadow(radius: 10)

								}
							}.padding()

						}
					}
				}
			} else {
				//start of game
				ZStack {
					AnimatedGradientView(colors: [.orange, .yellow])
					VStack {
						CardView(images: images, game: game, angle: angle, number: game.currentNumber ?? 0, multiplier: game.currentMultiplier ?? 0).padding(.top, 40)
						Spacer()
						if answers.isEmpty == false {
							Text(self.text).font(.system(size: 50, weight: .bold, design: .rounded))
								.foregroundColor(.purple)
								.padding()
								Spacer()
								HStack {
									ForEach(0..<self.answers.count) { index in
										Button(action: {
											//answer tapped
											if self.game.checkAnswer(input: self.answers[index]) {
												print(self.answers[index])
												withAnimation(.default) {
													self.text = "Right ✅"
													self.isDisabled.toggle()
												}
												DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
													self.text = "="
													self.cardTapped(on: self.game.currentNumber ?? 0)
													self.isDisabled.toggle()
												}
											} else {
												self.text = "Try again"
												self.isDisabled.toggle()
												DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
													self.text = "="
													self.isDisabled.toggle()
												}
											}
										}) {
												Text("\(self.answers[index])").font(.system(size: 17)).bold().foregroundColor(.purple)
												.frame(minWidth: 20, minHeight: 20)
												.padding()
												.background(
													RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2)
											)

										}.padding()

									}
								}

						}
						Spacer()
						Button(action: {
							self.game.currentNumber = nil
							self.game.currentMultiplier = nil
							self.answers.removeAll()
							withAnimation(.easeInOut(duration: 1)) {
								self.isGameStarted.toggle()
							}
						}) {
							Text("Help other animals").padding().foregroundColor(.white)
						}
					}
				}.disabled(isDisabled)
			}

		}
	}

	func cardTapped(on number: Int) {
		game.setMultiplier()
		game.currentNumber = number
		var tempAnswers = [Int]()
		let answersDict = game.generateAnswers(number: number, multiplier: game.currentMultiplier ?? 0)
		for (_, values) in answersDict {
			tempAnswers += values
		}
		answers = tempAnswers
	}
}

struct ContentView: View {
	var body: some View {
		Numbers()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
