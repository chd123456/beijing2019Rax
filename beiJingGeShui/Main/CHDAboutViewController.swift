//
//  CHDAboutViewController.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2019/2/20.
//  Copyright © 2019年 hida. All rights reserved.
//

import Foundation
import UIKit
class CHDAboutViewController: CHDController {
    var titleLabel = UILabel.create(text: "预扣税率表:", textColor: uicolorff5050, align: .center, fontSize: UIFont.size(size: scale(20), isBody: true))
    var aboutAuthorLabel = UILabel.create(text: "发现bug请联系：\n QQ：694099476 微信：694099476", textColor: uicolor999, align: .left, fontSize: UIFont.size(size: scale(13), isBody: true))
    var imageV = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
    }
    
    func setConstraints(){
        imageV.image = UIImage(named: "p.jpeg")
        imageV.contentMode = .scaleAspectFit
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(scale(0))
            make.left.right.equalToSuperview()
            make.height.equalTo(scale(50))
        }
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(scale(375))
        }
        view.addSubview(aboutAuthorLabel)
        aboutAuthorLabel.numberOfLines = 0
        aboutAuthorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(scale(15))
            make.bottom.equalToSuperview()
        }
    }
}
