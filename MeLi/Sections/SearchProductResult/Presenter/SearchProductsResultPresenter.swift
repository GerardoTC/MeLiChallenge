//
//  SearchProductsResultPresenter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class SearchProductsResultPresenter {
    weak var view: SearchProductsResultViewProtocol?
    var router: SearchProductsResultRouterProtocol?
    var errorRouter: ErrorHandlingRouter?
    var interactor: SearchProductsResultInteractorProtocol?
    var products: [ProductResult] = []
    var currentSearch: String = String()
    var limitReached: Bool = false
    private func searchProducts(with text: String) {
        limitReached = false
        view?.showLoading()
        interactor?.searchProduct(by: text, firstSearch: true, completion: { [weak self] (result) in
            self?.view?.hideLoading()
            switch result {
            case .success(let products):
                self?.products = products
                self?.view?.refreshView(scrollToTop: false)
                self?.view?.hideLoadingFooter()
            case .failure(let error):
                self?.handle(error)
            }
        })
    }
    
    private func searchMoreProducts() {
        view?.showLoadingFooter()
        interactor?.searchProduct(by: currentSearch, firstSearch: false, completion: { [weak self] (result) in
            self?.view?.hideLoading()
            switch result {
            case .success(let products):
                self?.products.append(contentsOf: products)
                self?.view?.refreshView(scrollToTop: false)
                self?.view?.hideLoadingFooter()
            case .failure(let error):
                self?.view?.hideLoadingFooter()
                self?.handle(error)
            }
        })
    }
    
    private func handle(_ error: Error) {
        switch error {
        case SearchProductsErrors.limitReached:
            limitReached = true
        default:
            handleError(error)
        }
    }
    
}

//MARK: - SearchProductsResultPresenterProtocol
extension SearchProductsResultPresenter: SearchProductsResultPresenterProtocol {
    
    func setupCell(_ cell: ProductCellProtocol?, at index: Int) {
        cell?.setup(with: products[index])
        if index == products.count - 1, !limitReached {
            searchMoreProducts()
        }
    }
    
    func numberOfRows() -> Int {
        products.count
    }

    func viewDidLoad() {
        view?.showEmptyState()
    }
    
    func performSearch(with text: String) {
        view?.updateSearchBar(text: text)
        view?.refreshView(scrollToTop: true)
        currentSearch = text
        searchProducts(with: text)
    }
    
    func searchBarselected() {
        router?.routeToPredictiveSearch()
    }
    
    func itemSelected(at index: Int) {
        router?.routeToDetail(product: products[index])
    }
}
