//
//  SearchItemsResultContract.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

protocol SearchProductsResultViewProtocol: AnyObject {
    var presenter: SearchProductsResultPresenterProtocol? { get set }
    func updateSearchBar(text: String)
    func showEmptyState()
    func showLoading()
    func hideLoading()
    func showLoadingFooter()
    func hideLoadingFooter()
    func refreshView(scrollToTop: Bool)
}

protocol SearchProductsResultInteractorProtocol: AnyObject {
    func searchProduct(by text: String, firstSearch: Bool, completion: @escaping (Result<[ProductResult], Error>) -> Void)
}

protocol SearchProductsResultPresenterProtocol: ErrorHandlingPresenter {
    var view: SearchProductsResultViewProtocol? { get set }
    var router: SearchProductsResultRouterProtocol? { get set }
    var interactor: SearchProductsResultInteractorProtocol? { get set }
    
    func viewDidLoad()
    func searchBarselected()
    func performSearch(with text: String)
    func numberOfRows() -> Int
    func setupCell(_ cell: ProductCellProtocol?, at index: Int)
    func itemSelected(at index: Int)

}

protocol SearchProductsResultRouterProtocol: ErrorHandlingRouter {
    var viewController: UIViewController? { get set }
    var presenter: SearchProductsResultPresenterProtocol? { get set }
    var predictiveDelegate: PredictiveResultDelegate? { get set }
    static func buildSearchProductsResultSection() -> SearchProductsResultVC
    func routeToPredictiveSearch()
    func routeToDetail(product: ProductResult)
}
