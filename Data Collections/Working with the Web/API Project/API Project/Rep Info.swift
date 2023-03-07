//
//  Rep.swift
//  API Project
//
//  Created by Sterling Jenkins on 12/6/22.
//

import Foundation

struct RepInfo: Codable {
    var name: String
    var party: String
    var state: String
    var website: URL
    
    enum CodingKeys: String, CodingKey {
        case name, party, state, website = "link"
    }
    
}

struct SearchResults: Codable {
    let results: [RepInfo]
}
