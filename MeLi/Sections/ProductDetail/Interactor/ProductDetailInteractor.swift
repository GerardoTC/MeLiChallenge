//
//  ProductDetailInteractor.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class ProductDetailInteractor {
    var network: MeLiAPIProtocol
    init(network: MeLiAPIProtocol = MeLiAPI()) {
        self.network = network
    }
    
    private func mapImageUrls(_ productInfo: ProductDetailInfo) -> [URL] {
        productInfo.pictures.compactMap { (pictures) -> URL? in
            if let url = URL(string: pictures.secureUrl)  {
                return url
            } else {
                return URL(string: pictures.url)
            }
        }
    }
    
}

//MARK: - ProductDetailInteractorProtocol
extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    func productImages(id: String, completion: @escaping (Result<[URL], Error>) -> Void) {
        let url = MeLiNetworkConstants.Endpoints.productImages(id: id).url
        
        let parser: (Data) throws -> ProductDetailInfo = { data in
            try JSONDecoder().decode(ProductDetailInfo.self, from: data)
        }
        
        let resource = NetworkResource(url: url, parse: parser)
        
        network.getRequest(resource: resource) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let productInfo):
                let images = self.mapImageUrls(productInfo)
                completion(.success(images))
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func productDescription(id: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = MeLiNetworkConstants.Endpoints.productDescription(id: id).url
        
        let parser: (Data) throws -> ProductDetailDescription = {data in
            try JSONDecoder().decode(ProductDetailDescription.self, from: data)
        }
        
        let resource = NetworkResource(url: url, parse: parser)
        
        network.getRequest(resource: resource) { (result) in
            switch result {
            case .success(let result):
                completion(.success(result.description))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
