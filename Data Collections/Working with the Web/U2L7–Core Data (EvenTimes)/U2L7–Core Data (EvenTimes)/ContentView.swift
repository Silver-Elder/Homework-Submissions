//
//  ContentView.swift
//  U2L7–Core Data (EvenTimes)
//
//  Created by Sterling Jenkins on 12/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                        
//                        if item.isInEveryOther {
//                            Color(red: 0, green: 0, blue: 1, opacity: 0.5)
//                        }
                        
                    } label: {
                        HStack {
                            
                            Text(item.timestamp!, formatter: itemFormatter)
                            
                            Spacer()
                            
                            if item.hasEvenMinutesAndSeconds {
                                Image(systemName: "checkmark").foregroundColor(.green)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let now = Date.now
            let newItem = Item(context: viewContext)
            let index = newItem.index(ofAccessibilityElement: newItem)
            newItem.timestamp = now
            newItem.hasEvenMinutesAndSeconds = dateIsAllEven(now)
            newItem.isInEveryOther = itemIsOther(index)
            try? viewContext.save()
        }
    }
    
    private func dateIsAllEven(_ date: Date) -> Bool {
        let minutes = Calendar.current.component(.minute, from: date)
        let seconds = Calendar.current.component(.second, from: date)
        return (minutes % 2 == 0) && (seconds % 2 == 0)
    }
    
    private func itemIsOther(_ index: Int) -> Bool {
        return index % 2 != 0
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
