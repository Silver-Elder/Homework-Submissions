//
//  Serch Result Profile.swift
//  Life-Form Search
//
//  Created by Sterling Jenkins on 1/20/23.
//

import Foundation
import UIKit

/* General Search
 var urlComponents = URLComponents(string:
    "https://eol.org/api/search/1.0.json")!

 urlComponents.queryItems = [URLQueryItem(name: <#T##String#>, value: <#T##String?#>)]
 
 "You're only interested in the results array along with the id, title, and content elements of each dictionary in the array. You'll want to create structs that conform to Codable to decode this data. (Hint: It might be helpful to map title to a variable in your struct called scientificName and content to a variable called commonName so they are more identifiable when you use them later.)" (p.602)

 */

struct GeneralSearchAPIRequest: APIRequest {
    
    var apiKey: String
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string:
           "https://eol.org/api/search/1.0.json")!
        urlComponents.queryItems = [URLQueryItem(name: "q", value: apiKey), URLQueryItem(name: "page", value: "1")]

        return URLRequest(url: urlComponents.url!)
    }

    func decodeResponse(data: Data) throws -> GeneralSearchResults {
        let generalSearchResults = try JSONDecoder().decode(GeneralSearchResults.self,
           from: data)
        return generalSearchResults
    }
}

struct GeneralSearchResults: Codable {
    var results: [GeneralSearchResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decodeIfPresent([GeneralSearchResult].self, forKey: .results) ?? []
    }
    
    
}

struct GeneralSearchResult: Codable, Hashable {
    var id: Int?
    var title: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}


/* Detailed Result
 var id: String
 var urlComponents = URLComponents(string:
    "https://eol.org/api/pages/1.0/\(id).json")!
 
 urlComponents.queryItems = [URLQueryItem(name: <#T##String#>, value: <#T##String?#>)]
 
 (See p.605 for uses)
*/

struct DetailedProfileAPIRequest: APIRequest {
    var id: Int
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string:
           "https://eol.org/api/pages/1.0/\(id).json")!
        urlComponents.queryItems = [URLQueryItem(name: "taxonmy", value: "true"), URLQueryItem(name: "images_per_page", value: "1"), URLQueryItem(name: "language", value: "en")]

        return URLRequest(url: urlComponents.url!)
    }

    func decodeResponse(data: Data) throws -> DetailedProfileResults {
        let detailedSearchResults = try JSONDecoder().decode(DetailedProfileResults.self,
           from: data)
        return detailedSearchResults
    }
}

struct DetailedProfileResults: Codable {
    var details: DataObjects?
    
    enum CodingKeys: String, CodingKey {
        case details = "taxonConcept"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.details = try container.decodeIfPresent(DataObjects.self, forKey: .details)
    }
}

struct DataObjects: Codable {
    var dataObjects: [DataObject]?
    var taxonConcepts: [TaxonConcept]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dataObjects = try container.decodeIfPresent([DataObject].self, forKey: .dataObjects)
        self.taxonConcepts = try container.decodeIfPresent([TaxonConcept].self, forKey: .taxonConcepts)
    }
}

struct DataObject: Codable {
    var imageURL: URL?
    var imageFormat: String?
    var rightsHolder: String?
    var agents: [Agents]?
    
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "eolMediaURL"
        case imageFormat = "mimeType"
        case rightsHolder
        case agents
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
        self.imageFormat = try container.decodeIfPresent(String.self, forKey: .imageFormat)
        self.rightsHolder = try container.decodeIfPresent(String.self, forKey: .rightsHolder)
        self.agents = try container.decodeIfPresent([Agents].self, forKey: .agents)
    }
}

struct Agents: Codable {
    var role: String?
    var fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case role
        case fullName = "full_name"
    }
}

struct TaxonConcept: Codable {
    var nameAccordingTo: String?
    var identifier: Int?
    var scientificName: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nameAccordingTo = try container.decode(String.self, forKey: .nameAccordingTo)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.scientificName = try container.decode(String.self, forKey: .scientificName)
    }
    
}

/* Classification Result
 var id: String
 var urlComponents = URLComponents(string:
    "https://eol.org/api/hierarchy_entries/1.0/\(id).json?language=en")!
 
 urlComponents.queryItems = [URLQueryItem(name: <#T##String#>, value: <#T##String?#>)]
 
 “When you decode the results of your API request, you'll be interested in the ancestors array as well as the taxonRank and scientificName within each dictionary contained in the array. Keep in mind that the taxonRank keys might not be available in the dictionary, so using an optional is appropriate. You can use as many of the entries in the ancestors array as you like, but you might want to limit what you display to kingdom, phylum, class, order, family, and genus” (p.608)
 */

struct ClassificationAPIRequest: APIRequest {
    var id: Int
    
    var urlRequest: URLRequest {
        let urlComponents = URLComponents(string:
           "https://eol.org/api/hierarchy_entries/1.0/\(id).json?language=en")!

        return URLRequest(url: urlComponents.url!)
    }

    func decodeResponse(data: Data) throws -> Classification {
        let detailedSearchResults = try JSONDecoder().decode(Classification.self,
           from: data)
        return detailedSearchResults
    }
}

struct Classification: Codable {
    var ancestors: [Ancestors]?
}

struct Ancestors: Codable {
    var taxonRank: String?
    var scientificName: String?
}

struct PhotoAPIRequest: APIRequest {
    var url: URL

    var urlRequest: URLRequest {
        return URLRequest(url: url)
    }

    func decodeResponse(data: Data) throws -> UIImage {
        guard let photo = UIImage(data: data) else {
            throw APIRequestError.imageMissing
        }
        return photo
    }
}
