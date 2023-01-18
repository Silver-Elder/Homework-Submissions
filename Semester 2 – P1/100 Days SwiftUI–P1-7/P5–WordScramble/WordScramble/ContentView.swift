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
    @State private var newWord = ""
    
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
           }
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        // (extra validation to come)

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
