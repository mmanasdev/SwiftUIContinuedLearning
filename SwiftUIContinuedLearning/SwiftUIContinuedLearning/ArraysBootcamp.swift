//
//  ArraysBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 21/10/24.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 0, isVerified: false)
        let user3 = UserModel(name: nil, points: 20, isVerified: true)
        let user4 = UserModel(name: "Emily", points: 50, isVerified: false)
        let user5 = UserModel(name: "Samantha", points: 45, isVerified: true)
        let user6 = UserModel(name: "Jason", points: 23, isVerified: false)
        let user7 = UserModel(name: "Sarah", points: 76, isVerified: true)
        let user8 = UserModel(name: nil, points: 45, isVerified: false)
        let user9 = UserModel(name: "Steve", points: 1, isVerified: true)
        let user10 = UserModel(name: "Amanda", points: 100, isVerified: false)
        
        self.dataArray.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10])
    }
    
    func updateFilteredArray() {
        // sort
        /*
        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
            return user1.points > user2.points
        }
        
        filteredArray = dataArray.sorted { $0.points > $1.points }
         */
        
        // filter
        /*
        filteredArray = dataArray.filter({ user in
            return user.points > 50
        })
        
        filteredArray = dataArray.filter { $0.points > 50 }
        */
        
        // map
        /*
        mappedArray = dataArray.map({ user -> String in
            return user.name
        })
        
        mappedArray = dataArray.map { $0.name }
        */
        
        // compact
        /*
        mappedArray = dataArray.compactMap({ user -> String? in
            return user.name
        })
        
        mappedArray = dataArray.compactMap { $0.name }
        */
        /*
        let sort = dataArray.sorted { $0.points > $1.points }
        let filter = dataArray.filter { $0.isVerified }
        let map = dataArray.compactMap { $0.name }
        */
        mappedArray = dataArray
            .sorted { $0.points > $1.points }
            .filter { $0.isVerified }
            .compactMap { $0.name }
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack {
//                        Text(user.name)
//                            .font(.headline)
//
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
