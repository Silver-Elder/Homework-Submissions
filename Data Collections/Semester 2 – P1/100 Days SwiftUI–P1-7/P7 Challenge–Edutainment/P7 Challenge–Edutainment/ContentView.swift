//
//  ContentView.swift
//  P7 Challenge–Edutainment
//
//  Created by Sterling Jenkins on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    @State private var lowestTimesTable: Int = 0
    @State private var highestTimesTable: Int = 0
    @State private var questionCount: Int = 0
    
    @State private var timesNumber: Int = 0
    
    @State private var questionNumber = Int.random(in: 1...12)
    
    @State private var answer: String = ""
    
    @State private var answerCorrect: String = ""
    @State private var questionsAnswered: Int = 0
    @State private var answersRight: Int = 0
    
    @State private var scoreAlertShowing = false
    
    var body: some View {
        Form {
            Section {
                Picker("", selection: $lowestTimesTable) {
                    ForEach(1..<13) {
                        Text("\($0)")
                    }
                    
                }
                
                Picker("Through..", selection: $highestTimesTable) {
                    ForEach(1..<13) {
                        Text("\($0)")
                    }
                    
                }
            } header: {
                Text("Which times tables do you want to practice?")
            }
            
            Section {
                Picker("", selection: $questionCount) {
                    ForEach(1..<21) {
                        Text("\($0)")
                    }
                }
            } header: {
                Text("How many questions do you want to do?")
            }
            
            Section {
                Text(" \(timesNumber + 1) x \(questionNumber) = ???")
                TextField("Your answer:", text: $answer)
                Button("Submit"){
                    if "\((timesNumber + 1) * questionNumber)" == answer {
                        answerCorrect = "Correct! "
                        answersRight += 1
                    } else {
                        answerCorrect = "Not Quite. "
                    }
                    questionsAnswered += 1
                    timesNumber = timesTableNumberSelector()
                    questionNumber = Int.random(in: 1...12)
                    answer = ""
                    if questionsAnswered >= (questionCount + 1) {
                        scoreAlertShowing = true
                    }
                    
                }
            } header: {
                Text(answerCorrect + "Question: \(questionCount + 1)")
            }
            .alert("FinalResults", isPresented: $scoreAlertShowing) {
                Button("Play Again?") {
                    reset()
                }
            } message: {
                Text("Your final score was \(answersRight)/\(questionCount + 1)")
            }

        }
        .padding()
    }
    
    func timesTableNumberSelector()  -> Int {
        if lowestTimesTable < highestTimesTable {
           return Int.random(in: (lowestTimesTable + 1)...(highestTimesTable + 1))
        } else if lowestTimesTable > highestTimesTable {
            return  Int.random(in: (highestTimesTable + 1)...(lowestTimesTable + 1))
        }
            
        return (lowestTimesTable)
    }
    
    func reset() {
        lowestTimesTable = 0
        highestTimesTable = 0
        questionCount = 0
        
        questionsAnswered = 0
        answersRight = 0
        answer = ""
        
        timesNumber = 0
        questionNumber = Int.random(in: 1...12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
