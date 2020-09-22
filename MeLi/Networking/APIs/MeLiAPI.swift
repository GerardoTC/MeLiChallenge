//
//  MeLiAPI.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

class MeLiAPI: MeLiAPIProtocol {
    @discardableResult
    func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T,Error>) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            print("GET REQUEST: \(String(describing: response?.url))")            
            print("error: \(error.debugDescription)")
            DispatchQueue.main.async {
                completion(
                    Result {
                        guard let data = data else {
                            throw NetworkError.noDataError
                        }
                        if let dataParsed = try? resource.parse(data) {
                            return dataParsed
                        } else {
                            throw NetworkError.unableToParse
                        }
                    }
                )
            }
        }
        task.resume()
        return task
    }
}
