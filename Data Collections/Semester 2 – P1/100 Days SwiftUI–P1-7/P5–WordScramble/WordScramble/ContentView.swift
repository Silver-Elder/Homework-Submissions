//
//  ContentView.swift
//  WordScramble
//
//  Created by Sterling Jenkins on 1/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
        /*
         "rootWord... will contain the word we want the player to spell from. What we need to do now is write a new method called startGame() that will:

                1. Find start.txt in our bundle
                2. Load it into a string
                3. Split that string into array of strings, with each element being one word
                4. Pick one random word from there to be assigned to rootWord, or use a sensible default if the array is empty.
            [(see aach of these steps defined in the function below)]
         
         "Each of those four tasks corresponds to one line of code, but there’s a twist: what if we can’t locate start.txt in our app bundle, or if we can locate it but we can’t load it? In that case we have a serious problem, because our app is really broken – either we forgot to include the file somehow (in which case our game won’t work), or we included it but for some reason iOS refused to let us read it (in which case our game won’t work, and our app is broken).

         "Regardless of what caused it, this is a situation that never ought to happen, and Swift gives us a function called fatalError() that lets us respond to unresolvable problems really clearly. When we call fatalError() it will – unconditionally and always – cause our app to crash. It will just die. Not “might die” or “maybe die”: it will always just terminate straight away.

         "I realize that sounds bad, but what it lets us do is important: for problems like this one, such as if we forget to include a file in our project, there is no point trying to make our app struggle on in a broken state. It’s much better to terminate immediately and give us a clear explanation of what went wrong so we can correct the problem, and that’s exactly what fatalError() does" (Hacking with Swift – Running code when our app launches).
         */
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    // "Now we can add a method that sets the title and message based on the parameters it receives, then flips the showingError Boolean to true [(see wordError func below)]
    
    var body: some View {
        NavigationView {
               List {
                   Section {
                       
                       /*
                        "when we call addNewWord() it lowercases the word the user entered, which is helpful because it means the user can’t add “car”, “Car”, and “CAR”. However, it looks odd in practice: the text field automatically capitalizes the first letter of whatever the user types, so when they submit “Car” what they see in the list is “car”.

                        "To fix this, we can disable capitalization for the text field with another modifier: textInputAutocapitalization()" (Hacking with Swift – Adding to a list of words).
                        */
                       
                       TextField("Enter your word", text: $newWord)
                           .textInputAutocapitalization(.never)
                       
                       /*
                        "...although we can type into the text box, we can’t submit anything from there – there’s no way of adding our entry to the list of used words.

                        "To fix that we’re going to write a new method called addNewWord() [(see below)] that will:

                            1. Lowercase newWord and remove any whitespace
                            2. Check that it has at least 1 character otherwise exit
                            3. Insert that word at position 0 in the usedWords array
                            4. Set newWord back to be an empty string
                        
                        "Later on we’ll add some extra validation between steps 2 and 3 to make sure the word is allowable" (Haking with Swift – Adding to a list of words).
                        */
                   }

                   Section {
                       
                       /*
                        "... just because we can, [we'll] use Apple’s SF Symbols icons to show the length of each word next to the text. SF Symbols provides numbers in circles from 0 through 50, all named using the format “x.circle.fill” – so 1.circle.fill, 20.circle.fill.

                        "In this program we’ll be showing eight-letter words to users, so if they rearrange all those letters to make a new word the longest it will be is also eight letters. As a result, we can use those SF Symbols number circles just fine – we know that all possible word lengths are covered.

                        "So, we can wrap our word text in a HStack, and place an SF Symbol next to it using Image(systemName:)` like this:
                        */
                       
                    // ForEach(usedWords, id: \.self) { word in
                    // Text(word)
                    // }
                       
                   ForEach(usedWords, id: \.self) { word in
                       HStack {
                           Image(systemName: "\(word.count).circle")
                           Text(word)
                       }
                   }
                       // "..." (Hacking with Swift – Adding to a list of words).
                        
                       // "Note: Using id: \.self would cause problems if there were lots of duplicates in usedWords, but soon enough we’ll be disallowing that so it’s not a problem" (Hacking with Swift – Adding to a list of words).
                   }
               }
               .navigationTitle(rootWord)
                   .onSubmit(addNewWord)
                   .onAppear(perform: startGame)
                   .alert(errorTitle, isPresented: $showingError) {
                       Button("OK", role: .cancel) { }
                   } message: {
                       Text(errorMessage)
                   }
           }
        
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        // (Start extra validation)
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        // (End extra validation)

        // Note: "When we submit our text field right now, the text just appears in the list immediately, but we could animate that by modifying the insert() call inside addNewWord() to this:
        
        // usedWords.insert(answer, at: 0)
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    /*
     "We want to call addNewWord() when the user presses return on the keyboard, and in SwiftUI we can do that by adding an onSubmit() modifier somewhere in our view hierarchy – it could be directly on the button, but it can be anywhere else in the view because it will be triggered when any text is submitted.
     
     "onSubmit() needs to be given a function that accepts no parameters and returns nothing, which exactly matches the addNewWord() method we just wrote. So, we can pass that in directly by adding this modifier below navigationTitle()" (Hacking with Swift – Adding to a list of words).
     */
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem [(meaning we didn't hit the return in our 'if let' tree)] – [so we'll] trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    // "Now that we have a method to load everything for the game, we need to actually call that thing when our view is shown. SwiftUI gives us a dedicated view modifier for running a closure when a view is shown, so we can use that to call startGame() and get things moving – add this modifier after onSubmit() [(see above)]" (Hacking with Swift – Running code when our app launches).
    
    /*
     "Now that our game is all set up, the last part of this project is to make sure the user can’t enter invalid words. We’re going to implement this as four small methods, each of which perform exactly one check:
        1. is the word original (it hasn’t been used already)?
        2. is the word possible (they aren’t trying to spell “car” from “silkworm”)?
        3. is the word real (it’s an actual English word)?
        4. ...the fourth method will be there to make showing error messages easier
     */
    
        // 1. Is the word original (it hasn’t been used already)?
    
        // "this will accept a string as its only parameter, and return true or false depending on whether the word has been used before or not. We already have a usedWords array, so we can pass the word into its contains() method and send the result" (Hacking with Swift – Validating words with UITextChecker).
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
        // 2. Is the word possible (they aren’t trying to spell “car” from “silkworm”)?
    
        // "There are a couple of ways we could tackle this, but the easiest one is this: if we create a variable copy of the root word, we can then loop over each letter of the user’s input word to see if that letter exists in our copy. If it does, we remove it from the copy (so it can’t be used twice), then continue. If we make it to the end of the user’s word successfully then the word is good, otherwise there’s a mistake and we return false" (Hacking with Swift – Validating words with UITextChecker).
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
        // 3. Is the word real (it’s an actual English word)?
    
        // "[This] method is harder, because we need to use UITextChecker from UIKit. In order to bridge Swift strings to Objective-C strings safely, we need to create an instance of NSRange using the UTF-16 count of our Swift string. This isn’t nice, I know, but I’m afraid it’s unavoidable until Apple cleans up these APIs.
    
        // So, our last method will make an instance of UITextChecker, which is responsible for scanning strings for misspelled words. We’ll then create an NSRange to scan the entire length of our string, then call rangeOfMisspelledWord() on our text checker so that it looks for wrong words. When that finishes we’ll get back another NSRange telling us where the misspelled word was found, but if the word was OK the location for that range will be the special value NSNotFound" (Hacking with Swift – Validating words with UITextChecker).
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound // a.k.a did our "misspelledRange.location" give us the "NSNotFound" error or not. If this is false, our word is valid; and if true, the word is not an actual word
    }
    
    // "Before we can use those three, I want to add some code to make showing error alerts easier. First, we need some properties to control our alerts [(see top)]
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    // "We can then pass those directly on to SwiftUI by adding an alert() modifier below .onAppear()
    
    // "At long last it’s time to finish our game: replace the // extra validation to come comment in addNewWord() with this:" (Hacking with Swift – Validating words with UITextChecker) (see above).
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
