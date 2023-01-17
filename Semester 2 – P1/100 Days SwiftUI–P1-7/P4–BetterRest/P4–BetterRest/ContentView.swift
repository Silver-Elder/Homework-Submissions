//
//  ContentView.swift
//  P4–BetterRest
//
//  Created by Sterling Jenkins on 1/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            DatePicker("Please enter a date", selection: $wakeUp)
            DatePicker("", selection: $wakeUp)
            
            DatePicker("", selection: $wakeUp)
                .labelsHidden()
            
            DatePicker("", selection: $wakeUp, displayedComponents: .date)
                .labelsHidden()
            
            DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
            
            DatePicker("", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
                //This "will allow all dates in the future, but none in the past – read it as 'from the current date up to anything'” (Hacking with Swift).
        }
        .padding()
    }
    
    //we can also use Swift dates with ranges. For example:

    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
