//
//  ContentView.swift
//  WordScramble
//
//  Created by Sterling Jenkins on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    
    /*
     "When Xcode builds your iOS app, it creates something called a “bundle”. This happens on all of Apple’s platforms, including macOS, and it allows the system to store all the files for a single app in one place – the binary code (the actual compiled Swift stuff we wrote), all the artwork, plus any extra files we need all in one place.

     "In the future, as your skills grow, you’ll learn how you can actually include multiple bundles in a single app, allowing you to write things like Siri extensions, iMessage apps, widgets, and more, all inside a single iOS app bundle. Although these get included with our app’s download from the App Store, these other bundles are stored separately from our main app bundle – our main iOS app code and resources.

     "All this matters because it’s common to want to look in a bundle for a file you placed there. This uses a new data type called URL, which stores pretty much exactly what you think: a URL such as https://www.hackingwithswift.com. However, URLs are a bit more powerful than just storing web addresses – they can also store the locations of files, which is why they are useful here.

     "Let’s start writing some code. If we want to read the URL for a file in our main app bundle, we use Bundle.main.url(). If the file exists it will be sent back to us, otherwise we’ll get back nil, so this is an optional URL. That means we need to unwrap it like this:
     
    
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            // we found the file in our bundle!
        }
    
     "What’s inside the URL doesn’t really matter, because iOS uses paths that are impossible to guess – our app lives in its own sandbox, and we shouldn’t try to read outside of it.
     
     Once we have a URL, we can load it into a string with a special initializer: String(contentsOf:). We give this a file URL, and it will send back a string containing the contents of that file if it can be loaded. If it can’t be loaded it throws an error, so you you need to call this using try or try? like this:
     
         if let fileContents = try? String(contentsOf: fileURL) {
             // we loaded the file into a string!
         }
     
     "Once you have the contents of the file, you can do with it whatever you want – it’s just a regular string" (Hacking with Swift – Loading resources from your app bundle).
     */
    
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        
        // Note: "...the equivalent of List in UIKit was UITableView" (Hacking with Swift – Introducing List, your best friend).
        List {
            
            // Note: "...if your section header is just some text you can pass it in directly as a string – it’s a helpful shortcut for times you don’t need anything more advanced" (Hacking with Swift – Introducing List, your best friend).
            Section ("Section 1"){
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                
                ForEach(0..<5) {
                       Text("Dynamic row \($0)")
                }
            }
            
            Section ("Section 2"){
                Text("Static row 1")
                Text("Static row 2")

                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
                
                Text("Static row 3")
                Text("Static row 4")
            }
            
            Section ("Section 3") {
                Text("Static Row")

                ForEach(people, id: \.self) {
                    Text($0)
                }

                Text("Static Row")
            }
        }
        .padding()
        
        /*
        "...one thing List can do that Form can’t is to generate its rows entirely from dynamic content without needing a ForEach.

         "So, if your entire list is made up of dynamic rows, you can simply write this:

             List(0..<5) {
                 Text("Dynamic row \($0)")
             }
         
         "This allows us to create lists really quickly, which is helpful given how common they are" (Hacking with Swift – Introducing List, your best friend).
         */
        
        /*
         "In this project we’re going to use List slightly differently, because we’ll be making it loop over an array of strings. We’ve used ForEach with ranges a lot, either hard-coded (0..<5) or relying on variable data (0..<students.count), and that works great because SwiftUI can identify each row uniquely based on its position in the range.
         
         "When working with an array of data, SwiftUI still needs to know how to identify each row uniquely, so if one gets removed it can simply remove that one rather than having to redraw the whole list. This is where the id parameter comes in, and it works identically in both List and ForEach – it lets us tell SwiftUI exactly what makes each item in the array unique.

         "When working with arrays of strings and numbers, the only thing that makes those values unique is the values themselves. That is, if we had the array [2, 4, 6, 8, 10], then those numbers themselves are themselves the unique identifiers. After all, we don’t have anything else to work with!

         "When working with this kind of list data, we use id: \.self like this:

             struct ContentView: View {
                 let people = ["Finn", "Leia", "Luke", "Rey"]

                 var body: some View {
                     List(people, id: \.self) {
                         Text($0)
                     }
                 }
             }
         
         "That works just the same with ForEach, so if we wanted to mix static and dynamic rows we could have written this instead:
         
             List {
                 Text("Static Row")

                 ForEach(people, id: \.self) {
                     Text($0)
                 }

                 Text("Static Row")
             }
            "..." (Hacking with Swift – Introducing List, your best friend).
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
