//
//  CodableBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 5/11/24.
//

import SwiftUI

//Codable = Decodable + Encodable

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel = CustomerModel(id: "1", name: "Nick", points: 5, isPremium: true)
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else { return }
        
        self.customer = try! JSONDecoder().decode(CustomerModel.self, from: data)
        
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(id: "111", name: "Emily", points: 7, isPremium: false)
        
        let data = try? JSONEncoder().encode(customer)
        return data
        
//        let dictionary: [String: Any] = [
//            "id": "12345",
//            "name": "Joe",
//            "points": 6,
//            "isPremium": true
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
//        return jsonData
    }
    
}

struct CodableBootcamp: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CodableBootcamp()
    }
}
