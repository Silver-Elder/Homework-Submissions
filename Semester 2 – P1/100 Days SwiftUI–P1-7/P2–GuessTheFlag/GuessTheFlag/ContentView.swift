//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sterling Jenkins on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
        // Note: "the shuffled() method automatically takes care of randomizing the array order for us" (Hacking with Swift).
    @State private var correctAnswer = Int.random(in: 0...2)
        // Note: "The Int.random(in:) method automatically picks a random number, which is perfect here – we’ll be using that to decide which country flag should be tapped" (Hacking with Swift).
    
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            // Note: "The renderingMode(.original) modifier tells SwiftUI to render the original image pixels rather than trying to recolor them as a button" (Hacking with Swift).
                    }
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is ???")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
