//
//  CatalogAPIProvider.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Foundation

typealias CompletionCallback = ((Result<Data, Error>) -> Void)

class CatalogAPIProvider: CatalogAPIProtocol {
    
    func items(sinceID: String? = nil, maxID: String? = nil, completion: @escaping CompletionCallback) {
        let provider = MarloveAPIProvider.shared.sessionManager
        let endpoint = "/items"
        
        let queryParams: [String: String?] = [
            "since_id" : sinceID,
            "max_id" : maxID
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = MarloveAPIProvider.shared.scheme
        urlComponents.host = MarloveAPIProvider.shared.host
        urlComponents.path = MarloveAPIProvider.shared.path + endpoint
        urlComponents.setQueryItems(with: queryParams)
        
        guard let urlString = urlComponents.url?.absoluteString, let url = URL(string: urlString) else {
            completion(.failure(CustomError.generic))
            
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = provider.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? CustomError.generic))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func removeItem(withID id: String, completion: @escaping CompletionCallback) {
        let provider = MarloveAPIProvider.shared.sessionManager
        let endpoint = "/item/" + id
        
        var urlComponents = URLComponents()
        urlComponents.scheme = MarloveAPIProvider.shared.scheme
        urlComponents.host = MarloveAPIProvider.shared.host
        urlComponents.path = MarloveAPIProvider.shared.path + endpoint
        
        guard let urlString = urlComponents.url?.absoluteString, let url = URL(string: urlString) else {
            completion(.failure(CustomError.generic))
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let task = provider.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? CustomError.generic))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func removeAllItems(completion: @escaping CompletionCallback) {
        let provider = MarloveAPIProvider.shared.sessionManager
        let endpoint = "/item"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = MarloveAPIProvider.shared.scheme
        urlComponents.host = MarloveAPIProvider.shared.host
        urlComponents.path = MarloveAPIProvider.shared.path + endpoint
        
        guard let urlString = urlComponents.url?.absoluteString, let url = URL(string: urlString) else {
            completion(.failure(CustomError.generic))
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let task = provider.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? CustomError.generic))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func addItem(json: [String: AnyObject], completion: @escaping CompletionCallback) {
        let provider = MarloveAPIProvider.shared.sessionManager
        let endpoint = "/item"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = MarloveAPIProvider.shared.scheme
        urlComponents.host = MarloveAPIProvider.shared.host
        urlComponents.path = MarloveAPIProvider.shared.path + endpoint
        
        guard let urlString = urlComponents.url?.absoluteString, let url = URL(string: urlString) else {
            completion(.failure(CustomError.generic))
            
            return
        }
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed) else {
            completion(.failure(CustomError.generic))
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        let task = provider.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? CustomError.generic))
                
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
