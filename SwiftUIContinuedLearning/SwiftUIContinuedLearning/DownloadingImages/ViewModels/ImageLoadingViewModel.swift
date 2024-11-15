//
//  ImageLoadingViewModel.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 15/11/24.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    
//    let manager = PhotoModelCacheManager.instance
    let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(urlString: String, key: String) {
        self.urlString = urlString
        self.imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
    }
    
    func downloadImage() {
        
        self.isLoading = true
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self]  (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self, let image = returnedImage else { return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

    }
}
