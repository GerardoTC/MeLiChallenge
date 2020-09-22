//
//  AppDelegate.swift
//  MeLi
//
//  Created by Gerardo Tarazona Caceres on 16/09/20.
//  Copyright © 2020 Gerardo Tarazona Caceres. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // iOS13 or later
        guard #available(iOS 13.0, *) else {
            self.window = UIWindow()
            let vc = SearchProductsResultRouter.buildSearchProductsResultSection()
            let navController = UINavigationController(rootViewController: vc)
            navController.navigationBar.isHidden = true
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
            return true
        }
        return true
    }
}

