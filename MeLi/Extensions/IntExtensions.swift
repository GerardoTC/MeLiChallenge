//
//  IntExtensions.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 20/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

extension Int {
    func toCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_CO")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? String()
    }
}
