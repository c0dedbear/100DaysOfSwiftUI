//
//  ContentView.swift
//  AdvancedAnimation
//
//  Created by Mikhail Medvedev on 26.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct AnimatedGradientView1: View {
    
    @State var gradient = [Color.red, Color.purple]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
            .frame(width: 300, height: 250)
            .onTapGesture {
                withAnimation (Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)
                ){
                    self.startPoint = UnitPoint(x: 1, y: -1)
                    self.endPoint = UnitPoint(x: 1, y: 1)
                }
        }
    }
}

struct DraggableView: View {
    @State private var dragAmount = CGSize.zero
    var body: some View {
        AnimatedGradientView1()
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged() { self.dragAmount = $0.translation }
                    .onEnded() { _ in
                        withAnimation(.spring()) {self.dragAmount = .zero }
                }
        )
        
    }
}
struct AnimatableText: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }.gesture(
            DragGesture()
                .onChanged() {self.dragAmount = $0.translation}
                .onEnded() { pos in
                    self.dragAmount = pos.predictedEndTranslation
                    self.enabled.toggle()
            }
        )
    }
}
//MARK: -
struct HideAnimation: View {
    let buttonText: String
    let transitionEffect: AnyTransition?
    @State private var isShowed = false
    var body: some View {
        VStack {
            Button("\(buttonText)") {
                withAnimation(.default) {
                    self.isShowed.toggle()
                }
            }
            
            if isShowed {
                RoundedRectangle(cornerRadius: 0, style: .circular)
                    .fill(Color.blue)
                    .frame(width: 100, height: 100, alignment: .center)
                    .transition(transitionEffect ??
                        .asymmetric(insertion: .move(edge: .bottom),
                                    removal: .move(edge: .bottom)
                        )
                )
            }
        }
    }
}

//MARK: - Transition Modifier
struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
//MARK: - ContentView
struct ContentView: View {
    var body: some View {
        VStack {
            DraggableView()
            Spacer()
            AnimatableText()
            Spacer()
            HideAnimation(buttonText: "Tap for pivot",transitionEffect: .pivot)
            Spacer()
            HideAnimation(buttonText: "Tap for sliding",transitionEffect: nil)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
