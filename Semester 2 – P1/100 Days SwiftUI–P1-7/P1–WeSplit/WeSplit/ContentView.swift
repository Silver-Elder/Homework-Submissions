//
//  ContentView.swift
//  WeSplit
//
//  Created by Sterling Jenkins on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form { // This Form has a limit of 10 items that it can hold, but we can overcome that limit by combining different entities into 1 entity, known as a "Group"
                /*
                Group {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                Group {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                Section { // We can also "Group", items using this "Section", command. The difference is that these "Section"s, will visually display the item group seperate form the rest
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                */
                Section {
                    Text("Hello, world!")
                }
            }
            .navigationTitle("SwiftUI") // This is set to display a large title by default. We can change that using this line of code vvv
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
