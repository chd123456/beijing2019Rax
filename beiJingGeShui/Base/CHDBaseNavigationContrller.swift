//
//  CHDBaseNavigationContrller.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2019/1/1.
//  Copyright © 2019年 hida. All rights reserved.
//

import Foundation
import UIKit
class CHDBaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    static let shared = CHDBaseNavigationController()
    
    var rootViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarHidden(true, animated: false)
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    
    static func initWithRootvc(rootVC: UIViewController) -> CHDBaseNavigationController {
        
        CHDBaseNavigationController.shared.rootViewController = rootVC
        CHDBaseNavigationController.shared.viewControllers = [self.wrapViewController(withController: rootVC)]
        
        return CHDBaseNavigationController.shared
    }
    
    static func wrapViewController(withController controller: UIViewController) -> UIViewController {
        
        let wrapViewController = MJBaseWrapViewController()
        wrapViewController.view.addSubview(controller.view)
        wrapViewController.addChild(controller)
        return wrapViewController
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let isRootVC : Bool = viewController == navigationController.viewControllers.first
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

fileprivate class MJBaseWrapViewController: UIViewController {
    
    func childViewControllerForStatusBarHidden() -> UIViewController? {
        
        return rootViewController()
    }
    
    func childViewControllerForStatusBarStyle() -> UIViewController? {
        return rootViewController()
    }
    
    func rootViewController() -> UIViewController? {
        return self.children.first
    }
}
