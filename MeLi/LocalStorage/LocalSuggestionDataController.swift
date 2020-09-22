//
//  LocalDataController.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation
import CoreData

class LocalSuggestionDataController: LocalSuggestionDataControllerProtocol {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var fetchedResultsController: NSFetchedResultsController<LocalPredictiveSearch>?
    
    init(modelName: String = "LocalPredictiveSearch") {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
    
    func saveSuggestion(_ text: String) {
        if !alreadyExists(text.lowercased()) {
            let suggestion = LocalPredictiveSearch(context: viewContext)
            suggestion.localSuggestion = text.lowercased()
            try? viewContext.save()
        }
    }
    
    func alreadyExists(_ text: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<LocalPredictiveSearch> = LocalPredictiveSearch.fetchRequest()
        let descriptor = NSSortDescriptor(key: "localSuggestion", ascending: false)
        let predicate = NSPredicate(format: "localSuggestion == '\(text)'")
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 50
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: "localSuggestions")
        guard let result = try? viewContext.fetch(fetchRequest) else {
            return false
        }
        return result.count > 0
    }
    
    func bringAllLocalSuggestions() -> (Result<[String], Error>) {
        let fetchRequest: NSFetchRequest<LocalPredictiveSearch> = LocalPredictiveSearch.fetchRequest()
        let descriptor = NSSortDescriptor(key: "localSuggestion", ascending: false)
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.fetchLimit = 50
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: viewContext,
                                                              sectionNameKeyPath: nil, cacheName: "localSuggestions")
        
        return Result<[String], Error> {
            let results = try viewContext.fetch(fetchRequest)
            let result = results.compactMap { (localSearch) -> String? in
                localSearch.localSuggestion
            }
            return result
        }
    }
    
    func searchTextLocally(_ text: String) -> (Result<[String], Error>) {
        
        let fetchRequest: NSFetchRequest<LocalPredictiveSearch> = LocalPredictiveSearch.fetchRequest()
        let descriptor = NSSortDescriptor(key: "localSuggestion", ascending: false)
        let predicate = NSPredicate(format: "localSuggestion CONTAINS[c] '\(text)'")
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 50
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: "localSuggestions")
        
        return Result<[String], Error> {
            let results = try viewContext.fetch(fetchRequest)
            let result = results.compactMap { (localSearch) -> String? in
                localSearch.localSuggestion
            }
            return result
        }
    }
    
}
