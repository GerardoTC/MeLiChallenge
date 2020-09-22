//
//  UIViewControllerExtensions.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

extension UIViewController {
    static func createFromStoryBoard<T>(storyBoardName: ViewConstants.StoryBoard,
                                        bundle: Bundle? = nil,
                                        identifier: ViewConstants.VCIdentifiers) -> T {
        guard let viewCreated = UIStoryboard(name: storyBoardName.rawValue, bundle: bundle).instantiateViewController(withIdentifier: identifier.rawValue) as? T else {
            fatalError("View Controller \(identifier.rawValue) does not have a reference in the storyboard \(storyBoardName)")
        }
        return viewCreated
    }
}
