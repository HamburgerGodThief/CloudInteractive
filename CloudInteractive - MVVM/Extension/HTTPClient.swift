//
//  HTTPClient.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import Foundation

enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum BG_HTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

protocol APIRequest {
    
    var header: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
}

extension APIRequest {
    
    func makeRequest() -> URLRequest {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.httpMethod = method
        return request
    }
    
}


class HTTPClient {
    
    static let shared = HTTPClient()
    
    private init () {}
    
    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()
    
    func sendRequest(request: APIRequest, completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(with: request.makeRequest(), completionHandler: {(data, response, error) in
            guard error == nil else {
                return completion(Result.failure(error!))
            }
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode

            switch statusCode {

            case 200..<300:
                
                completion(Result.success(data!))

            case 400..<500:

                completion(Result.failure(BG_HTTPClientError.clientError(data!)))

            case 500..<600:

                completion(Result.failure(BG_HTTPClientError.serverError))

            default: return

                completion(Result.failure(BG_HTTPClientError.unexpectedError))
            }
        }).resume()
        
    }
    
}
