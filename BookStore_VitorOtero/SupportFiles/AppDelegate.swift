//
//  AppDelegate.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = UIColor.gray
        
        self.window = window
                
        let navigationController = UINavigationController(rootViewController: BooksViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return true
        
    }
}

