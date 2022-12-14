//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation
import CoreData

class ItemManager {
    static let shared = ItemManager()
    
    private let context = PersistenceController.shared.viewContext
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
//
//    var allItems = [Item]()
//    var items: [Item] {
//        allItems.filter { $0.completedAt == nil }.sorted(by: { $0.sortDate >  $1.sortDate })
//    }
//    var completedItems: [Item] {
//        allItems.filter { $0.completedAt != nil }.sorted(by: { $0.sortDate >  $1.sortDate })
//    }

    
    // Funcs
    
    func createNewItem(with title: String, list: List) {
        let newItem = Item(context: PersistenceController.shared.viewContext)
        
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        newItem.list = list
        
        PersistenceController.shared.saveContext()
//        saveContext()
    }
    
    
    func toggleItemCompletion(_ item: Item) {
        item.completedAt = item.isCompleted ? nil : Date()
        PersistenceController.shared.saveContext()
    }
    
    /*
    func delete(at indexPath: IndexPath) {
//        remove(item(at: indexPath))
        ItemManager.shared.remove(item(at: indexPath))
    }
    */
    
    func delete(_ item: Item) {
        let context = PersistenceController.shared.viewContext
        context.delete(item)
        PersistenceController.shared.saveContext()
    }
    
/*
    private func item(at indexPath: IndexPath) -> Item {
        let items = indexPath.section == 0 ? fetchItems(completed: false) : fetchItems(completed: true)
        return items[indexPath.row]
    }
 */

    func fetchItems(of list: List, completed: Bool) -> [Item] {
        
        let items = list.itemsArray.filter({$0.isCompleted == completed})
        
        
        // Create a varible that defines how you want the items to be sorted, and assign that property to your fetch request
    
        return items.sorted(by: {$0.sortDate > $1.sortDate})
    }
    
}

/* Old Items Fetch Function:
 func fetchItems(completed: Bool) -> [Item] {

     
     // Next, add the predicate for either incomplete or complete
     let completedAtValue = completed ? "completedAt != nil" : "completedAt == nil"
     fetchRequest.predicate = NSPredicate(format: completedAtValue)
     
     // Then, create an instance of our Persistence Controller's view context
     let context = PersistenceController.shared.viewContext
     
     // Create a varible that defines how you want the items you will fetch to be sorted, and assign that property to your fetch request
     let sortByAscending = NSSortDescriptor(key: "createdAt", ascending: true)
     fetchRequest.sortDescriptors = [sortByAscending]
     
     // Now, execute the fetch request on the context
     
     let fetchedItems = try? context.fetch(fetchRequest)
 
     return fetchedItems ?? []
 }
 
 
 */
