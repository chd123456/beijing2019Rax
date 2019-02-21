//
//  Tools.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import Foundation
import UIKit

//屏幕宽高
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//屏幕尺寸比
let SCREEN_SCALE = (SCREEN_WIDTH / 375.0)
//按比得出的尺寸
func scale(_ size:CGFloat) -> CGFloat{
    
    return size * SCREEN_SCALE
}

func scaleH(_ size:CGFloat) -> CGFloat{
    
    return size * (SCREEN_HEIGHT / 667.0)
}

extension CGFloat{
    var scale: CGFloat { return self * SCREEN_WIDTH / 375.0 }
}

func scaleHalf(_ size: CGFloat) -> CGFloat{
    
    return size * ((((SCREEN_SCALE - 1) / 2.0)) + 1)
}

//文字大小
func fontSystem(_ size:CGFloat) -> UIFont{
    
    return UIFont.systemFont(ofSize: scaleHalf(size))
}
//加粗文字
func fontBlod(_ size:CGFloat) -> UIFont{
    
    return UIFont.boldSystemFont(ofSize: scaleHalf(size))
}

//色值
let uicolorff5050 = uicolor(0xff5050)
let uicolor5b8bf0 = uicolor(0x5b8bf0)

let uicolor333 = uicolor(0x333333)
let uicolor666 = uicolor(0x666666)
let uicolorf1 = uicolor(0xf1f1f1)
let uicolorf5 = uicolor(0xf5f5f5)
let uicolorf0ebe2 = uicolor(0xf0ebe2)
let uicolor999 = uicolor(0x999999)
let uicolor8a765a = uicolor(0x8a765a)
let uicolord82323 = uicolor(0xd82323)
let uicolor4276cf = uicolor(0x4276cf)
let uicolore8e8e8 = uicolor(0xE8E8E8)
//颜色
//16进制 无透明
func uicolor(_ rgbValue : Int) -> UIColor{
    
    return uicolor(rgbValue: rgbValue, alpha: 1)
}
//16进制 含有透明度
func uicolor(rgbValue : Int, alpha: CGFloat) -> UIColor{
    
    return UIColor(red: CGFloat(CGFloat((rgbValue & 0xFF0000) >> 16)/255.0), green: CGFloat(CGFloat((rgbValue & 0xFF00) >> 8)/255.0), blue: CGFloat(CGFloat(rgbValue & 0xFF)/255.0), alpha: alpha)
}
//字符串 转颜色
func uicolor(_ rgbStr: String?) -> UIColor {
    
    var cstring = rgbStr ?? ""
    
    if cstring.contains("#") {
        let index = cstring.index(cstring.startIndex, offsetBy: 1)
        cstring = cstring.substring(from: index)
    }
    
    if cstring.count != 6 {
        return .white
    }
    
    return uicolor(Int(strtoul(cstring, nil, 16)))
}
//判断手机机型
func isIphoneX() -> Bool {
    
    if let window = UIApplication.shared.keyWindow {
        
        return (window.frame.height == 812)
    }
    return false
}

func isIphonePlus() -> Bool {
    
    if let window = UIApplication.shared.keyWindow {
        
        return (window.frame.width == 414)
    }
    return false
}

func useRoundedFloatStrWith(string:String,precision:Int) ->String
{
    let formatter = NumberFormatter()
    let value = (string as NSString).doubleValue
    var format = NSMutableString(string: "#####0")
    if(precision == 0)
    {
        formatter.positiveFormat = format as String
        return formatter.string(from: NSNumber(value: value))!
        
    }
    else
    {
        format = NSMutableString(string: "#####0.")
        for _ in 1...precision
        {
            format.appendFormat("0")
        }
        formatter.positiveFormat = format as String
        return formatter.string(from: NSNumber(value: value))!
    }
}

extension UILabel {
    static func create(text:String?,textColor:UIColor,align:NSTextAlignment,fontSize:UIFont)->UILabel{
        let label:UILabel = UILabel()
        label.text = text;
        label.textColor = textColor;
        label.textAlignment = align;
        label.font = fontSize;
        return label
    }
}

extension UIFont{
    class func size(size:CGFloat,isBody:Bool)->UIFont{
        if isBody {
            if #available(iOS 8.2, *) {
                let font = UIFont.systemFont(ofSize: size, weight: .bold)
                return font
            } else {
                let font = UIFont.systemFont(ofSize: size)
                return font
            }
        }else{
            let font = UIFont.systemFont(ofSize: size)
            return font
        }
        
    }
}

extension UIImage{
    
    static func getImage(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // MARK: 颜色转UIImage
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
}

extension UIView{
    func showMessage(message:NSString,animateDuration:Double)
    {
        let window = UIApplication.shared.keyWindow
        let showView = UIView()
        showView.backgroundColor = UIColor.black
        showView.frame = CGRect(x: 1, y: 1, width: 1, height: 1)//CGRectMake(1, 1, 1, 1);
        showView.alpha = 1.0;
        showView.layer.cornerRadius = 5.0;
        showView.layer.masksToBounds = true;
        window?.addSubview(showView)
        
        let label = UILabel()
        let attributesArray = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        let labelSize:CGSize = message.size(withAttributes: attributesArray)
        
        label.frame = CGRect(x: 10.0, y: 5.0, width: labelSize.width, height: labelSize.height)//CGRectMake(10.0, 5.0, labelSize.width,labelSize.height);
        label.numberOfLines = 0
        label.text = message as String;
        label.textColor = UIColor.white;
        label.textAlignment = NSTextAlignment(rawValue: 1)!
        label.backgroundColor = UIColor.clear;
        label.font = UIFont.boldSystemFont(ofSize: 15)
        showView.addSubview(label)
        showView.frame = CGRect(x: (UIScreen.main.bounds.width - labelSize.width - 20.0)/2.0, y: UIScreen.main.bounds.width - 200.0, width:  labelSize.width+20.0, height: labelSize.height+10.0)
        
        //CGRectMake((UIScreen.main.bounds.width - labelSize.width - 20.0)/2.0,  UIScreen.main.bounds.width - 200.0, labelSize.width+20.0, labelSize.height+10.0)
        
        UIView.animate(withDuration: animateDuration, animations: { () -> Void in
            showView.alpha = 0
        }) { (finished) -> Void in
            showView.removeFromSuperview()
        }
        
    }
    
}

func animationForMoneyCell(label:UILabel,message:String)
{
    UIView.animate(withDuration: 0.35, animations: {
        UIView.animate(withDuration: 0.05, animations: {
            label.transform = CGAffineTransform(translationX: 5, y: 0)
            
        }, completion: { (completion) in
            
            UIView.animate(withDuration: 0.05, animations: {
                label.transform = CGAffineTransform(translationX: -5, y: 0)
                
            }, completion: { (completion) in
                UIView.animate(withDuration: 0.05, animations: {
                    label.transform = CGAffineTransform(translationX: 10, y: 0)
                    
                }, completion: { (completion) in
                    UIView.animate(withDuration: 0.05, animations: {
                        label.transform = CGAffineTransform(translationX: -10, y: 0)
                        
                    }, completion: { (completion) in
                        UIView.animate(withDuration: 0.05, animations: {
                            label.transform = CGAffineTransform(translationX: 5, y: 0)
                            
                        }, completion: { (completion) in
                            UIView.animate(withDuration: 0.05, animations: {
                                label.transform = CGAffineTransform(translationX: -5, y: 0)
                                
                            }, completion: { (completion) in
                                UIView.animate(withDuration: 0.05, animations: {
                                    label.transform = CGAffineTransform(translationX: 0, y: 0)
                                    
                                }, completion: { (completion) in
                                    if message.count > 0 {
                                        UIView().showMessage(message: message as NSString, animateDuration: 2)
                                    }
                                })
                                
                            })
                            
                            
                        })
                        
                        
                    })
                    
                    
                })
                
                
            })
        })
        
    }, completion: { (completion) in
        
        label.transform = CGAffineTransform(translationX: 0, y: 0)
        
    })
    
    //- (void)textFieldChanged:(id)sender
    //{
    //    NSLog(@"current ContentOffset is %@",NSStringFromCGPoint(_contentView.contentOffset));
    //}
    
    
}
