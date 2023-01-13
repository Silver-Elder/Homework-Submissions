//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sterling Jenkins on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            /*
        
            Button("Hello, world!")
            {
                print(type(of: self.body))
            }
                .background(.red)
                .frame(width: 200, height: 200)
             
             "What do you think that will look like when it runs?

            " Chances are you guessed wrong: you won’t see a 200x200 red button with 'Hello, world!' in the middle. Instead, you’ll see a 200x200 empty square, with 'Hello, world!' in the middle and with a red rectangle directly around 'Hello, world!'.
             
             "...the order of your modifiers MATTERS. If we rewrite our code to apply the background color after the frame, then you might get the result you expected" (Hacking with Swift)
             
            */
            
            Button("Hello, world!")
            {
                print(type(of: self.body))
            }
                .frame(width: 200, height: 200)
                .background(.red)
            
            Text("Hello, world!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
