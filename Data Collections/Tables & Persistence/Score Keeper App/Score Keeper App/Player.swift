//
//  Player.swift
//  Score Keeper App
//
//  Created by Sterling Jenkins on 11/15/22.
//

import Foundation

struct Player: Comparable, Codable {
    
    var id : UUID
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        self.id = UUID()
        self.name = name
        self.score = score
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.score > rhs.score
    }
    
    // MARK: - Data Source/Saving/Loading Code
        
        static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
        
        static func loadPlayers() -> [Player]? {
            guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
            
            let propertyListDecoder = PropertyListDecoder()
            
            return try? propertyListDecoder.decode(Array<Player>.self, from: codedToDos)
        }
        
        static func savePlayers(_ player: [Player]) {
            let propertyListEncoder = PropertyListEncoder()
            let codedToDos = try? propertyListEncoder.encode(player)
            try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
        }

}
