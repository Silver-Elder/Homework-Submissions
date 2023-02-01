//
//  ViewController.swift
//  Life-Form Search
//
//  Created by Sterling Jenkins on 1/20/23.
//

import UIKit

class SearchResultDisplayViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoCreditLebel: UILabel!
    @IBOutlet weak var photoURLLabel: UILabel!
    
    @IBOutlet weak var taxonomySourceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kingdomLabel: UILabel!
    @IBOutlet weak var phylumLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    
    
    var item: GeneralSearchResult
    var navigationTitle: String
    
    init?(coder: NSCoder, item: GeneralSearchResult, navigationTitle: String) {
        self.item = item
        self.navigationTitle = navigationTitle
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.title = navigationTitle
        
        Task {
            do {
               try await detailedProfileRequest()
            } catch {
                print(error)
            }
        }
    }
    
    func detailedProfileRequest() async throws {
        let profile = try await  generalSendRequest(DetailedProfileAPIRequest(id: item.id!))
         let objects = profile.details
         
         let object = objects?.dataObjects?.first
         
         if let imageURL = object?.imageURL {
             photoURLLabel.text = "\(imageURL)"
             try await photoRequest(url: imageURL)
         } else {
             photoURLLabel.text = "Unavaiable"
         }
         
         if let credit = object?.rightsHolder {
             photoCreditLebel.text = credit
         } else if let agent = object?.agents?.first, let fullName = agent.fullName, let role = agent.role {
             photoCreditLebel.text = "\(fullName), \(role)"
             
         } else {
             photoCreditLebel.text = "Unavailable"
         }
         
         if let taxonConcept = objects?.taxonConcepts?.first, let taxonomySource = taxonConcept.nameAccordingTo, let id = taxonConcept.identifier, let scientificName = taxonConcept.scientificName {
             taxonomySourceLabel.text = taxonomySource
             nameLabel.text = scientificName
             try await classificationRequest(id: id)
         }
         
    }

    func classificationRequest(id: Int) async throws {
        let classification = try await generalSendRequest(ClassificationAPIRequest(id: id))
        
        guard let ancestors = classification.ancestors else {
            return }
        
        for ancestor in ancestors {
            guard let taxonRank = ancestor.taxonRank, let scientificName = ancestor.scientificName else { continue }
            
            switch taxonRank {
            case "kingdom":
                kingdomLabel.text = scientificName
            case "phylum":
                phylumLabel.text = scientificName
            case "class":
                classLabel.text = scientificName
            case "order":
                orderLabel.text = scientificName
            case "family":
                familyLabel.text = scientificName
            case "genus":
                genusLabel.text = scientificName
            default: continue
            }
        }
    }
    
    func photoRequest(url: URL) async throws{
        let photo = try await generalSendRequest(PhotoAPIRequest(url: url))
        profileImage.image = photo
    }

}

