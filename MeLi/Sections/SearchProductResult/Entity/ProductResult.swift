//
//  ProductResultEntity.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 19/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct ProductResult: Decodable {
    let id: String
    let title: String
    let value: Int
    let imageUrl: String
    let freeShipping: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case value = "price"
        case imageUrl = "thumbnail"
        case shipping
    }
    
    enum FreeShipingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let shippingContainer = try container.nestedContainer(keyedBy: FreeShipingKeys.self, forKey: .shipping)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.value = try container.decode(Int.self, forKey: .value)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.freeShipping =  try shippingContainer.decode(Bool.self, forKey: .freeShipping)
        
    }
}
