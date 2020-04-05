//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mikhail Medvedev on 18.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @State private var game = Game()
    @State private var roundMessage = "" {
        didSet {
            if game.round > 10 && !endGame {
                //game over
                endGame = true
            } else {
                //next round
                if !endGame {
                    endRound.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.endRound = false
                    }
                }
            }
        }
    }
    
    @State private var endRound = false
    @State private var endGame = false
    
    var body: some View {
        NavigationView {
            if !endRound && !endGame {
                VStack {
                    Text("To score point in this round you need to \(game.winCondition ? "Win":"Lose")")
                        
                        .padding()
                        .foregroundColor(.gray)
                    Spacer()
                    HStack {
                        Text("I moves")
                        Image(game.randomMove.rawValue)
                    }
                    
                    
                    Spacer()
                    VStack {
                        Text("and You?")
                        HStack(spacing: 44) {
                            ForEach(0 ..< Move.allCases.count) { currentCase in
                                Button(action: {
                                    //player tapped button
                                    let result = self.game.playerMoves(playerMove: Move.allCases[currentCase])
                                    self.roundMessage = self.game.show(result: result)
                                }) {
                                    Image(Move.allCases[currentCase].rawValue)
                                        .renderingMode(.original)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                    
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
                .navigationBarItems(
                    leading:
                    Text("Score: \(game.score)").bold()
                    , trailing:
                    Text("Round: \(game.round)/10").bold()
                )
                
            } else {
                ZStack {
                    if endGame {
                        LinearGradient(gradient: Gradient(colors: [.blue, .red, .green]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                            .alert(isPresented: $endGame ) {
                                Alert(title: Text("It's over!"), message: Text("Your final score is \(game.score) points"), dismissButton: .default(Text("New Game")){
                                    self.game.restart()
                                    })
                        }
                    } else {
                        Text(roundMessage).font(.title).padding()
                        
                    }
                }.animation(.easeInOut)
                    .navigationBarItems(leading:Text(""), trailing: Text(""))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
