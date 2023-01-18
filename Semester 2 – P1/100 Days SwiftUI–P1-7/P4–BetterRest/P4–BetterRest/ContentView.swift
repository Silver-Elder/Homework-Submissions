//
//  ContentView.swift
//  P4–BetterRest
//
//  Created by Sterling Jenkins on 1/17/23.
//

/* Challenge:
 "One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:

 " 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
 " 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
 " 3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely" (Hacking with Swift)
 */



import CoreML // This will let up work with our Machine Learning data
    // Also Note: keeping your imports in alphabetical order doesn't matter from a funcitonality standpoint, but it does help you keep your code organized
import SwiftUI

// Fun Note: "The truly fascinating thing about machine learning is that it doesn’t need big or clever scenarios to be used. You could use machine learning to predict used car prices, to figure out user handwriting, or even detect faces in images. And most importantly of all, the entire process happens on the user’s device, in complete privacy" (Hacking with Swift – BetterRest: Wrap up).

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    /*
     "When you read Date.now it is automatically set to the current date and time. So, when we create our wakeUp property with a new date, the default wake up time will be whatever time it is right now.
     
     "Although the app needs to be able to handle any sort of times – we don’t want to exclude folks on night shift, for example – I think it’s safe to say that a default wake up time somewhere between 6am and 8am is going to be more useful to the vast majority of users.

     "To fix this we’re going to add a computed property to our ContentView struct that contains a Date value referencing 7am of the current day. This is surprisingly easy: we can just create a new DateComponents of our own, and use Calendar.current.date(from:) to convert those components into a full date.
     
     "...we can use that for the default value of wakeUp in place of Date.now... [but if] If you try compiling that code you’ll see it fails, and the reason is that we’re accessing one property from inside another – Swift doesn’t know which order the properties will be created in, so this isn’t allowed.
     
     "The fix here is simple: we can make defaultWakeTime a static variable, which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.
     
     "That fixes our usability problem, because the majority of users will find the default wake up time is close to what they want to choose" (Hacking with Swift).
     */
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            // "To improve our styling... requires more effort. A simple change to make is to switch to a Form rather than a VStack" (Hacking wiht Swift).
            
            // VStack {
            Form {
                
                /*
                 "That immediately makes the UI look better – we get a clearly segmented table of inputs, rather than some controls centered in a white space.

                 "There’s still an annoyance in our form: every view inside the form is treated as a row in the list, when really all the text views form part of the same logical form section.

                 "We could use Section views here, with our text views as titles – you’ll get to experiment with that in the challenges. Instead, we’re going to wrap each pair of text view and control with a VStack so they are seen as a single row each" (Hacking with Swift).
                 */
                
                VStack(alignment: .leading) {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack(alignment: .leading) {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading) {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 0...20)
                }
            }
                .padding()
                .navigationTitle("BetterRest")
                .toolbar {
                Button("Calculate", action: calculateBedtime)
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // Note: "Core ML can throw errors in two places: loading the model as seen above, but also when we ask for predictions. Honestly, I can’t think I’ve ever had a prediction fail in my life, but there’s no harm being safe!" (Hacking with Swift).
            
            /*
            "...we trained our model with a CSV file containing the following [field], “wake”, [which is] when the user wants to wake up. This is expressed as the number of seconds from midnight, so 8am would be 8 hours multiplied by 60 multiplied by 60, giving 28800
             
             "...figuring out the wake time requires more thinking, because our wakeUp property is a Date not a Double representing the number of seconds. Helpfully, this is where Swift’s DateComponents type comes in: it stores all the parts required to represent a date as individual values, meaning that we can read the hour and minute components and ignore the rest. All we then need to do is multiply the minute by 60 (to get seconds rather than minutes), and the hour by 60 and 60 (to get seconds rather than hours).
             
             "We can get a DateComponents instance from a Date with a very specific method call: Calendar.current.dateComponents(). We can then request the hour and minute components, and pass in our wake up date. The DateComponents instance that comes back has properties for all its components – year, month, day, timezone, etc – but most of them won’t be set. The ones we asked for – hour and minute – will be set, but will be optional, so we need to unwrap them carefully:
             */
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // "The next step is to feed our values into Core ML and see what comes out. This is done using the prediction() method of our model, which wants the wake time, estimated sleep, and coffee amount values required to make a prediction, all provided as Double values. We just calculated our hour and minute as seconds, so we’ll add those together before sending them in:
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // "With that in place, prediction now contains how much sleep they actually need. This almost certainly wasn’t part of the training data our model saw, but was instead computed dynamically by the Core ML algorithm.

           // "However, it’s not a helpful value for users – it will be some number in seconds. What we want is to convert that into the time they should go to bed, which means we need to subtract that value in seconds from the time they need to wake up.

            // "Thanks to Apple’s powerful APIs, that’s just one line of code – you can subtract a value in seconds directly from a Date, and you’ll get back a new Date! So, add this line of code after the prediction:

            let sleepTime = wakeUp - prediction.actualSleep
            
            // "And now we know exactly when they should go to sleep. Our final challenge, for now at least, is to show that to the user. We’ll be doing this with an alert, because you’ve already learned how to do that and could use the practice" (Hacking with Swift).
            
            /*
             "If the prediction worked we create a constant called sleepTime that contains the time they need to go to bed. But this is a Date rather than a neatly formatted string, so we’ll pass it through the formatted() method to make sure it’s human-readable, then assign it to alertMessage:
             */
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            // Now "we just need to add an alert() modifier [to our VStack] that shows alertTitle and alertMessage when showingAlert becomes true" (Hacking with Swift).
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        // Note: "...regardless of whether or not the prediction worked, we should show the alert. It might contain the results of their prediction or it might contain the error message, but it’s still useful. So, put this at the end of calculateBedtime(), after the catch block:
        
        showingAlert = true
            // "..." (Hacking with Swift)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
