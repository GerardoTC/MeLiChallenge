//
//  ProductSearchResult.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation


struct ProductSearchResult: Decodable {
    let paging: ProductSearchPaging
    let products: [ProductResult]
    enum CodingKeys: String, CodingKey {
        case products = "results"
        case paging
    }
}
