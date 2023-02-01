//
//  ContentView.swift
//  Unit Conversion Challenge
//
//  Created by Sterling Jenkins on 1/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var convertUnit = "Meters"
    @State private var toUnit = "Meters"
    @State private var input: Double? = nil
    
    var conversionUnits = ["Meters", "Feet"]
    
    var convertedUnits: String {
        return "\(convertUnits().formatted())"
            // NOTE: this .formatted() is how to get our output double to drop the ".0" if our double is a whole number
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Convert:", selection: $convertUnit) {
                    ForEach(conversionUnits, id: \.self) {
                        Text($0)
                    }
                }
                Picker("To:", selection: $toUnit) {
                    ForEach(conversionUnits, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section {
                TextField("Number of \(convertUnit)", value: $input, format: .number)
            } header: {
                Text("How many \(convertUnit) do you want to convert?")
            }
            
            Section {
                Text(convertedUnits)
            } header: {
                Text("Number of \(toUnit)")
            }
        }
    }
    
    func convertUnits() -> Double {
        switch convertUnit {
        case "Meters":
            switch toUnit {
            case "Feet":
                return (input ?? 0) * 3.28084
            default:
                return input ?? 0
            }
        case "Feet":
            switch toUnit {
            case "Meters":
                return (input ?? 0) / 3.28084
            default:
                return input ?? 0
            }
        default:
            return 0 // This should never run
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
