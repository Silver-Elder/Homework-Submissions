//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sterling Jenkins on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useRedText = false
    
    /*
     "...trying to create a TextField bound to a local property will cause problems.

     "However, you can create computed properties if you want, like this:
     
     */
    
    let motto1 = Text("nunquam titillandus")
    var motto2: some View {
         Text("Draco dormiens")
     }
        
    // NOTE: "if you want to send multiple views back you have three options:
     
        // Option 1: Stack
    var spellsV: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
        // Option 2: Group
    var spellsG: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
        // Option 3: Add the "@ViewBuilder" yourself
    @ViewBuilder var spellsVB: some View {
        Text("Lumos")
        Text("Obliviate")
    }
        
        // "I prefer to use @ViewBuilder because it mimics the way body works, however I’m also wary when I see folks cram lots of functionality into their properties – it’s usually a sign that their views are getting a bit too complex, and need to be broken up" (Hacking with Swift).
    

    /*
     "it’s not allowed to write a view like this:

         struct ContentView: View {
             var body: View {
                 Text("Hello World")
             }
         }
     
     "...[but it] is perfectly legal to write a view like this:

         struct ContentView: View {
             var body: Text {
                 Text("Hello World")
             }
         }
     
     "Returning View makes no sense, because Swift wants to know what’s inside the view – it has a big hole that must be filled. On the other hand, returning Text is fine, because we’ve filled the hole; Swift knows what the view is" (Hacking with Swift).
     */
    
    
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
            
            Button("Hello World") {
                // flip the Boolean between true and false
                useRedText.toggle()
            }
            .foregroundColor(useRedText ? .red : .blue)
            
            /*
             NOTE: "You can often use regular if conditions to return different views based on some state, but this actually creates more work for SwiftUI – rather than seeing one Button being used with different colors, it now sees two different Button views, and when we flip the Boolean condition it will destroy one to create the other rather than just recolor what it has.
             
                "So, this kind of code might look the same, but it’s actually less efficient:

             var body: some View {
                 if useRedText {
                     Button("Hello World") {
                         useRedText.toggle()
                     }
                     .foregroundColor(.red)
                 } else {
                     Button("Hello World") {
                         useRedText.toggle()
                     }
                     .foregroundColor(.blue)
                 }
             }
                
                "Sometimes using if statements are unavoidable, but where possible prefer to use the ternary operator instead" (Hacking with Swift).
             */
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                    .blur(radius: 0)
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
                .font(.title)
                    // This can be overridden from within the VStack because .font() is an "environment" modifier...
                .blur(radius: 5)
                    // ... but .blur() cannot be overriden because it is a "regular" modifier, meaning that any blurs applied to the 'children' of the VStack are ADDED to the 'parent' VStack's blur effect
            //Note: "To the best of my knowledge there is no way of knowing ahead of time which modifiers are environment modifiers and which are regular modifiers other than reading the individual documentation for each modifier and hope it’s mentioned. Still, I’d rather have them than not: being able to apply one modifier everywhere is much better than copying and pasting the same thing into multiple places" (Hacking with Swift).
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
