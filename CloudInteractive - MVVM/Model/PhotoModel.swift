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
}
