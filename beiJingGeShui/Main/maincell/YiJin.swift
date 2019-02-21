//
//  YiJin.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//
import Foundation
import UIKit
class YiJin:UITableViewCell {
    let redView = UIView()
    let titleLabel  = UILabel.create(text: "公积金缴费基数缴费基数（元）", textColor: uicolor333, align: .left, fontSize: UIFont.size(size: scale(15), isBody: true))
    var salary:CGFloat = 0 {
        didSet{
            self.assignJiaoNaJinShu()
        }
    }
    let configItems = [10,20,30,40,50,60,70,80,90,100]
    var currentTag:Int = 100
    var btnList = [UIButton]()
    
    let configStyles = [12,11,10,9,8]
    var currentStyle:Int = 12
    var stylesList = [UIButton]()
    let grayView = UIView()
    let textView = UITextField()
    
    let yiJinLabel = UILabel.create(text: "公积金个人缴费: ", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))

    let kouChuLabel = UILabel.create(text: "公积金扣除：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(18), isBody: true))
    
    var kouChuJishu:CGFloat = 0 {
        didSet{
            titleLabel.text = "公积金缴费基数 " + "\(kouChuJishu)" + "（元）"
            let yijing = useRoundedFloatStrWith(string:  "\(Double(kouChuJishu * CGFloat(currentStyle) / 100))", precision: 0)
            yiJinLabel.text = "公积金个人缴费: " + yijing + "元"
            yiJinKouChu = CGFloat(Double(yijing) ?? 0) 
        }
    }
    
    var yiJinKouChu:CGFloat = 0 {
        didSet{
            kouChuLabel.text = "公积金扣除：\(yiJinKouChu)"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.initWithProperty()
        self.setConstraints()
    }
    func initWithProperty() {
        redView.backgroundColor = uicolorff5050
        self.btnList.removeAll()
        for item in configItems {
            let btn = UIButton()
            btn.layer.borderColor = uicolorf1.cgColor
            btn.layer.borderWidth = 1
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = scale(3)
            let title = "\(item)%"
            btn.setTitle(title, for: .normal)
            btn.tag = item
            if btn.tag == currentTag {
                btn.isSelected = true
                let jishu = salary*(CGFloat(item))/100.0
                kouChuJishu = jishu > jiShuMax ? jiShuMax : jishu
            }
            btn.addTarget(self, action: #selector(self.buttonClick(sender:)), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(color: uicolorf5), for: .normal)
            btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .selected)
            btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .highlighted)
            btn.setTitleColor(uicolor333, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont.size(size: scale(13), isBody: false)
            btnList.append(btn)
        }
        
        self.stylesList.removeAll()
        for (_,item) in configStyles.enumerated() {
            let btn = UIButton()
            btn.layer.borderColor = uicolorf1.cgColor
            btn.layer.borderWidth = 1
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = scale(3)
            btn.setTitle("\(item)%", for: .normal)
            btn.tag = item
            if btn.tag == currentStyle {
                btn.isSelected = true
            }
            btn.addTarget(self, action: #selector(self.styleClick(sender:)), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(color: uicolorf5), for: .normal)
            btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .selected)
            btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .highlighted)
            btn.setTitleColor(uicolor333, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont.size(size: scale(13), isBody: false)
            stylesList.append(btn)
        }
        
        grayView.backgroundColor = uicolorf5
        grayView.layer.masksToBounds = true
        grayView.layer.cornerRadius = scale(3)
        
        textView.delegate = self
        textView.text = ""
        textView.borderStyle = .none
        textView.font = UIFont.size(size: scale(12), isBody: true)
        textView.textColor = uicolor333
        textView.placeholder = "其他(元)"
        textView.returnKeyType = .next
        
        textView.keyboardType = .decimalPad
        
    }
    func setConstraints() {
        contentView.addSubview(redView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(grayView)
        grayView.addSubview(textView)
        contentView.addSubview(yiJinLabel)

        contentView.addSubview(kouChuLabel)
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
        for (index,btn) in btnList.enumerated() {
            contentView.addSubview(btn)
            let btnWidth = scale(60)
            let btnHeight = scale(40)
            if index == 0 {
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(scale(13))
                    make.top.equalTo(titleLabel.snp.bottom).offset(scale(5))
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
            }else if index == 5 {
                btn.snp.makeConstraints { (make) in
                    make.left.equalToSuperview().offset(scale(13))
                    make.top.equalTo(btnList[0].snp.bottom).offset(scale(5))
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
            }else{
                btn.snp.makeConstraints { (make) in
                    make.left.equalTo(btnList[index - 1].snp.right).offset(scale(13))
                    make.centerY.equalTo(btnList[index - 1])
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
                
            }
        }
        grayView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(btnList[5].snp.bottom).offset(scale(5))
            make.height.equalTo(scale(40))
            make.width.equalTo(scale(60))
        }
        
        textView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(5))
            make.top.bottom.right.equalToSuperview()
        }
        
        for (index,btn) in stylesList.enumerated() {
            contentView.addSubview(btn)
            let btnWidth = scale(40)
            let btnHeight = scale(40)
            if index == 0 {
                btn.snp.makeConstraints { (make) in
                    make.top.equalTo(grayView.snp.bottom).offset(scale(8))
                    make.left.equalToSuperview().offset(scale(13))
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
            }else{
                btn.snp.makeConstraints { (make) in
                    make.left.equalTo(stylesList[index - 1].snp.right).offset(scale(5))
                    make.centerY.equalTo(stylesList[index - 1].snp.centerY)
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }

            }
            
        }
        yiJinLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(stylesList[0].snp.bottom).offset(scale(13))
        }

        kouChuLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(yiJinLabel.snp.bottom).offset(scale(13))
            make.bottom.equalToSuperview().offset(scale(-5))
        }
        
        
    }
    
    @objc func styleClick(sender: UIButton) {
        currentStyle = sender.tag
        for btn in stylesList {
            if btn.tag == currentStyle {
                btn.isSelected = true
            }else{
                btn.isSelected = false
            }
        }
        self.assignJiaoNaJinShu()
    }
    
    func assignJiaoNaJinShu () {
        for (index,item) in configItems.enumerated() {
            let title = "\(item)%"
            (btnList[index]).setTitle(title, for: .normal)
            if 0 == currentTag {
                let moneyString = useRoundedFloatStrWith(string: textView.text ?? "0", precision: 1)
                let money = Double(moneyString) ?? 0
                let jishu = CGFloat(money)
                kouChuJishu = jishu > jiShuMax ? jiShuMax : jishu
            }else if btnList[index].tag == currentTag{
                let moneyString = useRoundedFloatStrWith(string: "\(salary*(CGFloat(item))/100.0)" , precision: 1)
                let money = Double(moneyString) ?? 0
                let jishu = CGFloat(money)
                kouChuJishu = jishu > jiShuMax ? jiShuMax : jishu
               
            }
        }
    }
    @objc func buttonClick(sender: UIButton){
        currentTag = sender.tag
        let jishu = CGFloat(salary*(CGFloat(currentTag))/100.0)
        kouChuJishu = jishu > jiShuMax ? jiShuMax : jishu

        sender.isSelected = !sender.isSelected
        for btn in btnList {
            if btn.tag != currentTag {
                btn.isSelected = false
            }
        }
        grayView.backgroundColor = uicolorf5
        textView.textColor = uicolor333
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YiJin:UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let jishu = Double(textField.text ?? "0.0")
        let kouchujishu = CGFloat(jishu ?? 0)
        kouChuJishu = kouchujishu > jiShuMax ? jiShuMax : kouchujishu
        if kouChuJishu > 0 {
            currentTag = 0
            for btn in btnList {
                btn.isSelected = false
            }
            grayView.backgroundColor = uicolorff5050
            textView.textColor = .white
        }
    }
}
