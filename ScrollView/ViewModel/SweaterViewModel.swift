//
//  SweaterViewModel.swift
//  ScrollView
//
//  Created by Emir Rassulov on 22/05/2024.
//

import Foundation

class SweaterViewModel: ObservableObject {
    
    @Published var sweater: Product?
    
    let sweaters: [Product] = [
        
        Product(name: "Cardigan", image: "sweater_1"),
        Product(name: "Pullover", image: "sweater_2"),
        Product(name: "Sweater Vest", image: "sweater_3"),
        Product(name: "Crew Neck", image: "sweater_4"),
        Product(name: "Turtleneck", image: "sweater_5"),
        Product(name: "Jumper", image: "sweater_6"),
        
    ]

    init() {
        sweater = sweaters[2]
    }

    func selectPrevious() {
        guard let sweater = sweater,
              let index = sweaters.firstIndex(of: sweater),
              index > 0 else { return }
        self.sweater = sweaters[index - 1]
    }

    func selectNext() {
        guard let sweater = sweater,
              let index = sweaters.firstIndex(of: sweater),
              index < sweaters.count - 1 else { return }
        self.sweater = sweaters[index + 1]
    }
}
