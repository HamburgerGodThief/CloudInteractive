//
//  ImageHandler.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/6.
//

import Foundation

class ImageHandler {
    
    private func makeImageRequest(url: URL, etag: String) -> URLRequest{
        var request = URLRequest(url: url)
        let header: [String : String] = ["Content-Type": "application/json", "If-None-Match": etag]
        let body: Data? = nil
        let method: String = "GET"
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.httpMethod = method
        return request
    }
    
    func readImage(url:URL, etag: String, completion: @escaping (Data, String) -> Void) {
        
        URLSession.shared.dataTask(with: makeImageRequest(url: url, etag: etag), completionHandler: {(data, response, error) in
            guard error == nil else { return }
            
            let httpResponse = response as! HTTPURLResponse
            
            guard let etag = httpResponse.allHeaderFields["Etag"] as? String else { return }
            
            guard let data = data else { return }
            
            completion(data, etag)

        }).resume()
    }
}
