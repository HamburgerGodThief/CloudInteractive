//
//  PhotoModel.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import Foundation

struct PhotoModel: Codable {
    
    let id: Int
    let title: String
    let thumbnailUrl: URL
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case thumbnailUrl
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Default"
        self.thumbnailUrl = try container.decode(URL.self, forKey: .thumbnailUrl)
    }
}
