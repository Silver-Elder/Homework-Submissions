//
//  ToDoListManager.swift
//  ToDoist
//
//  Created by Sterling Jenkins on 12/15/22.
//

import Foundation

class ListManager {
    static let shared = ListManager()
    
    func createNewList(with title: String) -> List {
        let newList = List(context: PersistenceController.shared.viewContext)
        
        newList.id = UUID().uuidString
        newList.title = title
        newList.createdAt = Date()
        newList.modifiedAt = nil
        
        PersistenceController.shared.saveContext()
        
        return newList
    }
    
    /*
    func updateList(_ returnedList: List, indexPath: IndexPath) {
        let oldList = list(at: indexPath)
        if oldList != returnedList {
            list(at: indexPath).itemsArray = returnedList.itemsArray
            
            PersistenceController.shared.saveContext()
        }
    }
    */
     
    func delete(at indexPath: IndexPath) {
//        remove(item(at: indexPath))
        ListManager.shared.remove(list(at: indexPath))
    }
    
    
    func remove(_ list: List) {
        let context = PersistenceController.shared.viewContext
        context.delete(list)
        PersistenceController.shared.saveContext()
    }
    
    func list(at indexPath: IndexPath) -> List {
        let lists = fetchLists()
        return lists[indexPath.row]
    }

    func fetchLists() -> [List] {
        // First, create the fetch request
        let fetchRequest = List.fetchRequest()
        
        // Then, create an instance of our Persistence Controller's view context
        let context = PersistenceController.shared.viewContext
        
        // Create a varible that defines how you want the items you will fetch to be sorted, and assign that property to your fetch request
        let sortByAscending = NSSortDescriptor(key: "modifiedAt", ascending: true)
        fetchRequest.sortDescriptors = [sortByAscending]
        
        // Now, execute the fetch request on the context
        
        let fetchedLists = try? context.fetch(fetchRequest)
    
        return fetchedLists ?? []
    }
}
