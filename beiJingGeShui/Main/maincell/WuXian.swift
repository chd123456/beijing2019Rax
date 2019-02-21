//
//  WuXian.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import Foundation
import UIKit
class WuXian:UITableViewCell {
    let redView = UIView()
    let titleLabel  = UILabel.create(text: "社保缴费基数（元）", textColor: uicolor333, align: .left, fontSize: UIFont.size(size: scale(15), isBody: true))
    var salary:CGFloat = 0 {
        didSet{
          self.assignJiaoNaJinShu()
        }
    }
    let configItems = [10,20,30,40,50,60,70,80,90,100]
    var currentTag:Int = 100
    var btnList = [UIButton]()
    
    let configStyles = ["城镇户口","农村户口"]
    var currentStyle:Int = 0
    var stylesList = [UIButton]()
    let grayView = UIView()
    let textView = UITextField()
    
    let yangLaoLabel = UILabel.create(text: "养老保险个人缴费: ", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))
    let yiLiaoLabel = UILabel.create(text: "医疗保险个人缴费：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))
    let shengYuLabel = UILabel.create(text: "生育保险个人缴费：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))
    let gongShangLabel = UILabel.create(text: "工伤保险个人缴费：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))
    let shiYeLabel = UILabel.create(text: "失业保险个人缴费：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(13), isBody: false))
    let sheBaoLabel = UILabel.create(text: "社保扣除：", textColor: uicolorff5050, align: .left, fontSize: UIFont.size(size: scale(18), isBody: true))

    var kouChuJishu:CGFloat = 0 {
        didSet{
            titleLabel.text = "社保缴费基数 " + "\(kouChuJishu)" + "（元）"
            let yangLao = useRoundedFloatStrWith(string:  "\(Double(kouChuJishu * 0.08))", precision: 1)
            yangLaoLabel.text = "养老保险个人缴费: " + yangLao + "元"
            var yiliaoJin = Double(kouChuJishu * 0.02)
            if kouChuJishu > 0 {
                yiliaoJin += 3
            }
            let yiliao = useRoundedFloatStrWith(string:"\(yiliaoJin)", precision: 1)
            yiLiaoLabel.text = "医疗保险个人缴费：" + yiliao + "元"
            var shiye = useRoundedFloatStrWith(string:"\(Double(kouChuJishu * 0.002))", precision: 1)
            if currentStyle == 1 {
                shiye = "0"
            }
            shiYeLabel.text = "失业保险个人缴费：" + shiye + "元"
            shengYuLabel.text = "生育保险个人缴费：0.0 元"
            gongShangLabel.text = "工伤保险个人缴费：0.0 元"
            let x:Double = Double(yiliao) ?? 0
            let y:Double = Double(yangLao) ?? 0
            let z:Double =  Double(shiye) ?? 0
            wuXianKouChu = CGFloat( x + y + z )
        }
    }
    
    var wuXianKouChu:CGFloat = 0 {
        didSet{
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.roundingMode = .floor
            
            let number = numberFormatter.number(from: "\(wuXianKouChu)") ?? NSNumber(value: 0.0)
            sheBaoLabel.text = "社保扣除：\(number)"
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
            let title = "\(item)%))"
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
        for (index,item) in configStyles.enumerated() {
            let btn = UIButton()
            btn.layer.borderColor = uicolorf1.cgColor
            btn.layer.borderWidth = 1
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = scale(3)
            btn.setTitle(item, for: .normal)
            btn.tag = index
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
        contentView.addSubview(yangLaoLabel)
        contentView.addSubview(yiLiaoLabel)
        contentView.addSubview(shengYuLabel)
        contentView.addSubview(gongShangLabel)
        contentView.addSubview(shiYeLabel)
        contentView.addSubview(sheBaoLabel)
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
        
        yangLaoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(grayView.snp.bottom).offset(scale(13))
        }
        yiLiaoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(yangLaoLabel.snp.bottom).offset(scale(13))
        }
        shengYuLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(yiLiaoLabel.snp.bottom).offset(scale(13))
        }
        gongShangLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(shengYuLabel.snp.bottom).offset(scale(13))
        }
        shiYeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(gongShangLabel.snp.bottom).offset(scale(13))
        }
        for (index,btn) in stylesList.enumerated() {
            contentView.addSubview(btn)
            let btnWidth = scale(80)
            let btnHeight = scale(40)
            if index == 1 {
                btn.snp.makeConstraints { (make) in
                    make.right.equalTo(stylesList[0].snp.left).offset(scale(-5))
                    make.centerY.equalTo(shiYeLabel.snp.centerY)
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
            }else if index == 0 {
                btn.snp.makeConstraints { (make) in
                    make.centerY.equalTo(shiYeLabel.snp.centerY)
                    make.right.equalToSuperview().offset(scale(-13))
                    make.width.equalTo(btnWidth)
                    make.height.equalTo(btnHeight)
                }
            }
        }

        sheBaoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(scale(13))
            make.top.equalTo(shiYeLabel.snp.bottom).offset(scale(13))
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
                titleLabel.text = "社保缴费基数" + "\(kouChuJishu)" + "（元）"
            }else if btnList[index].tag == currentTag{
                let moneyString = useRoundedFloatStrWith(string: "\(salary*(CGFloat(item))/100.0)" , precision: 1)
                let money = Double(moneyString) ?? 0
                let jishu = CGFloat(money)
                kouChuJishu = jishu > jiShuMax ? jiShuMax : jishu
                titleLabel.text = "社保缴费基数 " + "\(kouChuJishu)" + "（元）"
            }
        }
    }
    @objc func buttonClick(sender: UIButton){
        currentTag = sender.tag
        let jishu = salary*(CGFloat(currentTag))/100.0
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

extension WuXian:UITextFieldDelegate {
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
