//
//  MultipleSheetsBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 17/10/24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 .- use a binding
// 2 .- use multiple .sheets
// 3 .- use $item

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
//    @State var showSheet: Bool = false
//    @State var showSheet2: Bool = false//2
    
    var body: some View {
        /*
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            }//2
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")//2
//                showSheet2.toggle()
            }
//            .sheet(isPresented: $showSheet2) {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            }//2
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: selectedModel)//$selectedModel)//1
//        }
        
        */
        
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
        
    }
}

struct NextScreen: View {
    
//    @Binding var selectedModel: RandomModel//1
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
