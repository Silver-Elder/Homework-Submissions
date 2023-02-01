//
//  ContentView.swift
//  Challenge–Rock, Paper, Scissors
//
//  Created by Sterling Jenkins on 1/16/23.
//

import SwiftUI



struct ContentView: View {
    @State private var computerInput = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var winAlertShowing = false
    @State private var resultsAlertShowing = false
    @State private var correct = ""
    @State private var round = 1
    @State private var score = 0
    
   var choices = ["🪨", "📃", "✂️"]
    var computerChoice: String {
        choices[computerInput]
    }
    
    var body: some View {
        VStack (spacing: 20){
            Spacer()
            Spacer()
            
            Text("Computer's Choice: \(computerChoice)")
            Text("User Should Win: \(shouldWin ? "👍" : "👎")")
            
            Spacer()
            
            Text("Which should you choose?")
                .font(.title)
            
            HStack (spacing: 30) {
                ForEach(choices, id: \.self) { choice in
                    Button(choice) {
                        didWin(usersChoice: choice)
                    }
                    .font(.system(size: 80))
                }
            }
            .alert(correct, isPresented: $winAlertShowing) {
                Button("Continue", action: newGame)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Final Results", isPresented: $resultsAlertShowing) {
                Button("Play Again?", action: resetGame)
            } message: {
                Text("Your score is \(score)/10")
            }
            
            
            
            ForEach(0..<3) { _ in
                Spacer()
            }
            
            Text("Round: \(round)")
            
            Spacer()
        }
        .padding()
    }
    
    func didWin(usersChoice: String) {
        
        if computerChoice == usersChoice {
            correct = "Nope, try again"
            winAlertShowing = true
            return
        }
        
        var victory: Bool = false
        
        switch usersChoice {
        case "🪨":
            computerChoice == "✂️" ?
                (victory = true) : (victory = false)
        case "📃":
            computerChoice == "🪨" ?
                (victory = true) : (victory = false)
        default:
            computerChoice == "📃" ?
                (victory = true) : (victory = false)
        }
        
        if victory == shouldWin {
            correct = "That's correct!"
            score += 1
        } else {
            correct = "Nope, try again"
        }
        
        winAlertShowing = true
    }
    
    func newGame() {
        if round < 10 {
            computerInput = Int.random(in: 0...2)
            shouldWin.toggle()
            round += 1
        } else {
            resultsAlertShowing = true
        }
    }
    
    func resetGame() {
        round = 0
        score = 0
        newGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
