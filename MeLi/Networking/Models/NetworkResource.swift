//
//  NetworkResource.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

struct NetworkResource<T> {
    let url: URL
    let parse: (Data) throws -> T
}
