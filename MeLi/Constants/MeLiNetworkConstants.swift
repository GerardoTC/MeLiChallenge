//
//  MeLiNetworkConstants.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation


struct MeLiNetworkConstants {
    
    static var defaultHost = "api.mercadolibre.com"
    static var defaultScheme = "https"
    static var defaultSite = "MCO"
    
    enum Endpoints {
        
        case autoSuggest(site: String = MeLiNetworkConstants.defaultSite, query: String)
        case productSearch(site: String = MeLiNetworkConstants.defaultSite, query: String, page: String)
        case productImages(id: String)
        case productDescription(id: String)
        
        private var path: String {
            switch self {
            case .autoSuggest(let site, _):
                return  "/sites/\(site)/autosuggest"
            case .productSearch(let site, _, _):
                return "/sites/\(site)/search"
            case .productImages(let id):
                return "/items/\(id)"
            case .productDescription(let id):
                return "/items/\(id)/description"
            }
        }
        
        private var queryItems: [URLQueryItem] {
            switch self {
            case .autoSuggest(_, let query):
                return [URLQueryItem(name: "q", value: query)]
            case .productSearch(_, let query, let page):
                return [URLQueryItem(name: "q", value: query),
                        URLQueryItem(name: "offset", value: page)]
            default:
                return []
            }
        }
        
        var url: URL {
            var components = URLComponents()
            components.scheme = MeLiNetworkConstants.defaultScheme
            components.host = MeLiNetworkConstants.defaultHost
            components.path = path
            components.queryItems = queryItems
            guard let url = components.url else {
                fatalError("Malformed URL \(String(describing: components.string))")
            }
            return url
        }
    }
}

