//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/19/23.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title : String
    let dishDescription: String
    let price: String
    let image: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case dishDescription = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
