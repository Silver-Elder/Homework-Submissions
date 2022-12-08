//
//  Rep Controller.swift
//  API Project
//
//  Created by Sterling Jenkins on 12/6/22.
//

import Foundation

func fetchRepsArray(matching query: [String : String]) async throws -> [RepInfo] {
    
    enum searchError: Error {
        case itemNotFound
    }
    
    var repsSearchURL = URLComponents(string: "https://whoismyrepresentative.com/getall_mems.php")!
    
    repsSearchURL.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
    
    let (data, response) = try await URLSession.shared.data(from: repsSearchURL.url!)
    
    guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
        throw searchError.itemNotFound
    }
    
    let searchResponse = try JSONDecoder().decode(SearchResults.self, from: data)
    
    return searchResponse.results
}
