//
//  LocalSuggestionDataControllerProtocol.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 21/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation


protocol LocalSuggestionDataControllerProtocol: AnyObject {
    func saveSuggestion(_ text: String)
    func alreadyExists(_ text: String) -> Bool
    func bringAllLocalSuggestions() -> (Result<[String], Error>)
    func searchTextLocally(_ text: String) -> (Result<[String], Error>)
}
