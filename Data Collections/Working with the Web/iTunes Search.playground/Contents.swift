import UIKit



var queryDictionary = ["term": "Apple", "media":"music", "limit": "3"]

func fetchItems(matching query: [String : String]) async throws -> [StoreItem] {
    var iTunesSearchURL = URLComponents(string: "https://itunes.apple.com/search")!
    
    enum searchError: Error, LocalizedError {
        case itemNotFound
    }

    iTunesSearchURL.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value)
    }

    let (data, response) = try await URLSession.shared.data(from: iTunesSearchURL.url!)
    
    guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
        throw searchError.itemNotFound
    }
   
    print(data.prettyPrintedJSONString())
    
    let decoder = JSONDecoder()
    
    decoder.dateDecodingStrategy = .iso8601 // ISO (International Standard Organization) has developed a standard for displaying dates (e.x. "2007-10-09T07:00:00Z" (The Z means we're in the UTC timezone, although if I wanted to adjust my timezone, I could replace the z with "+(numebr of hours)", or "-(numebr of hours)" to offset my hours from the UTC time zone)). This line of command tells the "Date" class to treat my JSON's returned date objects as dates formatted in this iso8601 format, rather than in a standard Double format.
    
    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
    
    return searchResponse.results
}

Task {
    do {
        let storeItems = try await fetchItems(matching: queryDictionary)
        storeItems.forEach { item in
            print("""
            Artist Name: \(item.artistName)
            Artwork URL: \(item.artworkURL)
            Release Date: \(item.releaseDate)
            Treack Name: \(item.trackName)
            Track Time: \(item.trackTime / 1000 / 60)m
            
            
            """)
        }
        
    } catch {
        print(error)
    }
}

struct StoreItem: Codable {
    var artistName: String
    var artworkURL: URL
    var releaseDate: Date
    var trackName: String
    var trackTime: Double
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case artworkURL = "artworkUrl60"
        case releaseDate
        case trackName
        case trackTime = "trackTimeMillis"
    }
        
    // Let's create a custom initializer for fun!!!
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
        releaseDate = try values.decode(Date.self, forKey: CodingKeys.releaseDate)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        trackTime = try values.decode(Double.self, forKey: CodingKeys.trackTime)
    }
    
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try?
               JSONSerialization.jsonObject(with: self,
               options: []),
            let jsonData = try?
               JSONSerialization.data(withJSONObject:
               jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData,
               encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}

//Pick up on p.427 Step 3
