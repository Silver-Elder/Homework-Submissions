//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Sterling Jenkins on 10/18/22.
//

import Foundation

let documentsDirectory =
   FileManager.default.urls(for: .documentDirectory,
   in: .userDomainMask).first!
/*
    (Notes form book on what's happening here ^^^)
 Option-click the urls method to view its declaration. You can see that the function returns an array of URLs for the specified directory in the requested domains. For a list of available iOS directories, check out the documentation for the FileManager.SearchPathDirectory enumeration.
 For this lesson, you're interested in the .documentDirectory—which you'll pass as the search parameter. The .userDomainMask refers to the user's home folder, the folder that holds the user's apps and all their data.
 The result of the function you entered above is an array of URL objects, which point to the directories that match your search. But there's only one Documents directory, so you request the first result of the search to assign to the variable.
 */


struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveURL = documentsDirectory.appendingPathComponent("emojis")
        .  appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]) {
        let emojis = try? PropertyListEncoder().encode(emojis)
        try? emojis?.write(to: archiveURL, options: .noFileProtection)
        // based on p.171
    }
    
    static func loadFromFile() -> [Emoji] {
        guard let retrivedEmojiData = try? Data(contentsOf: archiveURL), let decodedEmoji = try? PropertyListDecoder().decode([Emoji].self, from: retrivedEmojiData) else { return sampleEmojis }
            // based on p.171
            
        return decodedEmoji
    }
    
    static var sampleEmojis = EmojiTableViewController().emojis
}

// Pick up on p.173
