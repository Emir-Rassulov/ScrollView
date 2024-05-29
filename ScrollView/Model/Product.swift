//
//  Product.swift
//  ScrollView
//
//  Created by Emir Rassulov on 22/05/2024.
//

import Foundation

struct Product: Hashable, Identifiable {
    var id: Self { self }

    let name: String
    let image: String
}
