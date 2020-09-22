//
//  Debouncer.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 18/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import Foundation

import Foundation

class TextDebouncer {

    var closure: ClosureHandler?
    typealias ClosureHandler = () -> Void
    private let timeInterval: TimeInterval
    private var timer: Timer?
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func restarInterval() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.closure?()
        })
    }
}
