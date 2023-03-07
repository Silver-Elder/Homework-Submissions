//
//  API.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

struct API {
    static var url = "https://tech-social-media-app.fly.dev"
}

protocol APIRequest {
    associatedtype ReturnType
    var urlRequest: URLRequest? { get }
    var error: Error { get }
    func decodeResponse(data: Data) throws -> ReturnType
}

struct SignInRequest: APIRequest {
    
    var email: String
    var password: String
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSignIn
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/signIn")!)
        
        // Put the credentials in JSON format
        let credentials: [String: Any] = ["email": email, "password": password]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
        do {
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Bool {
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)
        
        User.current = user
        
        return true
    }
    
}

//MARK: - Profile APIs

struct UserProfileRequest: APIRequest {
    
    var currentUser = User.current
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotRetrieveInformation
    }
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string: "\(API.url)/userProfile")!
        
            guard let userUUID = currentUser?.userUUID, let secret = currentUser?.secret else { return nil }
        
        urlComponents.queryItems = [URLQueryItem(name: "userUUID", value: "\(userUUID)"), URLQueryItem(name: "userSecret", value: "\(secret)")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> UserProfile {
        let decoder = JSONDecoder()
        let userProfile = try decoder.decode(UserProfile.self, from: data)
        
        return userProfile
    }
    
}

struct UpdateUserProfile: APIRequest {
    
    var userSecret = User.current?.secret
    var userName: String
    var bio: String
    var techInterests: String
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSendInformation
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/updateProfile")!)
        
        do {
        
            guard let secret = userSecret else { return nil }
            // Put the credentials in JSON format
            let credentials: [String: Any] = ["userSecret": secret, "profile": [
                "userName": userName,
                "bio": bio,
                "techInterests": techInterests]
                ]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Bool {
        let decoder = JSONDecoder()
        let success = try decoder.decode(Bool.self, from: data)
        
        return success
    }
    
}

//MARK: - Post APIs

struct RetrievePostsForAllUsers: APIRequest {
    
    
    var userSecret = User.current?.secret
    
    var pageNumber: Int?
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotRetrieveInformation
    }
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string:  "\(API.url)/posts")!
        guard let secret = userSecret else { return nil }
        // Put the credentials in JSON format
        urlComponents.queryItems = [ URLQueryItem(name:  "userSecret", value: "\(secret)"), URLQueryItem(name: "pageNumber", value: "\(pageNumber ?? 0)")]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)
        
        return posts
    }
    
}

struct CreateUserPost: APIRequest {
    
    var userSecret = User.current?.secret
    var title: String
    var body: String
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSendInformation
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/createPost")!)
        
        do {
        
            guard let secret = userSecret else { return nil }
            // Put the credentials in JSON format
            let credentials: [String: Any] = [
                "userSecret": "\(secret)",
                "post": [
                    "title": title,
                    "body": body
                ]
            ]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Post {
        let decoder = JSONDecoder()
        let newPost = try decoder.decode(Post.self, from: data)
        
        return newPost
    }
    
}

struct SetUserLikeForPost: APIRequest {
    
    var userSecret = User.current?.secret
    var forPost: Post
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSendInformation
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/updateLikes")!)
        
        do {
        
            guard let secret = userSecret, let postID = forPost.postID else { return nil }
            // Put the credentials in JSON format
            let credentials: [String: Any] = [
                "userSecret": secret,
                "postid": postID
            ]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Post {
        let decoder = JSONDecoder()
        let postLikedByUserUpdate = try decoder.decode(Post.self, from: data)
        
        return postLikedByUserUpdate
    }
    
}

struct RetrieveUsersPosts: APIRequest {
    
    var currentUser = User.current
    var pageNumber: Int?
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotRetrieveInformation
    }
    
    var urlRequest: URLRequest? {
        
        var urlComponents = URLComponents(string:  "\(API.url)/userPosts")!
        guard let secret = currentUser?.secret, let userUUID = currentUser?.userUUID else { return nil }
        // Put the credentials in JSON format
        urlComponents.queryItems = [ URLQueryItem(name:  "userSecret", value: "\(secret)"), URLQueryItem(name: "userUUID", value: "\(userUUID)"), URLQueryItem(name: "pageNumber", value: "\(pageNumber ?? 0)")]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        let usersPosts = try decoder.decode([Post].self, from: data)
        
        return usersPosts
    }
    
}

struct DeleteUserPost: APIRequest {
    
    var userSecret = User.current?.secret
    var forPost: Post
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotDeleteInformation
    }
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string: "\(API.url)/post")!
            
        guard let secret = userSecret, let postID = forPost.postID else { return nil }
             
        urlComponents.queryItems = [URLQueryItem(name: "userSecret", value: "\(secret)"), URLQueryItem(name: "postid", value: "\(postID)")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Void {
    }
    
}

struct EditUserPost: APIRequest {
    
    var userSecret = User.current?.secret
    var postID: Int
    var title: String
    var body: String
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSendInformation
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/editPost")!)
        
        do {
        
            guard let secret = userSecret else { return nil}
            // Put the credentials in JSON format
            let credentials: [String: Any] = [
                "userSecret": "\(secret)",
                "post": [
                    "postid": postID,
                    "title": title,
                    "body": body
                ]
            ]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> [String: String] {
        let decoder = JSONDecoder()
        let success = try decoder.decode([String: String].self, from: data)
        
        return success
    }
    
}

//MARK: - Comments APIs

struct RetrieveComments: APIRequest {
    
    var userSecret = User.current?.secret
    var forPost: Post
    var pageNumber: Int?
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotRetrieveInformation
    }
    
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents(string: "\(API.url)/comments")!
        
        guard let secret = userSecret, let postID = forPost.postID  else { return nil }
        
        urlComponents.queryItems = [URLQueryItem(name: "userSecret", value: "\(secret)"), URLQueryItem(name: "postid", value: "\(postID)"), URLQueryItem(name: "pageNumber", value: "\(pageNumber ?? 0)")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> [Comment] {
        let decoder = JSONDecoder()
        let comments = try decoder.decode([Comment].self, from: data)
        
        return comments
    }
    
}

struct CreateComment: APIRequest {
    
    var userSecret = User.current?.secret
    var commentBody: String
    var forPost: Post
    
    var error: Error {
        return AuthenticationController.AuthError.couldNotSendInformation
    }
    
    var urlRequest: URLRequest? {
        var request = URLRequest(url: URL(string: "\(API.url)/createComment")!)
        
        do {
        
            guard let secret = userSecret, let postID = forPost.postID else { return nil }
            // Put the credentials in JSON format
            let credentials: [String: Any] = [
                "userSecret": "\(secret)",
                "commentBody": commentBody,
                "postid": postID
            ]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
            request.httpBody =  try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        } catch {
            print(error)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func decodeResponse(data: Data) throws -> Comment {
        let decoder = JSONDecoder()
        let newComment = try decoder.decode(Comment.self, from: data)
        
        return newComment
    }
    
}

