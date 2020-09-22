//
//  ProductSearchPaging.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct ProductSearchPaging: Decodable {
    var total: Int
    var page: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "offset"
        case total
    }
}
