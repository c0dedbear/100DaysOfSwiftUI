//
//  ContentView.swift
//  Animations
//
//  Created by Mikhail Medvedev on 25.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scaleAmount: CGFloat = 1
    @State private var stepperAmount: CGFloat = 0.75
    @State private var rotationAmount = 0.0
    
    var body: some View {
        VStack {
            VStack {
                Text(" 1st method of Animation").font(.headline).padding(.bottom, 50)
                Button("tap me") {
                    //do nothing
                }
                .padding(40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue)
                        .scaleEffect(scaleAmount)
                        .opacity(Double(2 - scaleAmount))
                        .animation(
                            Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: false)
                    )
                    
                )
                    .onAppear {
                        self.scaleAmount = 2
                }
            }

            Spacer()
            VStack {
                Text("2nd method of animation (binding)").font(.headline).padding(.bottom, 50)
                Stepper("Animation Value", value: $stepperAmount.animation(.easeInOut(duration:2)), in: 1...10, step: 0.5).padding()
                Button("Step by") {
                    self.stepperAmount += 0.5
                }.padding(50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(stepperAmount)
                
            }
            Spacer()
            VStack {
                Text("3d method of animation (withAnimation)").font(.title).padding(.bottom, 50)
                Button("Step by") {
                    withAnimation(.interpolatingSpring(stiffness: 15, damping: 1.5)) {
                        self.rotationAmount += 360
                    }
                }.padding(50)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z: 0))
                
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
