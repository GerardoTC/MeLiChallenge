//
//  PredictiveSearchPresenter.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class PredictiveSearchPresenter {
    weak var view: PredictiveSearchViewProtocol?
    var router: PredictiveSearchRouterProtocol?
    var interactor: PredictiveSearchInteractorProtocol?
    var debouncer: TextDebouncer
    var suggestions: [String] = []
    var localSuggestions: [String] = []
    let localSuggestionSection: Int = 0
    
    init(debouncer: TextDebouncer = TextDebouncer(timeInterval: 0.5)) {
        self.debouncer = debouncer
        registerDebouncer()
    }
    
    private func registerDebouncer() {
        debouncer.closure = { [weak self] text in
            guard let self = self,
                let text = text else {
                return
            }
            self.didEndEditing(text: text)
        }
    }
    
    private func didEndEditing(text: String) {
        
        guard text != String() else {
            suggestions = []
            bringAllSuggestions()
            view?.refreshView()
            return
        }
        updateSuggestions(text: text)
        updateLocalSuggestions(text: text)
    }
    
    private func bringAllSuggestions() {
        let result = interactor?.bringAllSuggestions()
        switch result {
        case .success(let suggestions):
            localSuggestions = suggestions
            view?.refreshView()
        default:
            break
        }
    }
    
    private func updateLocalSuggestions(text: String) {
        let result = interactor?.searchTextLocally(text)
        switch result {
        case .success(let localSuggestions):
            self.localSuggestions = localSuggestions
            view?.refreshView()
        default:
            break
        }
    }
    
    private func updateSuggestions(text: String) {
        interactor?.searchText(text, completion: { [weak self] (result) in
            switch result {
            case .success(let suggestions):
                self?.suggestions = suggestions
                self?.view?.refreshView()
            default:
                break
            }
        })
    }
}


//MARK: - PredictiveSearchPresenterProtocol
extension PredictiveSearchPresenter: PredictiveSearchPresenterProtocol {
    
    func viewDidLoad() {
        view?.focusOnSearchText()
        bringAllSuggestions()
    }
    
    func textDidChange(_ text: String?) {
        guard let text = text else {
            return
        }
        debouncer.restarInterval(with: text)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return section == localSuggestionSection ? localSuggestions.count : suggestions.count
    }
    
    func suggestion(at index: Int, section: Int) -> String {
        if section == localSuggestionSection {
            return localSuggestions[index]
        } else {
            return suggestions[index]
        }
    }
    
    func didSelectSuggestion(index: Int, section: Int) {
        if section == localSuggestionSection {
            router?.dismissView(withText: localSuggestions[index])
        } else {
            interactor?.saveSuggestion(text: suggestions[index])
            router?.dismissView(withText: suggestions[index])
        }
    }
    
    func searchButtonClicked(text: String?) {
        guard let text = text, text != String() else {
            return
        }
        interactor?.saveSuggestion(text: text)
        router?.dismissView(withText: text)
    }
    
    func cancelButtonPressed() {
        router?.dismissView()
    }
}
