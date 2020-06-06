//
//  ContentView.swift
//  WordScramble
//
//  Created by Mikhail Medvedev on 22.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {

	@State private var usedWords = [String]()
	@State private var rootWord = ""
	@State private var newWord = ""
	@State private var score = 0

	@State private var showError = false
	@State private var errorMessage = ""
	@State private var errorTitle = ""


	var body: some View {
		GeometryReader { globalGeo in
			NavigationView {
				VStack {
					TextField("Enter a word", text: self.$newWord, onCommit: self.addNewWord).autocapitalization(.none)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.padding()

					List(self.usedWords, id: \.self) { word in
						GeometryReader { insideGeo in
							HStack {
								Image(systemName: "\(word.count).circle")
								Text(word)
							}
							.transformEffect(.init(translationX: self.usedWords.count < 2 ? 1 : 1 * insideGeo.frame(in: .global).minY - globalGeo.size.height / 2, y: 1))
							.accessibilityElement(children: .ignore)
							.accessibility(label: Text("\(word), \(word.count) letters"))
						}
					}

					Text("Score: \(self.score)").font(.title).foregroundColor(.orange).bold()
				}
				.navigationBarTitle(self.rootWord)
				.navigationBarItems(leading: Button(action: self.startGame) {
					HStack {
						Image(systemName: "arrow.clockwise.circle")
						Text("New word")
					}
				})
					.onAppear(perform: self.startGame)
					.alert(isPresented: self.$showError) {
						Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
				}
			}
		}
	}

	func addNewWord() {
		let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

		guard !answer.isEmpty else { return }

		guard isOriginal(word: answer) else {
			wordError(title: "Word used already", message: "Be more original")
			return
		}

		guard isPossible(word: answer) else {
			wordError(title: "Word not possible", message: "You can't just make them up, you know!")
			return
		}

		guard isReal(word: answer) else {
			wordError(title: "Word not recognized", message: "That isn't a real word.")
			return
		}

		guard isAcceptable(word: answer) else {
			wordError(title: "Word not acceptable", message: "Word must have at least 3 letter and can't be just space")
			return
		}

		usedWords.insert(answer, at: 0)
		newWord = ""
		score += getScore(word: answer)
	}

	func startGame() -> Void {
		if let wordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
			if let words = try? String(contentsOf: wordsUrl) {
				let allWords = words.components(separatedBy: "\n")
				rootWord = allWords.randomElement() ?? "error"
				return
			}
		}

		fatalError("Could not read words from start.txt")
	}

	func isOriginal(word: String) -> Bool {
		!usedWords.contains(word)
	}

	func isPossible(word: String) -> Bool {
		var tempWord = rootWord

		for letter in word {
			if let position = tempWord.firstIndex(of: letter) {
				tempWord.remove(at: position)
			} else {
				return false
			}
		}

		return true
	}

	func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSRange(location: 0, length: word.utf16.count)
		let misspellRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

		return misspellRange.location == NSNotFound
	}

	func isAcceptable(word: String) -> Bool {
		if word.count <= 2 {
			return false
		}

		if word == rootWord {
			return false
		}

		return true
	}

	func getScore(word: String) -> Int {
		return word.count
	}

	func wordError(title: String, message: String) {
		errorTitle = title
		errorMessage = message
		showError = true
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
