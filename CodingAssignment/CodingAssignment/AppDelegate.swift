//
//  AppDelegate.swift
//  CodingAssignment
//
//  Created by Rajesh on 25/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let citiesListVC = CitiesListViewController()
        let naviagationVC = UINavigationController(rootViewController: citiesListVC)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = naviagationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

