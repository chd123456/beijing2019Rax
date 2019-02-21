//
//  CHDNavigationController.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2019/1/1.
//  Copyright © 2019年 hida. All rights reserved.
//

import Foundation
import UIKit
class CHDNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        
        self.viewControllers = [CHDWrapViewController.wrapViewController(withViewController: rootViewController)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CHDWrapNavigationController: UINavigationController {
    
    var rootViewControllers: Array<UIViewController> {
        
        get {
            var rootVCs = Array<UIViewController>()
            for viewcontroller in CHDBaseNavigationController.shared.viewControllers {
                
                let wrapNav: UINavigationController = viewcontroller.children.first as! UINavigationController
                rootVCs.append(wrapNav.viewControllers.first!)
            }
            return rootVCs
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        
        return CHDBaseNavigationController.shared.popViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        return CHDBaseNavigationController.shared.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        return CHDBaseNavigationController.shared.popToRootViewController(animated: animated)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: scale(50), height: scale(40)))
        leftButton.setImage(#imageLiteral(resourceName: "navigitionBackArrow"), for: .normal)
        leftButton.adjustsImageWhenHighlighted = false
        leftButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        leftButton.contentHorizontalAlignment = .left
        let nagetiveSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        nagetiveSpacer.width = -8
        viewController.navigationItem.leftBarButtonItems = [nagetiveSpacer , UIBarButtonItem(customView: leftButton)]
        CHDBaseNavigationController.shared.pushViewController(CHDWrapViewController.wrapViewController(withViewController: viewController), animated: animated)
    }
    
    @objc func pop() {
        
        CHDBaseNavigationController.shared.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

class CHDWrapViewController: UIViewController {
    
    static func wrapViewController(withViewController viewContoller: UIViewController) -> CHDWrapViewController {
        
        let wrapNavController: CHDWrapNavigationController = CHDWrapNavigationController()
        wrapNavController.viewControllers = [viewContoller]
        wrapNavController.navigationBar.barTintColor = uicolorff5050
        wrapNavController.navigationBar.isTranslucent = false
        wrapNavController.navigationBar.tintColor = .white
        wrapNavController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: fontBlod(18)]
        let wrapViewController = CHDWrapViewController()
        wrapViewController.view.addSubview(wrapNavController.view)
        wrapViewController.addChild(wrapNavController)
        return wrapViewController
    }
    
    func rootViewController() -> UIViewController {
        
        let nav: CHDWrapNavigationController = self.children.first as! CHDWrapNavigationController
        return nav.viewControllers.first ?? nav
    }
    
    override var tabBarItem: UITabBarItem! {
        
        set {
            
            super.tabBarItem = newValue
        }
        
        get {
            return self.rootViewController().tabBarItem
        }
    }
    override var title: String? {
        
        set {
            super.title = newValue
        }
        
        get {
            
            return self.rootViewController().title
        }
    }
    
    override var childForStatusBarStyle: UIViewController? {
        
        get {
            
            return self.rootViewController()
        }
        
    }
    
    override var childForStatusBarHidden: UIViewController? {
        
        get {
            
            return self.rootViewController()
        }
        
    }
}
