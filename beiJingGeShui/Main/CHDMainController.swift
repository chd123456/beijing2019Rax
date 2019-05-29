//
//  CHDMainController.swift
//  beiJingGeShui
//
//  Created by 崔海达 on 2018/12/30.
//  Copyright © 2018年 hida. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
let jiShuMax:CGFloat = 25401
class CHDMainController: CHDController {
    lazy var mainTableView: UITableView = {
        let mainTableView = UITableView(frame: CGRect.zero, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.showsHorizontalScrollIndicator = false
        mainTableView.estimatedRowHeight = 200
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = uicolorf5
        return mainTableView
    }()
    let btn = UIButton()
    let qiZhengDian = QiZhengDian()
    let zhuanXiangKouChu = ZhuanXiangKouChu()
    let gongZiCell = GongZiCell()
    let wuXian = WuXian()
    let yiJin = YiJin()
    var keyboardRec:CGRect?
    var historyContentOffSizeY:CGFloat = 0
    var salary:CGFloat = 0 {
        didSet{
            wuXian.salary = salary;
            yiJin.salary = salary
        }
    }
   
    override func loadView() {
        super.loadView()
        initWithPerproty()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "北京2019个税计算器"
        self.view.addSubview(mainTableView)
        self.view.addSubview(btn)
        self.gongZiCell.delegate = self
        mainTableView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(scale(-50))
        }
        btn.snp.makeConstraints { (make) in
            make.height.equalTo(scale(50))
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        let item = UIBarButtonItem(title: "关于", style: .done, target: self, action:#selector(self.about))
        
        self.navigationItem.rightBarButtonItem = item
        
        let leftItem = UIBarButtonItem(title: "分享", style: .done, target: self, action: #selector(self.shareClick))
        self.navigationItem.leftBarButtonItem = leftItem
        animationForMoneyCell(label: gongZiCell.titleLabel, message: "")
        gongZiCell.textView.becomeFirstResponder()
    }
    
    @objc func about()
    {
        let vc = CHDAboutViewController()
        vc.title = "关于"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func shareClick()
    {
        CHDShare.shared(forDescript: "北京个税计算器", imageName: "1024", setUrl: "https://itunes.apple.com/us/app/beijing2019geshuijisuanqi/id1450487394?l=zh&ls=1&mt=8", isUseAirDrop: true, currentViewController: self, comletedHandle: {
            
        }) {
            
        }
    }
    
    func initWithPerproty(){
        btn.setTitle("计算", for: .normal)
        btn.titleLabel?.font = UIFont.size(size: scale(15), isBody: false)
        btn.setTitleColor(uicolor999, for: .normal)
        btn.setBackgroundImage(UIImage(color: uicolorf1), for: .normal)
        btn.setBackgroundImage(UIImage(color: uicolorf1), for: .highlighted)
        btn.setBackgroundImage(UIImage(color: uicolorff5050), for: .selected)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.isSelected = true
        btn.addTarget(self, action: #selector(self.handdleBtnCLick(sender:)), for: .touchUpInside)
        addNuberKey(textfiled: gongZiCell.textView)
        addNuberKey(textfiled: wuXian.textView)
        addNuberKey(textfiled: yiJin.textView)
        addNuberKey(textfiled: qiZhengDian.textView)
        addNuberKey(textfiled: zhuanXiangKouChu.textView)
        gongZiCell.textView.delegate = gongZiCell
        wuXian.textView.delegate = wuXian
        yiJin.textView.delegate = yiJin
    }
    
    @objc func handdleBtnCLick(sender:UIButton){
        if sender.isSelected {
            let vc = CHDResultViewController()
            let zhuanxiang = Double(zhuanXiangKouChu.textView.text ?? "0") ?? 0
            let yingShuiE = salary - wuXian.wuXianKouChu - yiJin.yiJinKouChu - 5000 - CGFloat(zhuanxiang)
            vc.yingShuiE = yingShuiE < 0 ? 0 : yingShuiE
            vc.shuiKoukuan = salary - wuXian.wuXianKouChu - yiJin.yiJinKouChu
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            animationForMoneyCell(label: gongZiCell.titleLabel, message: "亲爱的，请先输入税前工资。")
            gongZiCell.grayView.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //注册监听
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDisShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func handleKeyboardHide(notification: NSNotification) {
        if gongZiCell.textView.text?.count ?? 0 > 0 {
            self.btn.isSelected = true
        }else{
            self.btn.isSelected = false
        }
    }
    
    @objc func handleKeyboardDisShow(notification: NSNotification) {
        //得到键盘frame
        if self.gongZiCell.textView.isFirstResponder == true
           || self.wuXian.textView.isFirstResponder == true
           || self.yiJin.textView.isFirstResponder == true {
            return
        }
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let value = userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
        let keyboardRec = (value as AnyObject).cgRectValue
        self.keyboardRec = keyboardRec
        var height = keyboardRec?.size.height ?? 0

        //让textView bottom位置在键盘顶部
        UIView.animate(withDuration: 0.1, animations: {
            
            if let window = UIApplication.shared.keyWindow{
                let rect =  self.zhuanXiangKouChu.convert(self.zhuanXiangKouChu.bounds, to: window)
                let bottom_y = rect.origin.y + rect.size.height
                
                let keyTop = SCREEN_HEIGHT - height
                
                let offset = bottom_y - keyTop
                
                height = offset
                
                let x = self.mainTableView.contentOffset.x
                let y = self.mainTableView.contentOffset.y + height
                self.mainTableView.contentOffset = CGPoint(x: x, y: y)
            }
            
        })
        
    }
}

func addNuberKey(textfiled:UITextField)
{
    let keyboard = DigitalKeyboard(view: textfiled.superview ?? UIView())
    keyboard.style = .number
    keyboard.backgroundColor = UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 255.0/255.0, alpha: 1)
    keyboard.customDoneButton(title: "完成", titleColor: .white, theme: UIColor(red: 3.0/255.0, green: 192.0/255.0, blue: 255.0/255.0, alpha: 1) , target: nil, callback: nil)
    keyboard.isSafety = false
    textfiled.inputView = keyboard
}

extension CHDMainController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            return gongZiCell
        }else if (indexPath.row == 1) {
            return wuXian
        }else if (indexPath.row == 2) {
            return yiJin
        }else if (indexPath.row == 3) {
            return qiZhengDian
        }else if (indexPath.row == 4) {
            return zhuanXiangKouChu
        }
        else{
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            gongZiCell.salary = salary
        }else if indexPath.row == 1 {
            wuXian.salary = salary
        }else if indexPath.row == 2 {
            yiJin.salary = salary
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.historyContentOffSizeY = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.historyContentOffSizeY = scrollView.contentOffset.y
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < self.historyContentOffSizeY { //down
            gongZiCell.textView.resignFirstResponder()
            wuXian.textView.resignFirstResponder()
            yiJin.textView.resignFirstResponder()
            qiZhengDian.textView.resignFirstResponder()
            zhuanXiangKouChu.textView.resignFirstResponder()
        }
    }
    
}

extension CHDMainController: GongZiCellDelagate {
    func setSalary(salary: CGFloat) {
        self.salary = salary
    }
}
