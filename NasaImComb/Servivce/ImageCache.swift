//
//  ImageCache.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import Foundation

class ImageCache {
        
    private let cache: NSCache<NSString, NSData>
    
    init(cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()) {
        self.cache = cache
    }
        
}

extension ImageCache {
    
    func set(data: Data, url: String) {
        let key = NSString(string: url)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: key)
    }
    
    func get(url: String) -> Data? {
        let key = NSString(string: url)
        guard let object = self.cache.object(forKey: key) else { return nil }
        return Data(referencing: object)
    }
    
}

