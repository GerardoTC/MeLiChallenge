//
//  PredictiveSearchInteractor.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation
import CoreData

class PredictiveSearchInteractor: PredictiveSearchInteractorProtocol {

    
    var network: MeLiAPIProtocol
    var dataController: LocalSuggestionDataControllerProtocol
    
    init(network: MeLiAPIProtocol = MeLiAPI(),
         dataController: LocalSuggestionDataControllerProtocol = LocalSuggestionDataController()) {
        self.network = network
        self.dataController = dataController
    }
    
    func searchText(_ text: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let url = MeLiNetworkConstants.Endpoints.autoSuggest(query: text).url
        let parser: (Data) throws -> PredictiveSearchEntity = { data in
            return try JSONDecoder().decode(PredictiveSearchEntity.self, from: data)
        }
        let resource = NetworkResource(url: url, parse: parser)
        
        network.getRequest(resource: resource) { (result) in
            switch result {
            case .success(let result):
                let suggestions = result.suggestions.map { (predictiveSuggestion) -> String in
                    predictiveSuggestion.suggestion
                }
                completion(.success(suggestions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func searchTextLocally(_ text: String) -> Result<[String], Error> {
        dataController.searchTextLocally(text)
    }
    
    func saveSuggestion(text: String) {
        dataController.saveSuggestion(text)
    }
    
    func bringAllSuggestions() -> Result<[String], Error> {
        dataController.bringAllLocalSuggestions()
    }
}
