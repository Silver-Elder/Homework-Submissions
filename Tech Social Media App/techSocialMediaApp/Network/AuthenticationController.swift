//
//  AuthenticationController.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

class AuthenticationController {
    
    enum AuthError: Error, LocalizedError {
        case couldNotSignIn
        case couldNotRetrieveInformation
        case couldNotSendInformation
        case couldNotDeleteInformation
    }
    
    func apiRequest<APIStruct: APIRequest>(for apiStruct: APIStruct) async throws -> APIStruct.ReturnType {
        let session = URLSession.shared
        let request = apiStruct.urlRequest!
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw apiStruct.error
        }
        
        // po (response as? HTTPURLResponse)?.statusCode
        
        let result = try apiStruct.decodeResponse(data: data)
        
        return result
    }
    
    func apiDeleteRequest<APIStruct: APIRequest>(for apiStruct: APIStruct) async throws {
        let session = URLSession.shared
        let request = apiStruct.urlRequest!
        
        let (_, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw apiStruct.error
        }
    }
    /* Brayden's API sign-in function
    /**
     Will make a request to authenticate the users credentials. If successful the User.current object will hold the signed in user.
     
     - Throws: If the user does not exist or if the API.url is invalid
     - Returns: A boolean depending on whether or not the operation was successful
     */
    func signIn(email: String, password: String) async throws -> Bool {
        // Initialize our session and request
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(API.url)/signIn")!)
        
        // Put the credentials in JSON format
        let credentials: [String: Any] = ["email": email, "password": password]
        
        // Add json data to the body of the request. Also clarify that this is a POST request
        request.httpBody = try JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        let (data, response) = try await session.data(for: request)
        
        // Ensure we had a good response (status 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw AuthError.couldNotSignIn
        }
        
        // Decode our response data to a usable User struct
        let decoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: data)
        
        User.current = user

        return true
    }
    */
}
