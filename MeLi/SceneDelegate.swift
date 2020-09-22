//
//  SceneDelegate.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let vc = SearchProductsResultRouter.buildSearchProductsResultSection()
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.isHidden = true
            window.rootViewController = navController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

