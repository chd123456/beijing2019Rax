//
//  CHDController.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import Foundation
import UIKit
class CHDController: UIViewController {
    
    open var navBarTintColor: UIColor = uicolorff5050//子类赋值 需要在 super.viewDidLoad() 之前
    open var navBarTransparent: Bool = false//子类赋值 需要在 super.viewDidLoad() 之前
    open var pageStatistics: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = uicolorf5
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: fontBlod(18)]
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = navBarTintColor
        
        if self.navBarTransparent {
            navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}

extension UIViewController {
    
    func navbarHeight() -> CGFloat {
        
        return ((self.navigationController?.navigationBar.frame.height ?? 64) + UIApplication.shared.statusBarFrame.height)
    }
    
    func statusBarHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.statusBarFrame.height
        }else {
            return 0
        }
        
    }
    
    func tabbarHeight() -> CGFloat {
        
        if isIphoneX() {
            
            return (self.tabBarController?.tabBar.frame.height)! + 20
        }
        
        return (self.tabBarController?.tabBar.frame.height)!
    }
    
}
extension UIViewController {
    
    struct MJAssociatedKeys
    {   // default is system attributes
        static var mjPageIdentification: String = ""
        static var mjNavBarImgView: UIImageView = UIImageView()
    }
    
    var naviBackgroundImageView: UIImageView? {
        get {
            guard let def = objc_getAssociatedObject(self, &MJAssociatedKeys.mjNavBarImgView) as? UIImageView else {
                return nil
            }
            return def
        }
        set { objc_setAssociatedObject(self, &MJAssociatedKeys.mjNavBarImgView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    var pageIdentification: String {
        get {
            guard let def = objc_getAssociatedObject(self, &MJAssociatedKeys.mjPageIdentification) as? String else {
                return MJAssociatedKeys.mjPageIdentification
            }
            return def
        }
        set { objc_setAssociatedObject(self, &MJAssociatedKeys.mjPageIdentification, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    //导航栏透明且隐藏底部黑线
    func mj_navBarHiddenBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        mj_shadowHidden()
    }
    
    //隐藏底部黑线
    func mj_shadowHidden() {
        if let barBackgroundView = navigationController?.navigationBar.subviews[0] {
            let valueForKey = barBackgroundView.value(forKey:)
            
            if let shadowView = valueForKey("_shadowView") as? UIView {
                shadowView.isHidden = true
            }
        }
    }
    
    //彻底隐藏导航栏
    func mj_navBarHiddenAll() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //设置取消 导航栏模糊效果
    func mj_isTranslucent(translucent: Bool) {
        navigationController?.navigationBar.isTranslucent = translucent
    }
    
    //设置导航栏背景颜色
    func mj_navBarColor(color: UIColor) {
        navigationController?.navigationBar.barTintColor = color
    }
    //设置导航栏主题颜色
    func mj_navTintColor(color: UIColor) {
        navigationController?.navigationBar.tintColor = color
    }
    
    //设置导航栏标题颜色
    func mj_navTitleColor(color: UIColor) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    
    //设置导航栏图片(支持透明度调整)
    func mj_navBarImg(img: UIImage) {
        
        if naviBackgroundImageView == nil {
            mj_navBarHiddenBar()
            let naviHeight = mj_naviBarHeight()
            
            
            naviBackgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: naviHeight))
            naviBackgroundImageView?.autoresizingMask = .flexibleWidth
            naviBackgroundImageView?.contentMode = .scaleAspectFill
            naviBackgroundImageView?.clipsToBounds = true
            navigationController?.navigationBar.subviews.first?.insertSubview(naviBackgroundImageView ?? UIImageView(), at: 0)
        }
        
        naviBackgroundImageView?.image = img
    }
    
    //设置导航栏图片透明度
    func mj_navBarImgAlpha(alpha: Float) {
        
        if naviBackgroundImageView != nil {
            naviBackgroundImageView?.alpha = CGFloat(min(alpha, 1))
        }
    }
    
    func mj_naviBarHeight() -> CGFloat {
        if navigationController != nil {
            return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
}
