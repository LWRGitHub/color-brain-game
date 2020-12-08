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
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
}

extension ColorOption: CaseIterable {
    mutating func getRandomColor(){
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
}



struct ContentView: View {
    
    @State var isShowingScoreView = false
    @State var upperColor = ColorOption()
    @State var bottomColor = ColorOption()
    @State var displayColor = ColorOption()
    
    
    @State var answer: Bool = false
    @State var score: Int = 0
    @State var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(
                    destination: ScoreView(score: score), isActive: $isShowingScoreView){
                    EmptyView()
                }
            
            HStack{
                Text("Timer: \(timeRemaining)sec.")
                    .padding()
                    .onReceive(timer) { _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        } else {
                            // time runs out
                            self.isShowingScoreView = true
                        }
                    }
                Text("Score: \(score)")
                    .padding()
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                            .foregroundColor(.red)
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
                            .foregroundColor(.red)
                    }
                }
                .background(Color(.white))
                .padding()
            }.padding()
        }
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
