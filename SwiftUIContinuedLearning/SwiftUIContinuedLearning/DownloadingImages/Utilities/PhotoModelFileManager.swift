//
//  PhotoModelFileManager.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 15/11/24.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    var photoCache: NSCache<NSString, UIImage> = {
        var photoCache = NSCache<NSString, UIImage> ()
        photoCache.countLimit = 200
        photoCache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return photoCache
    }()
    
    private init() {
        createFolderifNeeded()
    }
    
    private func createFolderifNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("created folded")
            } catch let error {
                print("error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving to file manager: \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    
}
