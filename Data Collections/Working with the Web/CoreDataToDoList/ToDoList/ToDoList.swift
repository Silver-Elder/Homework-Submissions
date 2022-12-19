//
//  ToDoList.swift
//  ToDoist
//
//  Created by Sterling Jenkins on 12/13/22.
//

import Foundation

extension List {
    var itemsArray: [Item] {
        let array = items?.allObjects as? [Item]
        return array ?? []
    }

    var createdAtDate: Date {
        createdAt ?? Date.distantPast
    }
    
    var createdAtString: String {
        List.relativeDateFormatter.localizedString(for: createdAtDate, relativeTo: Date())
    }
    
}

extension List {
    
    static var relativeDateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .abbreviated
        formatter.formattingContext = .beginningOfSentence
        return formatter
    }()

}
