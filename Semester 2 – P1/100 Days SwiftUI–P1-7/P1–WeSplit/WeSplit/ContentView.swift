//
//  ContentView.swift
//  WeSplit
//
//  Created by Sterling Jenkins on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    /*
                    TextField("Amount", text: $checkAmount)
                        // Our text field wants our 'text' to be a 'String' type; and since our type is a 'Double', we'll have to do something different (vvv)
                     
                     TextField("Amount", value: $checkAmount, format: .currency(code: "USD"))
                        // Now, the 'Double' 'value' that we're passing in is being converted to a 'String' in '.currency' format. The only problem with selecting "USD" as our format is that 95% of the human population doesn't use US Dollars, so let's chang that part (vvv) so that the computer will look at the user's location, see if that region is stored in the 'Locale' database and has had a currency type set for it, and use that as the '.currency' format. If the region doesn't have a set currency type, the computer will default the type to be in 'USD'.
                     
                     TextField("Amount:", value: $checkAmount, format: .currency(code: Locale.current.currencyCode.identifier ?? "USD"))
                        // (This is also the old format for iOS 15, so we'll need to update this setup for how it's now structures in iOS 16.2
                     */
                
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                        //Note: The '@State' we're using for our checkAmount pays attention to any changes made to the vlue of that var, and takes care of reloading the tableView for us when the value of our @State var is changed so that any other parts of the app that refer to the value of that variable will also be updated (like this second section, which is set to display the value of our 'checkAmount' var. That wouldn't reflect the new amount which the var is set to in the first section if the tableView wasn't reloaded).
                        // Also Note: We could use either .numberPad or .decimalPad for our 'keyboardType()', but .decimal pad will give the user an extra "." button so they can enter decimal amouts
                        // We can also enter our 'keyboardType' onto a new line, and intent it to help up better see what modifiers we've added to our 'TestField'
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    // Text("How much tip do you wna to leave?")
                        // This (^^^) doesn't look great, so let's make it our 'Section's header instead
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                        .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }.navigationTitle("WeSplit")
                // Note: This needs to be added to the end of the 'Form', and NOT the NavView. That's because the NavView can house multiple views, so we need to apply the title to the specific view (our 'Form' viw, in this case), inside the NavView's body
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
