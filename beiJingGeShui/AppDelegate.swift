//
//  AppDelegate.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainVc = CHDMainController()
        let nav = CHDNavigationController(rootViewController: mainVc)
        let mainNav = CHDBaseNavigationController.initWithRootvc(rootVC: nav)
        self.window?.rootViewController = mainNav
        self.window?.makeKeyAndVisible()
        //设置状态栏
        UIApplication.shared.statusBarStyle = .lightContent
        // Override point for customization after application launch.
        return true
    }

}

