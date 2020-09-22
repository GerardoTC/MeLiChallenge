//
//  PredictiveSearchEntity.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct PredictiveSearchEntity: Decodable {
    var query: String
    var suggestions: [PredictiveSearchSuggestion]
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case suggestions = "suggested_queries"
    }
}

struct PredictiveSearchSuggestion: Decodable {
    var suggestion: String
    
    enum CodingKeys: String, CodingKey {
        case suggestion = "q"
    }
}
