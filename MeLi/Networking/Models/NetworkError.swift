//
//  NetworkError.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case noDataError
    case unableToParse
    case connectionError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noDataError:
            return "No data Found"
        case .unableToParse:
            return "Unable to Parse data"
        case .connectionError:
            return "Internet Connection Error"
        case .unknown:
            return "unknown error trying to connect"
        }
    }
}
