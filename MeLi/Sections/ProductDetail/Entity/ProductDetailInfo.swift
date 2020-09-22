//
//  ProductDetailInfo.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct ProductDetailInfo: Decodable {
    let pictures: [ProductPicture]
}

struct ProductPicture: Decodable {
    let url: String
    let secureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case url
        case secureUrl = "secure_url"
    }
}
