//
//  ProductDetailPresenter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class ProductDetailPresenter {
    weak var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var errorRouter: ErrorHandlingRouter?
    var interactor: ProductDetailInteractorProtocol?
    var product: ProductResult?
    var images: [URL] = []
    var description: String = String()
    
    private func searchProductImages(id: String) {
        interactor?.productImages(id: id, completion: { [weak self](result) in
            switch result {
            case .success(let urls):                
                self?.images = urls
                self?.view?.refreshView()
            case .failure(let error):
                self?.handleError(error)
            }
        })
    }
    
    private func searchProductDescription(id: String) {
        interactor?.productDescription(id: id, completion: { [weak self] (result) in
                  switch result {
                  case .success(let description):
                      self?.description = description
                      self?.view?.refreshView()
                  case .failure(let error):
                      self?.handleError(error)
                  }
              })
    }
}

//MARK: - ProductDetailPresenterProtocol
extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    func setupCell(_ cell: ProductInfoCellProtocol?) {
        cell?.setup(with: product)
    }
    
    func setupCell(_ cell: ImagesCellProtocol?) {
        cell?.setup(with: images)
    }
    
    func setupCell(_ cell: DescriptionInfoCellProtocol?) {
        cell?.setup(with: description)
    }
    
    func viewDidLoad() {
        guard let id = product?.id else {
            return
        }
        searchProductImages(id: id)
        searchProductDescription(id: id)
    }
    
    func backButtonPressed() {
        router?.routeToSearchProductresult()
    }
}
