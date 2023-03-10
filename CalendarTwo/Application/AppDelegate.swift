//
//  AppDelegate.swift
//  CalendarTwo
//
//  Created by Samuel Fuentes Navarrete on 05/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let calendarView = CalendarViewController()
    let calendar2View = CalendarTwoViewController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initilizaWindow()
        return true
    }

    


    func initilizaWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBlue
        window?.rootViewController = calendar2View
    }
}

