//
//  PredictiveSearchRouter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class PredictiveSearchRouter {
    weak var viewController: UIViewController?
    var predictiveDelegate: PredictiveResultDelegate?
    static func buildPredictiveSearchSection(delegate: PredictiveResultDelegate) -> PredictiveSearchVC {
        let predictiveSearchVC: PredictiveSearchVC = PredictiveSearchVC.createFromStoryBoard(storyBoardName: .predictiveSearch,
                                                                                                 identifier: .predictiveSearch)
        predictiveSearchVC.modalPresentationStyle = .fullScreen
        predictiveSearchVC.modalTransitionStyle = .crossDissolve
        
        let interactor = PredictiveSearchInteractor()
        let router = PredictiveSearchRouter()
        router.viewController = predictiveSearchVC
        router.predictiveDelegate = delegate
        let presenter = PredictiveSearchPresenter()
        presenter.view = predictiveSearchVC
        presenter.router = router
        presenter.interactor = interactor
        predictiveSearchVC.presenter = presenter
        return predictiveSearchVC
    }
    
}

//MARK: - PredictiveSearchRouterProtocol
extension PredictiveSearchRouter: PredictiveSearchRouterProtocol {
    func dismissView(withText: String) {
        predictiveDelegate?.performFetch(text: withText)
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func dismissView() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
