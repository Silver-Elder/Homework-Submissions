import UIKit

var iTunesSearchURL = URL(string: "https://itunes.apple.com/search?")!

let queryDictionary = ["term": "Lindsey+Sterling", "media":"music", "limit": "1"]

let iTunesURLComponents = queryDictionary.map { URLQueryItem(name: $0.key, value: $0.value)
}

iTunesSearchURL = iTunesSearchURL.appending(queryItems: iTunesURLComponents)

Task {
    let (data, response) = try await URLSession.shared.data(from: iTunesSearchURL)
    if let httpResonse = response as? HTTPURLResponse, httpResonse.statusCode == 200, let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}
