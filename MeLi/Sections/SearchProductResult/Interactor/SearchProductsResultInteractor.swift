//
//  SearchProductsResultInteractor.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class SearchProductsResultInteractor {
    let network: MeLiAPIProtocol
    var paging: ProductSearchPaging = ProductSearchPaging(total: 0, page: 0)
    var currentTask: URLSessionTask?
    var maxPageAllowed = 1000
    init(network: MeLiAPIProtocol = MeLiAPI()) {
        self.network = network
    }
    
    private func restartPaging() {
        paging.page = 0
        paging.total = 0
    }
}

//MARK: - SearchProductsResultInteractorProtocol
extension SearchProductsResultInteractor: SearchProductsResultInteractorProtocol {
    func searchProduct(by text: String, firstSearch: Bool,
                       completion: @escaping (Result<[ProductResult], Error>) -> Void) {
        
        let parser: (Data) throws -> ProductSearchResult = { data in
            return try JSONDecoder().decode(ProductSearchResult.self, from: data)
        }
        
        if firstSearch {
            restartPaging()
        }
        
        guard paging.page <= paging.total,
            paging.page <= maxPageAllowed else {
                completion(.failure(SearchProductsErrors.limitReached))
            return
        }
        
        guard currentTask == nil else {
                completion(.failure(SearchProductsErrors.alreadySearching))
            return
        }        
        let url = MeLiNetworkConstants.Endpoints.productSearch(query: text, page: String(paging.page)).url
        let resource = NetworkResource(url: url, parse: parser)
        currentTask = network.getRequest(resource: resource) { [weak self] (result) in
            self?.currentTask = nil
            switch result {
            case .success(let result):
                self?.paging.page += 1
                self?.paging.total = result.paging.total
                completion(.success(result.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
