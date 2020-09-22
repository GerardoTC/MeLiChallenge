//
//  PredictiveSearchContract.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit


protocol PredictiveSearchViewProtocol: AnyObject {
    var presenter: PredictiveSearchPresenterProtocol? { get set }
    func focusOnSearchText()
    func refreshView()
}

protocol PredictiveSearchInteractorProtocol: AnyObject {
    func searchText(_ text: String, completion: @escaping (Result<[String], Error>) -> Void)
    func searchTextLocally(_ text: String) -> Result<[String], Error>
    func saveSuggestion(text: String)
    func bringAllSuggestions() -> Result<[String], Error>
}

protocol PredictiveSearchPresenterProtocol: AnyObject {
    var view: PredictiveSearchViewProtocol? { get set }
    var router: PredictiveSearchRouterProtocol? { get set }
    var interactor: PredictiveSearchInteractorProtocol? { get set }
    
    func viewDidLoad()
    func textDidChange(_ text: String?)
    func numberOfRowsInSection(section: Int) -> Int
    func suggestion(at index: Int, section: Int) -> String
    func didSelectSuggestion(index: Int, section: Int)
    func searchButtonClicked(text: String?)
    func cancelButtonPressed()
}

protocol PredictiveSearchRouterProtocol: AnyObject {
    var viewController: UIViewController? {get set}
    var predictiveDelegate: PredictiveResultDelegate? { get set }
    static func buildPredictiveSearchSection(delegate: PredictiveResultDelegate) -> PredictiveSearchVC
    func dismissView(withText: String)
    func dismissView()
}

protocol PredictiveResultDelegate: AnyObject {
    func performFetch(text: String)
}
