//
//  AppDelegate.swift
//  SharedCart
//
//  Created by Jeytery on 17.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let viewController = MenuViewController()
        
        let nc = UINavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        
        return true
    }

}

