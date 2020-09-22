//
//  ProductDetailDescription.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct ProductDetailDescription: Decodable {
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description = "plain_text"
    }
}
