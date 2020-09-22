//
//  SearchProductsResultRouter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class SearchProductsResultRouter {
    weak var viewController: UIViewController?
    weak var presenter: SearchProductsResultPresenterProtocol?
    var predictiveDelegate: PredictiveResultDelegate?
    
}

//MARK: - SearchProductsResultRouterProtocol
extension SearchProductsResultRouter: SearchProductsResultRouterProtocol {
    static func buildSearchProductsResultSection() -> SearchProductsResultVC {
        let searchProductsResultVC: SearchProductsResultVC = SearchProductsResultVC.createFromStoryBoard(storyBoardName: .searchProductsResult,
                                                                                                         identifier: .searchProductsResult)
        let interactor = SearchProductsResultInteractor()
        let router: SearchProductsResultRouterProtocol & ErrorHandlingRouter = SearchProductsResultRouter()
        router.viewController = searchProductsResultVC
        
        let presenter: SearchProductsResultPresenterProtocol = SearchProductsResultPresenter()
        presenter.view = searchProductsResultVC
        presenter.router = router
        presenter.errorRouter = router
        presenter.interactor = interactor
        searchProductsResultVC.presenter = presenter
        router.presenter = presenter
        return searchProductsResultVC
    }
    
    func routeToPredictiveSearch() {
        let predictiveSearchVC =  PredictiveSearchRouter.buildPredictiveSearchSection(delegate: self)
        viewController?.present(predictiveSearchVC, animated: true)
    }
    
    func routeToDetail(product: ProductResult) {
        let productDetailVC = ProductDetailRouter.buildPredictiveSearchSection(product: product)
        if let navigationController = viewController?.navigationController {
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(productDetailVC, animated: true)
        } 
    }
}

//MARK: - PredictiveResultDelegate
extension SearchProductsResultRouter: PredictiveResultDelegate {
    func performFetch(text: String) {
        presenter?.performSearch(with: text)
    }
}
