//
//  SearchController.swift
//  Life-Form Search
//
//  Created by Sterling Jenkins on 1/20/23.
//

import Foundation

protocol APIRequest {
    associatedtype Response
    
    var urlRequest: URLRequest { get }
    func decodeResponse(data: Data) throws -> Response
}

enum APIRequestError: Error {
    case itemNotFound
    case imageMissing
}

func generalSendRequest<Request: APIRequest>(_ request: Request) async
   throws -> Request.Response {
    let (data, response) = try await URLSession.shared.data(for:
       request.urlRequest)

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw APIRequestError.itemNotFound
    }
       
    data.prettyPrintedJSONString()

    let decodedResponse = try request.decodeResponse(data: data)
    return(decodedResponse)
}

extension Data {
    func prettyPrintedJSONString() {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
            let prettyJSONString = String(data: jsonData, encoding: .utf8) else {
                print("Failed to read JSON Object.")
                return
        }
        print(prettyJSONString)
    }
}

