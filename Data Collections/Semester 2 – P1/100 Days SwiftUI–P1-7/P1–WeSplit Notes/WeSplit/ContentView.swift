//
//  ContentView.swift
//  WeSplit
//
//  Created by Sterling Jenkins on 1/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0 // By adding the @State to this "tapCount", var of this "ContentView", struct; the value of our var is stored outside of the struct in a place where it CAN be changed. (Remember that the only way we could have part of a struct change a variable in the struct was if we created a mutating func. We can't make a mutatin computer var, however (which is what our var body is), so we use this @State method instead)
    // For a better idea of what the @State is doing, take a look at this mock state setup code (Note: this shows the concept, not the actual design)
    /*
     class State {
         var tapCount: Int = 0
     }

     struct ContentView {
         private var state = State()

         func test() {
             state.tapCount = 2
         }
     }
     */
    
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        VStack { // For whatever reason, xCode will allow me to create two "parent views" – in this case, my Button and NavigationView – and while my preview will display these two parent view separately, the views are automaticlly combined when the app is run. This works because of the finicky way that xCode is set up, but I shouldn't be able to do that. To combine these views the PROPER way, I should embed these two views in a VStack, as shown here. What problems would occur if I didn't, beyond the preview and running app not aligning? I honetsly have no clue 😅
            // The best way to fix this problem would really be to put the button inside the NavigationView, so I'll comment out this button to show what I was talking about before, and re-add the button in the NavView
            /*
            Button("Tap Count: \(tapCount)") {
                self.tapCount += 1
            }
             */
            
            NavigationView {
                Form { // This Form has a limit of 10 items that it can hold, but we can overcome that limit by combining different entities into 1 entity, known as a "Group"
                    
                    Section {
                        Picker("Select your student", selection: $selectedStudent) {
                            ForEach(students, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        // Note: In our loop, 'students' is the data source which the loop is reading to create a 'Text' field for each itm in our 'students' array. The 'id' tells the computer that this item being added by the loop to the picker should be distinguished by the value, any type of that value which was passed in (which in this case is the name of the student, which is of 'String' type). This tells the computer that it should update its UI if the value and type we change in the 'students' array matches the value and type id we set for that Picker's content item. If we DID have two identical strings in our array (say, two "Ron"s), we might run into problems. What to do in that case is yet to be explained.
                        // Note: The '$selectedStudent' will both display the value of that variable, and then save whatever the user selects from the picker's "contents", as the new value of that variable
                    }
                    
                    Section {
                        /*
                        ForEach(0..<11) { number in
                            Text("Row \(number)")
                        }
                     */
                        // Note: this 'ForEach' loop is not restrictd to the 10 item limit that the Form is inherantly restricted to, so we can run this loop as many times as we want!
                        
                        // Because this lop is written in closure syntax, we can make a shorthand version (vvv) of the loop above (^^^)
                    
                        ForEach(0..<11) {
                            Text("Row \($0)")
                        }
                    }
                    
                    Section {
                        TextField("Enter your name", text: $name)
                        // The $name talls the computer to both show the value of 'name' in the text field, ans also to save whateve the user writes into the text field as the value of our 'name' var
                        Text("Your name is \(name)")
                    }
                    
                    Section {
                        Button("Tap Count: \(tapCount)") {
                            self.tapCount += 1
                        }
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
                .navigationTitle("SwiftUI") // This code creates a navigation bar, and is set to display a large title by default. We can change that using this line of code vvv
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
