//
//  RootRouter.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit

class RootRouter {
    static let shared: RootRouter = RootRouter()
    private init() {}
    
    func presentRootView(in window: UIWindow?) {
        guard let newsScreen = NewsScreenVC.instance else { return }
        let navController = UINavigationController(rootViewController: newsScreen)
        window?.rootViewController = navController
    }
}
