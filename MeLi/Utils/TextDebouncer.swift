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
    typealias ClosureHandler = (String?) -> Void
    let timeInterval: TimeInterval
    private(set) var timer: Timer?
    private(set) var currentText: String = String()
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func restarInterval(with text: String) {
        currentText = text
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.closure?(self?.currentText)
        })
    }
}
