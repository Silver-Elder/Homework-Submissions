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
    
    /*
    "Swift gives us a method called components(separatedBy:) that can converts a single string into an array of strings by breaking it up wherever another string is found. For example, this will create the array ["a", "b", "c"]:

         let input = "a b c"
         let letters = input.components(separatedBy: " ")
     
     "[For our porject, we] have a string where words are separated by line breaks, so to convert that into a string array we need to split on that.
     
     "In programming – almost universally, I think – we use a special character sequence to represent line breaks: \n. So, we would write code like this:

         let input = """
                     a
                     b
                     c
                     """
         let letters = input.components(separatedBy: "\n")
     
     "Regardless of what string we split on, the result will be an array of strings" (Hacking with Swift – Working with strings).
     */
    
    /*
     "...this will read a random letter from our array:

        let letter = letters.randomElement()
     
     "Now, although we can see that the letters array will contain three items, Swift doesn’t know that – perhaps we tried to split up an empty string, for example. As a result, the randomElement() method returns an optional string, which we must either unwrap or use with nil coalescing.

     "Another useful string method is trimmingCharacters(in:), which asks Swift to remove certain kinds of characters from the start and end of a string. This uses a new type called CharacterSet, but most of the time we want one particular behavior: removing whitespace and new lines – this refers to spaces, tabs, and line breaks, all at once.

     "This behavior is so common it’s built right into the CharacterSet struct, so we can ask Swift to trim all whitespace at the start and end of a string like this:

        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
     
     "..." (Hacking with Swift – Working with strings).
     */
    
    /* The ability to check for misspelled words
     
     "This functionality is provided through the class UITextChecker. You might not realize this, but the “UI” part of that name carries two additional meanings with it:

        "This class comes from UIKit. That doesn’t mean we’re loading all the old user interface framework, though; we actually get it automatically through SwiftUI.
     
        "It’s written using Apple’s older language, Objective-C. We don’t need to write Objective-C to use it, but there is a slightly unwieldy API for Swift users.
     
     "Checking a string for misspelled words takes four steps in total.
     
        1.
     "...we create a word to check and an instance of UITextChecker that we can use to check that string:

         let word = "swift"
         let checker = UITextChecker()
     
        2.
     "we need to tell the checker how much of our string we want to check. If you imagine a spellchecker in a word processing app, you might want to check only the text the user selected rather than the entire document.

     "However, there’s a catch: Swift uses a very clever, very advanced way of working with strings, which allows it to use complex characters such as emoji in exactly the same way that it uses the English alphabet. However, Objective-C does not use this method of storing letters, which means we need to ask Swift to create an Objective-C string range using the entire length of all our characters, like this:

         let range = NSRange(location: 0, length: word.utf16.count)
     
     "UTF-16 is what’s called a character encoding – a way of storing letters in a string. We use it here so that Objective-C can understand how Swift’s strings are stored; it’s a nice bridging format for us to connect the two.
     
        3.
     "we can ask our text checker to report where it found any misspellings in our word, passing in the range to check, a position to start within the range (so we can do things like “Find Next”), whether it should wrap around once it reaches the end, and what language to use for the dictionary:
     
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
     
     "That sends back another Objective-C string range, telling us where the misspelling was found. Even then, there’s still one complexity here: Objective-C didn’t have any concept of optionals, so instead relied on special values to represent missing data.
     
     "In this instance, if the Objective-C range comes back as empty – i.e., if there was no spelling mistake because the string was spelled correctly – then we get back the special value NSNotFound.

     "So, we could check our spelling result to see whether there was a mistake or not like this:

            let allGood = misspelledRange.location == NSNotFound
     
    "..." (Hacknig with Swift).
     
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
