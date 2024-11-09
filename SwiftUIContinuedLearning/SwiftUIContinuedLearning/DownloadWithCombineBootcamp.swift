//
//  DownloadWithCombineBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 9/11/24.
//

import SwiftUI
import Combine

// Combine discussion:
/*
 // 1. sign up for monthly subscription for package to be delivered
 // 2. the company would make the package behing the scene
 // 3. recieve the package at your front door
 // 4. make sure the box isn't damage
 // 5. open and make sure the item is correct
 // 6. use the item!!
 // 7. cancellable at any time!
 
 // 1. create the publisher
 // 2. subscribe publisher on background thread
 // 3. receive on main thread
 // 4. tryMap (check that the data is good)
 // 5. decode (decode data into PostModels)
 // 6. sink (put the item into our app)
 // 7. store (cancel subscription if needed)
 */

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap (handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("failure: \(error.localizedDescription)")
//                }
//            } receiveValue: { [weak self] returnedPosts in
//                self?.posts = returnedPosts
//            }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}
