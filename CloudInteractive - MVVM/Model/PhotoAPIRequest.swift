//
//  PhotoAPIRequest.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import Foundation

enum PhotoAPIRequest: APIRequest {
    
    case read
    
    var header: [String : String] {
        switch self {
        case .read:
        return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? { return nil }
    
    var method: String { return "GET" }
    
}
