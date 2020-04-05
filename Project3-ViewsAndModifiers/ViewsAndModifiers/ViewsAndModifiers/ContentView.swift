//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mikhail Medvedev on 16.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int,Int) -> Content
    
    var body: some View {
        VStack{
            ForEach(0 ..< rows) { row in
                HStack{
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

//custom modifier
struct BigBlueTitle: ViewModifier {
    
    func body(content: Content) -> some View {
            content
                .font(.system(size: 50, weight: .heavy, design: .default))
                .foregroundColor(Color.blue)
    }
}
//extension for custom modifier for use it like built in modifier (.largeBlueTitled)
extension View {
    func largeBlueTitled() -> some View {
        self.modifier(BigBlueTitle())
    }
}

struct ContentView: View {
     @State private var useRedText = false
    
    var body: some View {
     VStack {
          Text("Gryffindor")
              .font(.largeTitle)
            .blur(radius: 10)
          Text("Hufflepuff")
          Text("Ravenclaw")
        Text("Slytherin").largeBlueTitled()
        
            VStack {
                GridStack(rows: 10, columns: 10) { row, column in
                    Button(action: {
                        
                    }) {
                         Image(systemName: "circle")
                    }
                   
                }
            }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
