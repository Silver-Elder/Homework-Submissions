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
            
            /* How can we format dates and times?
             
             "...we have two options.

             "First is to rely on the format parameter that has worked so well for us in the past, and here we can ask for whichever parts of the date we want to show.

             "For example, if we just wanted the time from a date we would write this:
             */

             Text(Date.now, format: .dateTime.hour().minute())
            
            // Or if we wanted the day, month, and year, we would write this:

             Text(Date.now, format: .dateTime.day().month().year())
            
            // "You might wonder how that adapts to handling different date formats – for example, here in the UK we use day/month/year, but in some other countries they use month/day/year. Well, the magic is that we don’t need to worry about this: when we write day().month().year() we’re asking for that data, not arranging it, and iOS will automatically format that data using the user’s preferences.
            
            //"As an alternative, we can use the formatted() method directly on dates, passing in configuration options for how we want both the date and the time to be formatted, like this:
            
            Text(Date.now.formatted(date: .long, time: .shortened))
                // "..." (Hacking with Swift).
             
        }
        .padding()
    }
    
    //we can also use Swift dates with ranges. For example:

    func exampleDates() {
        // create a second Date instance set to one day in seconds from now
        let tomorrow = Date.now.addingTimeInterval(86400)

        // create a range from those two
        let range = Date.now...tomorrow
        
        /*
        "Swift gives us Date for working with dates, and that encapsulates the year, month, date, hour, minute, second, timezone, and more. However, we don’t want to think about most of that – we want to say “give me an 8am wake up time, regardless of what day it is today.”

        "Swift has a slightly different type for that purpose, called DateComponents, which lets us read or write specific parts of a date rather than the whole thing.

        "So, if we wanted a date that represented 8am today, we could write code like this:
         */

        var components = DateComponents()
        
        components.hour = 8
        components.minute = 0
        
        var date = Calendar.current.date(from: components)
        
        // "Now, because of difficulties around date validation, that date(from:) method actually returns an optional date, so it’s a good idea to use nil coalescing to say “if that fails, just give me back the current date”, like this:
        
        date = Calendar.current.date(from: components) ?? Date.now
            //"..." (Hacking with Swift)
        
        /* How could we read the hour they want to wake up?
         
         "Remember, DatePicker is bound to a Date giving us lots of information, so we need to find a way to pull out just the hour and minute components.

         "Again, DateComponents comes to the rescue: we can ask iOS to provide specific components from a date, then read those back out. One hiccup is that there’s a disconnect between the values we request and the values we get thanks to the way DateComponents works: we can ask for the hour and minute, but we’ll be handed back a DateComponents instance with optional values for all its properties. Yes, we know hour and minute will be there because those are the ones we asked for, but we still need to unwrap the optionals or provide default values.

         "So, we might write code like this:
         */
        
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: date!)
         
        let hour = components2.hour ?? 0
         let minute = components2.minute ?? 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
