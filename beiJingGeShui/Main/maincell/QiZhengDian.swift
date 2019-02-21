//
//  QiZhengDian.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import Foundation
import UIKit
class QiZhengDian:UITableViewCell {
    let redView = UIView()
    let titleLabel  = UILabel.create(text: "起征点（元）", textColor: uicolor333, align: .left, fontSize: UIFont.size(size: scale(15), isBody: true))
    
    let grayView = UIView()
    let textView = UITextField()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.initWithProperty()
        self.setConstraints()
    }
    func initWithProperty() {
        redView.backgroundColor = uicolorff5050
        
        grayView.backgroundColor = uicolorf5
        grayView.layer.masksToBounds = true
        grayView.layer.cornerRadius = scale(3)
        
        textView.borderStyle = .none
        textView.font = UIFont.size(size: scale(15), isBody: true)
        textView.textColor = uicolor333
        textView.placeholder = "请输入起征点金额"
        textView.returnKeyType = .next
        textView.text = "5000"
        
        textView.keyboardType = .decimalPad
        
    }
    func setConstraints() {
        contentView.addSubview(redView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(grayView)
        grayView.addSubview(textView)
        redView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalToSuperview().offset(scale(13))
            make.width.equalTo(scale(3))
            make.height.equalTo(scale(10))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(redView.snp.right).offset(scale(3))
            make.centerY.equalTo(redView)
        }
        grayView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(titleLabel.snp.bottom).offset(scale(5))
            make.height.equalTo(scale(40))
            make.right.equalToSuperview().offset(scale(-13))
            make.bottom.equalToSuperview().offset(scale(-5))
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(5))
            make.top.bottom.right.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
