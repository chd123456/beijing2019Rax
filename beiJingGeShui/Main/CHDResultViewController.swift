//
//  CHDResultViewController.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2019/1/1.
//  Copyright © 2019年 hida. All rights reserved.
//

import Foundation
import UIKit
class CHDResultViewController: CHDController {
    var yingShuiE: CGFloat = 0
    var shuiHouE:CGFloat = 0
    var shuiKoukuan:CGFloat = 0
    var titleLabel = UILabel.create(text: "", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(20), isBody: true))
    var subTitleLabel = UILabel.create(text: "", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(20), isBody: true))
    var adDescripLabel = UILabel.create(text: "感觉还不错，\n那就分享给家人和朋友吧！", textColor: uicolor999, align: .left, fontSize: UIFont.size(size: scale(20), isBody: true))
    var btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "计算结果"
        let rax = colculatorRax(yingShuiE: yingShuiE)
        titleLabel.numberOfLines = 0
        titleLabel.text = "新个税下，您每月缴纳税额为：" + useRoundedFloatStrWith(string: "\(rax)", precision: 1)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = "您的税后工资为：" + useRoundedFloatStrWith(string: "\(shuiKoukuan - rax)", precision: 1)
        initWithPerproty()
        self.setContrains()
    }
    
    func initWithPerproty(){
        adDescripLabel.numberOfLines = 0
        btn.setTitle("分享", for: .normal)
        btn.titleLabel?.font = UIFont.size(size: scale(15), isBody: false)
        btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.isSelected = true
        btn.addTarget(self, action: #selector(self.shareClick), for: .touchUpInside)
    }

    func setContrains(){
        self.view.addSubview(titleLabel)
        self.view.addSubview(subTitleLabel)
        self.view.addSubview(adDescripLabel)
        self.view.addSubview(btn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalToSuperview().offset(scale(50))
            make.width.equalTo(scale(350))
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(13))
            make.width.equalTo(scale(350))
        }
        adDescripLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(subTitleLabel.snp.bottom).offset(scale(50))
            make.width.equalTo(scale(350))
        }
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(adDescripLabel.snp.bottom).offset(scale(20))
            make.width.equalTo(scale(100))
            make.height.equalTo(scale(40))
            make.centerX.equalToSuperview()
        }

    }
    func colculatorRax(yingShuiE:CGFloat)->CGFloat{
        if yingShuiE <= 3000 {
            return yingShuiE * 0.03
        }else if yingShuiE > 3000 && yingShuiE <= 12000 {
            return yingShuiE * 0.1 - 210
        }else if yingShuiE > 12000 && yingShuiE <= 25000 {
            return yingShuiE * 0.20 - 1410
        }else if yingShuiE > 25000 && yingShuiE <= 35000 {
            return yingShuiE * 0.25 - 2660
        }else if yingShuiE > 35000 && yingShuiE <= 55000 {
            return yingShuiE * 0.30 - 4410
        }else if yingShuiE > 55000 && yingShuiE <= 80000 {
            return yingShuiE * 0.35 - 7160
        }else if yingShuiE > 80000 {
            return yingShuiE * 0.45 - 15160
        }
        return 0
    }
    
    @objc func shareClick()
    {
        CHDShare.shared(forDescript: "北京个税计算器", imageName: "1024", setUrl: "https://itunes.apple.com/us/app/beijing2019geshuijisuanqi/id1450487394?l=zh&ls=1&mt=8", isUseAirDrop: true, currentViewController: self, comletedHandle: {
            
        }) {
            
        }
    }
}
