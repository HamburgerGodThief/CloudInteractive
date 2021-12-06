//
//  PhotoAPIManager.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import Foundation

class PhotoAPIManager {
    
    func read(completion: @escaping (Result<[PhotoModel]>) -> Void) {
        
        HTTPClient.shared.sendRequest(request: PhotoAPIRequest.read, completion: { result in
            switch result {
            case .success(let data):
                
                do {
                    let resultData = try JSONDecoder().decode([PhotoModel].self, from: data)
                    
                    completion(Result.success(resultData))
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("PhotoModel keyNotFound", key, context)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("PhotoModel typeMismatch", type, context)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("PhotoModel valueNotFound", value, context)
                } catch DecodingError.dataCorrupted(let context) {
                    print("PhotoModel dataCorrupted", context)
                } catch {
                    completion(Result.failure(error))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}

