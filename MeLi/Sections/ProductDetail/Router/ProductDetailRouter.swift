//
//  ProductDetailRouter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailRouter {
    var viewController: UIViewController?
}

//MARK: - ProductDetailRouterProtocol
extension ProductDetailRouter: ProductDetailRouterProtocol {
    
    static func buildPredictiveSearchSection(product: ProductResult) -> ProductDetailVC {
        let productDetailVC: ProductDetailVC = ProductDetailVC.createFromStoryBoard(storyBoardName: .productDetail,
                                                                                        identifier: .productDetail)
        
        let interactor = ProductDetailInteractor()
        let router: ProductDetailRouterProtocol = ProductDetailRouter()
        router.viewController = productDetailVC
        
        let presenter: ProductDetailPresenterProtocol = ProductDetailPresenter()
        presenter.view = productDetailVC
        presenter.router = router
        presenter.errorRouter = router
        presenter.interactor = interactor
        presenter.product = product
        productDetailVC.presenter = presenter
        return productDetailVC
    }
    
    func routeToSearchProductresult() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
