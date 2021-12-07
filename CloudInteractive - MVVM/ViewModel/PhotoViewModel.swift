//
//  PhotoViewModel.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/6.
//

import UIKit
import Foundation

class PhotoViewModel {
    
    var photos: [PhotoModel] = []
    
    var imageCache = NSCache<NSURL, UIImage>()
    
    var imageEtag: [Int: String] = [:]
    
    func readAPI(completion: @escaping () -> Void ) {
        let photoAPIManager = PhotoAPIManager()
        photoAPIManager.read(completion: { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                completion()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func urlToImage(index: Int, completion: @escaping (UIImage) -> Void) {
        
        if let image = imageCache.object(forKey: photos[index].thumbnailUrl as NSURL) {
            completion(image)
            return
        }
        
        let imageHandler = ImageHandler()
        
        imageHandler.readImage(url: photos[index].thumbnailUrl, etag: imageEtag[index] ?? "", completion: { [weak self] (data, etag) in
            guard let strongSelf = self else { return }
            guard let image = UIImage(data: data) else { return }
            strongSelf.imageCache.setObject(image, forKey: strongSelf.photos[index].thumbnailUrl as NSURL)
            strongSelf.imageEtag[index] = etag
            completion(image)
        })
        
    }
}
