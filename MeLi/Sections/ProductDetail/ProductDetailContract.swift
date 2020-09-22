//
//  ProductDetailContract.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit


protocol ProductDetailViewProtocol: AnyObject {
    var presenter: ProductDetailPresenterProtocol? { get set }
    func refreshView()
}

protocol ProductDetailInteractorProtocol: AnyObject {
    func productDescription(id: String, completion: @escaping (Result<String, Error>) -> Void)
    func productImages(id: String, completion: @escaping (Result<[URL], Error>) -> Void)
}

protocol ProductDetailPresenterProtocol: ErrorHandlingPresenter {
    var view: ProductDetailViewProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var interactor: ProductDetailInteractorProtocol? { get set }
    var product: ProductResult? { get set }
    
    func viewDidLoad()
    func setupCell(_ cell: ImagesCellProtocol?)
    func setupCell(_ cell: ProductInfoCellProtocol?)
    func setupCell(_ cell: DescriptionInfoCellProtocol?)
    func backButtonPressed()

}

protocol ProductDetailRouterProtocol: ErrorHandlingRouter {
    var viewController: UIViewController? {get set}
    static func buildPredictiveSearchSection(product: ProductResult) -> ProductDetailVC
    func routeToSearchProductresult()
}
