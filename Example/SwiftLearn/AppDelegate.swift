//
//  AppDelegate.swift
//  SwiftLearn
//
//  Created by silence-majority on 10/25/2017.
//  Copyright (c) 2017 silence-majority. All rights reserved.
//

import UIKit
import SwiftLearn
@available(iOS 11.0, *)
@available(iOS 11.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)

        let vca = ViewController()
        let vcb = ViewController()
        let vcc = ViewController()
        let vcd = ViewController()
        let vce = ViewController()
        let vcf = ViewController()
        let vch = ViewController()
        let vci = ViewController()
        let vcg = ViewController()
        let vck = ViewController()


        
        let viewController = XBSegmentViewController()
//        viewController.subVCTitles = ["我的老师","我的同学","我的群聊","都是我的"]
//        viewController.subViewControllers = [vca,vcb,vcc,vcd]
        
        viewController.subViewControllers = [vca,vcb,vcc,vcd,vce,vcf,vch,vci,vcg,vck]
        viewController.subVCTitles = ["语文","数学","英语","物理","化学","生物","政治","地理","历史","科学"]

        let nav = UINavigationController(navigationBarClass:nil, toolbarClass: nil)
        nav.viewControllers = [viewController]
        
        window?.rootViewController = nav
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

