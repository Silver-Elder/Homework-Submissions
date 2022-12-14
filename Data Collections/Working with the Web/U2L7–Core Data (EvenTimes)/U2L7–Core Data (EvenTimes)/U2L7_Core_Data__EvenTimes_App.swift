//
//  U2L7_Core_Data__EvenTimes_App.swift
//  U2L7–Core Data (EvenTimes)
//
//  Created by Sterling Jenkins on 12/9/22.
//

import SwiftUI

@main
struct U2L7_Core_Data__EvenTimes_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
