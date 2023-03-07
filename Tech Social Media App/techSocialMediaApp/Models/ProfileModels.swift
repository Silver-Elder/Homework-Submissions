//
//  User.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var userUUID: UUID
    var secret: UUID
    var userName: String
    
    static var current: User?
}

struct UserProfile: Codable {
    var firstName: String?
    var lastName: String?
    var userName: String?
    var userUUID: UUID?
    var bio: String?
    var techInterests: String?
    var posts: [Post]?
}

struct Post: Codable {
    var postID: Int?
    var title: String?
    var bodyText: String?
    var user: String?
    var likes: Int?
    var userLiked: Bool?
    var comments: Int?
    var createdDate: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "postid"
        case title
        case bodyText = "body"
        case user = "authorUserName"
        case likes
        case userLiked
        case comments = "numComments"
        case createdDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postID = try container.decodeIfPresent(Int.self, forKey: .postID)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.bodyText = try container.decodeIfPresent(String.self, forKey: .bodyText)
        self.user = try container.decodeIfPresent(String.self, forKey: .user)
        self.likes = try container.decodeIfPresent(Int.self, forKey: .likes)
        self.userLiked = try container.decodeIfPresent(Bool.self, forKey: .userLiked)
        self.comments = try container.decodeIfPresent(Int.self, forKey: .comments)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
    }
}

struct Comment: Codable {
    var commentID: Int?
    var body: String?
    var userName: String?
    var userID: UUID?
    var createdDate: String?
    
    /* It turns out I don't actually need this, but remembering the logic of how to do it is good!
    var date: String? {
        
        let date = Date()
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
        
        guard let year = dateComponents.year, let month = dateComponents.month, let day = dateComponents.day else { return nil }
        
        return "\(year)-\(month)-\(day)"
    }
     */
    
    enum CodingKeys: String, CodingKey {
        case commentID
        case body
        case userName
        case userID
        case createdDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.commentID = try container.decodeIfPresent(Int.self, forKey: CodingKeys.commentID)
        self.body = try container.decodeIfPresent(String.self, forKey: CodingKeys.body)
        self.userName = try container.decodeIfPresent(String.self, forKey: CodingKeys.userName)
        self.userID = try container.decodeIfPresent(UUID.self, forKey: CodingKeys.userID)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: CodingKeys.createdDate)
    }
}
