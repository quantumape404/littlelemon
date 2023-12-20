//
//  MenuList.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/19/23.
//

import Foundation
import CoreData


struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
}
