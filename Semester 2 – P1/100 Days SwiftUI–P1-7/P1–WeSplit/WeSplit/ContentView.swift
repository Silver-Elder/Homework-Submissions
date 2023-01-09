//
//  ContentView.swift
//  WeSplit
//
//  Created by Sterling Jenkins on 1/9/23.
//

// git commit -m "Changed deployment target /see 'WePlit' next to the blue app icon in left-hand navigation bar/ from iOS 16.2 to 15. This explanded my options for all the different simluators I could run my app on /which is important for the next step of this project: 'Adding a Navigation Bar/.'"

import SwiftUI

struct ContentView: View {
    var body: some View {
        Form { // This Form has a limit of 10 items that it can hold, but we can overcome that limit by combining different entities into 1 entity, known as a "Group"
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
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
