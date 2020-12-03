//
//  ContentView.swift
//  Brain-game
//
//  Created by Logan Reynolds on 11/23/20.
//

import SwiftUI

enum ColorOption{
    case red, orange, yellow, green , blue, purple
    
    var textColor: Color {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        }
    }
    
    var text: String {
        switch self {
        case .red:
            return "red"
        case .orange:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        }
    }
    
    init() {
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count))())]
    }
}

extension ColorOption: CaseIterable {
    mutating func getRandomColor(){
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count))())]
    }
}

struct ContentView: View {
    
    @State var upperColor = ColorOption()
    @State var bottomColor = ColorOption()
    @State var displayColor = ColorOption()
    
    @State var answer: Bool = false
    @State var score: Int = 0
    
    var body: some View {
        VStack{
            Text("Score: \(score)")
            Text("Does the meaning match the text color?")
                .padding()
            VStack{
                Text("meaning")
                    .font(.caption)
                Text("\(upperColor.text)")
                    .font(.largeTitle)
            }.padding()
            VStack{
                Text("\(displayColor.text)")
                    .font(.largeTitle)
                    .foregroundColor(bottomColor.textColor)
                Text("text color")
                    .font(.caption)
            }.padding()
            HStack{
                Group{
                    Button(action: {
                        answer = false
                        checkAnswer()
                    }) {
                        Text("No")
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .background(Color(.white))
                .padding()
                Group{
                    Button(action: {
                        answer = true
                        checkAnswer()
                    }) {
                        Text("Yes")
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .background(Color(.white))
                .padding()
            }.padding()
        }
    }
    
    func checkAnswer(){
        if upperColor == bottomColor && answer{
            score += 1
        } else if upperColor != bottomColor && !answer{
            score += 1
        }
        reloadColors()
    }
    
    func reloadColors(){
        upperColor = ColorOption()
        bottomColor = ColorOption()
        displayColor = ColorOption()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
