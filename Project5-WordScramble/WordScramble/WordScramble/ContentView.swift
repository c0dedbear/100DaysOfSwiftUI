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
        //        if let fileUrl = Bundle.main.url(forResource: "", withExtension: "txt") {
        //            if let file = try? String(contentsOf: fileUrl) {
        //
        //            }
        //        }
        NavigationView {
            VStack {
                TextField("Enter a word", text: $newWord, onCommit: addNewWord).autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Score: \(score)").font(.title).foregroundColor(.orange).bold()
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button(action: startGame) {
                HStack {
                Image(systemName: "arrow.clockwise.circle")
                Text("New word")
                }
            })
                .onAppear(perform: startGame)
                .alert(isPresented: $showError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
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
