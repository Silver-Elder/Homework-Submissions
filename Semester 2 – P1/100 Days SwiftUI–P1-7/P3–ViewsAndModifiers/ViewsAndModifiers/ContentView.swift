//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sterling Jenkins on 1/12/23.
//

import SwiftUI


/*
 "To create a custom modifier, create a new struct that conforms to the ViewModifier protocol. This has only one requirement, which is a method called body that accepts whatever content it’s being given to work with, and must return some View":
 */

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// "We can now use that with the modifier() modifier – yes, it’s a modifier called “modifier”, but it lets us apply any sort of modifier to a view" (Hacking with Swift), (see "Text("Hello World").modifier(Title())").

/* "When working with custom modifiers, it’s usually a smart idea to create extensions on View that make them easier to use. For example, we might wrap the Title modifier in an extension such as this:
 */

 extension View {
     func titleStyle() -> some View {
         modifier(Title())
     }
 }
 
// "We can now use the modifier like this:
    // Text("Hello World").titleStyle()" (Hacking with Swift)

/* "Remember [how] modifiers return new objects rather than modifying existing ones[?] [Because of that] we could create one that embeds [a] view in a stack and adds another view:
 */

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// "With that in place, we can now add a watermark to any view like this:" (Hacking with Swift), (see Color.blue near bottom).
// Note: "Often folks wonder when it’s better to add a custom view modifier versus just adding a new method to View, and really it comes down to one main reason: custom view modifiers can have their own stored properties, whereas extensions to View cannot" (Hacking with Swift).

// This is how to make a "Custom Container" (vvv)
struct GridStack<Content: View>: View {
    // "The first line – struct GridStack<Content: View>: View – uses a more advanced feature of Swift called generics, which in this case means “you can provide any kind of content you like, but whatever it is it must conform to the View protocol.” After the colon we repeat View again to say that GridStack itself also conforms to the View protocol" (Hacking with Swift)
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
         // "Take particular note of the let content line – that defines a closure that must be able to accept two integers and return some sort of content we can show" (Hacking with Swift).
    

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

    // "Now that we have a custom container, we can write a view using it like this:" (Hacking with Swift), (see top of 'body' for 'GridStack' use).

/*
    //Our GridStack is capable of accepting any kind of cell content, as long as it conforms to the View protocol. So, we could give cells a stack of their own if we wanted:
            
            GridStack(rows: 4, columns: 4) { row, col in
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                }
 
     // "For more flexibility we could leverage the same @ViewBuilder attribute used by SwiftUI for the body property of its views. Modify the content property of GridStack to this:
     
            @ViewBuilder let content: (Int, Int) -> Content

    // "With that in place SwiftUI will now automatically create an implicit horizontal stack inside our cell closure:

            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }

    // "Both options work, so do whichever you prefer" (Hacking with Swift).
*/

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            // .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

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
        
        GridStack(rows: 1, columns: 2) { row, col in
            // For some reason, I can't embed this inside the VStack, but I can embed other stacks inside of it 🤷‍♂️
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
                .frame(width: 100, height: 20)
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
                
                /*
                 VStack(spacing: 10) {
                 Text("First")
                 .font(.largeTitle)
                 .padding()
                 .foregroundColor(.white)
                 .background(.blue)
                 .clipShape(Capsule())
                 
                 Text("Second")
                 .font(.largeTitle)
                 .padding()
                 .foregroundColor(.white)
                 .background(.blue)
                 .clipShape(Capsule())
                 }
                 
                 "Because those two text views are identical apart from their text, we can wrap them up in a new custom view, like this:" (see "CapsuleText @ top"), "[and] then use that CapsuleText view inside our original view, like this:"
                 
                 
                 VStack(spacing: 10) {
                 CapsuleText(text: "First")
                 CapsuleText(text: "Second")
                 }
                 
                 "Of course, we can also store some modifiers in the view and customize others when we use them. For example, if we removed foregroundColor() from CapsuleText, we could then apply custom colors when creating instances of that view like this:" (Hacking with Swift).
                 */
                
                VStack(spacing: 10) {
                    CapsuleText(text: "First")
                        .foregroundColor(.white)
                    CapsuleText(text: "Second")
                        .foregroundColor(.yellow)
                }
                
                Color.blue
                    .frame(width: 150, height: 30)
                    .watermarked(with: "Hacking with Swift")
                
                Text("Hello World").modifier(Title())
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
