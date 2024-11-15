//
//  PhotoModelCacheManager.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 15/11/24.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    
    var photoCache: NSCache<NSString, UIImage> = {
        var photoCache = NSCache<NSString, UIImage> ()
        photoCache.countLimit = 200
        photoCache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return photoCache
    }()
    
    private init() { }
    
    func add(key: String, value: UIImage) {
        photoCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoCache.object(forKey: key as NSString)
    }
}
