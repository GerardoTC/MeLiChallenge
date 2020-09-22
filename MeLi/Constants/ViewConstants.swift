//
//  ViewConstants.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct ViewConstants {
    enum StoryBoard: String {
        case searchProductsResult = "SearchProductResult"
        case predictiveSearch = "PredictiveSearch"
        case productDetail = "ProductDetail"
        case errorHandling = "ErrorHandling"
    }
    enum VCIdentifiers: String {
        case productDetail = "ProductDetailVC"
        case predictiveSearch = "PredictiveSearchVC"
        case searchProductsResult = "SearchProductsResultVC"
        case errorHandling = "ErrorHandlingVC"
    }
    
    struct CellIdentifiers {
        enum ProductDetail: String {
            case imagesCell = "ImagesCell"
            case productInfoCell = "ProductInfoCell"
            case descriptionInfoCell = "DescriptionInfoCell"
        }
        enum PredictiveSearch: String {
            case predictiveLocalSearchCell = "PredictiveSearchHistoryCell"
            case predictiveSearchCell = "PredictiveSearchResultCell"
        }
        enum SearchProduct: String {
            case productCell = "ProductCell"
        }
    }
    
    struct NibNames {
        enum ProductDetail: String {
            case imagesCell = "ImagesCell"
            case productInfoCell = "ProductInfoCell"
            case descriptionInfoCell = "DescriptionInfoCell"
        }
        enum SearchProduct: String {
            case productCell = "ProductCell"
        }
    }
}
