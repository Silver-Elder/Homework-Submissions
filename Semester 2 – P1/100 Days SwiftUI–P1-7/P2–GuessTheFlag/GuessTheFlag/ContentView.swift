//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sterling Jenkins on 1/11/23.
//

import SwiftUI

struct ContentView: View {
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
                        .frame(minWidth: 200, maxWidth: .infinity, maxHeight: 200) //...unless you define the Crolor's view dimensions like this!
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
                
            }
            .background(.red)
        }
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
