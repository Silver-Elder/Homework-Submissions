//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sterling Jenkins on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    @State private var showingAlert3 = false
    
    var body: some View {
        ZStack {
            VStack() {
                Color.yellow
                Color.purple
            }
            // This is it's own view with no deined borders (although it will keep inside the safe area unless you use that '.ignoresSafeArea()' funciton), so if your were to place this in the VStack, it would be placed above the "Hello World!" stacks and fill the entire screen...
            VStack(spacing: 20){
                HStack {
                    Color.secondary
                        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 100) //...unless you define the Crolor's view dimensions like this!
                        //Note: .secondary is the primary screen color (white or black, depending on whether light or dark mode is selected), but is slightly transparent
                    Color(red: 0.1, green: 0.8, blue: 0.5)
                        .frame(width: 100, height: 100)
                }
                HStack(spacing: 20){
                    ZStack(alignment: .top){
                        Color.green
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .padding(50)
                            
                        Text("Hello," + "\n" + "world!")
                            .foregroundColor(.secondary)
                            .background(.ultraThinMaterial)
                            
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(alignment: .top){
                        Color.green
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .padding(50)
                            
                        Text("Hello," + "\n" + "world!")
                            .foregroundStyle(.secondary)
                            .background(.ultraThinMaterial)
                            
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(alignment: .top){
                        LinearGradient(gradient: Gradient(colors: [.orange, .green]), startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .padding(50)
                        Text("Hello," + "\n" + "world!")
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                }
                HStack(spacing: 20){
                    ZStack(){
                        LinearGradient(gradient: Gradient(stops: [
                            Gradient.Stop(color: .orange, location: 0.45), Gradient.Stop(color: .green, location: 0.55) // These 'Gradient.Stop's can be shorthanded with '.init' (see below)
                        ]), startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                            .foregroundColor(.secondary)
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(){
                        LinearGradient(gradient: Gradient(stops: [
                            .init(color: .orange, location: 0.45), .init(color: .green, location: 0.55)
                        ]), startPoint: .top, endPoint: .bottom)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                            .foregroundStyle(.secondary)
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(){
                        RadialGradient(gradient: Gradient(colors: [.orange, .green]), center: .center, startRadius: 10, endRadius: 50)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                }
                HStack(spacing: 20){
                    ZStack(){
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, . purple, .red]), center: .center)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                            .foregroundColor(.secondary)
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(){
                        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, . purple, .red]), center: .center)
                            .frame(width: 100, height: 100)
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                            .foregroundStyle(.secondary)
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                    ZStack(){
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text("Hello," + "\n" + "world!")
                        Spacer()
                        //(These don't do anything in Z Stack, but you can set the alignment of your stack (^^^))
                        
                    }
                }
                HStack(spacing: 20) {
                    Button("Delete Section") {
                        print("Now deleting...")
                    }
                        .buttonStyle(.bordered)
                        // These (^^^) (vvv) do the exact same thing
                    Button("Delete Section", action: executeDelete)
                        .buttonStyle(.borderedProminent)
                    Button("Delete Section", role: .destructive, action: executeDelete)
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                }
                HStack {
                    Button {
                        print("Button was tapped")
                    } label: {
                        Text("Tap me!")
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                    } // This is how to set up a button in a completely custon way, which is useful for incorporating images into your button (vvv)
                    
                        //You can also set the label of a button to be an image, and do so in three different ways:
                            // Image("") allows you to load an image from your file with that string name
                            // Image(decorative: "") allows you to load an image with that string name from your assets, but it won't show the name of that image to users who have screen reader enabled
                            // Image(systemName: "") uses apple's default icons with the given name you insert
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Image(systemName: "pencil")
                    }
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    // Tip (From Hacking with Swift): If you find that your images have become filled in with a color, for example showing as solid blue rather than your actual picture, this is probably SwiftUI coloring them to show that they are tappable. To fix the problem, use the renderingMode(.original) modifier to force SwiftUI to show the original image rather than the recolored version.
                }
                
                HStack {
                    Button("Show alert") {
                        showingAlert = true
                    }
                    .alert("Important message", isPresented: $showingAlert) {
                        Button("OK") {}
                    }
                        // Note: "SwiftUI will automatically set showingAlert back to false when the alert is dismissed" (Hacking with Swift)
                    
                    Button("Show Alert") {
                        showingAlert2 = true
                    }
                    .alert("Important message", isPresented: $showingAlert2) {
                        Button("Delete", role: .destructive) {}
                        Button ("Cancel", role: .cancel) {}
                    }
                    
                    Button("Show Alert!") {
                        showingAlert3 = true
                    }
                    .alert("Important message", isPresented: $showingAlert3) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Please read this")
                    }
                }
                
            }
            .background(.brown)
        }
            .ignoresSafeArea()
    }
    
    func executeDelete() {
        print("Now deleting...")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
