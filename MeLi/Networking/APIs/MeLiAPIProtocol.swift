//
//  MeLiAPIProtocol.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

protocol MeLiAPIProtocol: AnyObject {
    @discardableResult
    func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T,Error>) -> Void) -> URLSessionTask
}
