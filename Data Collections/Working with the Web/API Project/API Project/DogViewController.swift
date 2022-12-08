//
//  ViewController.swift
//  API Project
//
//  Created by Sterling Jenkins on 12/6/22.
//

import UIKit

class DogViewController: UIViewController {

    @IBOutlet weak var dogPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                dogPhoto.image = try await fetchImage(from: fetchItems().url)
            } catch {
                dogPhoto = nil
            }
        }
    }

    @IBAction func newPhotoButtonTapped() {
        dogPhoto.image = UIImage(named: "pawprint.circle")
        
        Task {
            do {
                dogPhoto.image = try await fetchImage(from: fetchItems().url)
            } catch {
                dogPhoto = nil
            }
        }
    }
    
}

extension DogViewController {
    struct Dog: Codable {
        var url: URL
        var status: String
        
        enum CodingKeys: String, CodingKey {
            case url = "message"
            case status
        }
    }
}

extension DogViewController {
    enum DogPhotoError: Error, LocalizedError {
        case imageDataMissing
    }
    
    func fetchItems() async throws -> Dog {
        
        enum searchError: Error, LocalizedError {
            case itemNotFound
        }
        
        var searchURL = URL(string: "https:dog.ceo/api/breeds/image/random")!
        
        let (data, response) = try await URLSession.shared.data(from: searchURL)
        
        guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
            throw searchError.itemNotFound
        }
        
        let decoder = JSONDecoder()
        
        let searchResponse = try decoder.decode(Dog.self, from: data)
        
        return searchResponse
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
    
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DogPhotoError.imageDataMissing
        }
    
        guard let image = UIImage(data: data) else {
            throw DogPhotoError.imageDataMissing
        }
    
        return image
    }
}
