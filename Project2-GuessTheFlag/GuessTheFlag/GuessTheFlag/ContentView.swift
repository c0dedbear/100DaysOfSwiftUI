//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mikhail Medvedev on 14.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var hintTitle = ""
    @State private var score = 0
    
    @State private var angle = 0.0
    @State private var scaleAmount: CGFloat = 1
    @State private var opacityAmount = 1.0
    @State private var textColor = Color.white
    @State private var blurAmount: CGFloat = 0.0
    
    @State private var enabled = true
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

	// MARK: ADD ACCESSIBILITY
	let labels = [
		"Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
		"France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
		"Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
		"Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
		"Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
		"Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
		"Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
		"Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
		"Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
		"UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
		"US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
	]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.green]), startPoint: .topTrailing, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                VStack{
                    Text("Tap the flag of...").foregroundColor(.white).padding(16)
                Text("\(countries[correctAnswer])").foregroundColor(textColor).bold().font(.largeTitle)
                    .scaleEffect(scaleAmount)
                    .animation(.easeOut)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        //flag was tapped
                        self.flagTapped(number)
                        
                    }) {
                        FlagImage(name: self.countries[number].lowercased())
						.accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                        
                    }.rotation3DEffect(
                    Angle(
                    degrees: self.correctAnswer == number ? self.angle : 0),
                    axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity(self.correctAnswer == number ? 1 : self.opacityAmount).animation(.easeIn)
                    .disabled(!self.enabled)
                }
                
                Text("Score: \(score)").foregroundColor(.white)
                Spacer()
            }.blur(radius: blurAmount).animation(.easeInOut)
                
                .alert(isPresented: $showingScore) {
                Alert(title: Text("Oops. Wrong answer"), message: Text("You tapped on flag of \(hintTitle)"), dismissButton: .default(Text("Continue")){
                    self.blurAmount = 0
                    self.askQuestion()
                    })
            }
        } //zstack
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation(.interpolatingSpring(stiffness: 10, damping: 5)) {
                self.angle = 360
            }
            self.opacityAmount = 0.25
            self.scaleAmount = 1.7
            self.textColor = .green
            self.enabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.textColor = .white
                self.opacityAmount = 1
                self.scaleAmount = 1
                self.angle = 0
                self.score += 1
                self.askQuestion()
                self.enabled = true
            }
            
        } else {
            blurAmount = 10
            if score > 0 {
                score -= 1
            } else {
                score = 0
            }
            hintTitle = countries[number]
            showingScore = true
        }
        
        
    }
    
    func askQuestion() {
        showingScore = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
