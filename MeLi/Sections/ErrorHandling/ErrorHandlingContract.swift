//
//  ErrorHandlingContract.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

protocol ErrorHandlingPresenter: AnyObject {
    var errorRouter: ErrorHandlingRouter? { get set }
    func handleError(_ error: Error)
}

protocol ErrorHandlingRouter: AnyObject {
    var viewController: UIViewController? { get set }
    func routeToErrorView()
}

extension ErrorHandlingPresenter {
    func handleError(_ error: Error) {
        if error as? NetworkError != nil {
            errorRouter?.routeToErrorView()
        }
    }
}

extension ErrorHandlingRouter {
    func routeToErrorView() {
        let vc: ErrorHandlingVC = ErrorHandlingVC.createFromStoryBoard(storyBoardName: .errorHandling,
                                                      identifier: .errorHandling)
        viewController?.present(vc, animated: true)
    }
}
