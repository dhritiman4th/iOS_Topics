//
//  HttpClient.swift
//  CDNSFetchedResultController
//
//  Created by Dhritiman Saha on 26/01/24.
//

import Foundation

struct HttpClient {
    
    var defaultHeader: [String: String] = ["ContentType": "application/json"]
    
    func loadRequestWith<T: Codable>(resource: Resource<T>, completion: @escaping (T?, Error?)-> Void) {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .GET(let queryItems):
            var components =  URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            
            guard let url = components?.url else {
                completion(nil, NetworkErrors.badRequest)
                return
            }
            
            request = URLRequest(url: url)
            request.httpMethod = resource.method.name
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = defaultHeader
        
        let session = URLSession(configuration: sessionConfiguration)
        print("\n-----")
        print("URL = \(String(describing: request.url))")
        print("METHOD = \(request.httpMethod ?? "")")
        print("HEADERS = \(defaultHeader)")
        print("BODY = \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")")
        print("-----\n")

        session.dataTask(with: request) { data, response, error in
            guard let _ = response as? HTTPURLResponse else {
                completion(nil, NetworkErrors.invalidResponse)
                return
            }
            guard let data = data else {
                completion(nil, NetworkErrors.invalidResponse)
                return
            }
            guard let countryList = try? JSONDecoder().decode(resource.model, from: data) else {
                completion(nil, NetworkErrors.decodingError)
                return
            }
            return completion(countryList, nil)
        }.resume()
    }
}

struct Resource<T: Codable> {
    var url: URL
    var method: HttpMethods
    var model: T.Type
}

enum HttpMethods {
    case GET([URLQueryItem])
    
    var name: String {
        switch self {
        case .GET: return "GET"
        }
    }
}

enum NetworkErrors: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
    
    var errorDescription: String {
        switch self {
        case .badRequest:
            return NSLocalizedString("BAD_REQUEST", comment: "Bad request!!!")
        case .serverError(let errorMessage):
            return NSLocalizedString("SERVER_ERROR", comment: errorMessage)
        case .decodingError:
            return NSLocalizedString("DECODING_ERROR", comment: "Decoding error!!!")
        case .invalidResponse:
            return NSLocalizedString("INVALID_RESPONSE", comment: "Invalid response!!!")
        }
    }
}


