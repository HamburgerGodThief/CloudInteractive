//
//  DataExtension.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/6.
//

import Foundation

extension Data {
    func decoded<T: Decodable>(asType: T.Type = T.self, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
