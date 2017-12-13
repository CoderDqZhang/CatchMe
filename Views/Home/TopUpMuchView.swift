//
//  TopUpMuchView.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum MuchViewType {
    case select
    case normal
}

class MuchView: UIView {
    var imageView:UIImageView!
    var muchLable:UILabel!
    var muchIcon:UILabel!
    var muchIconStr:UILabel!
    var muchView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30
        self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true

        
        
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "rechang_choosen")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 90, bottom: 0, right: 64), resizingMode: .stretch)
        self.addSubview(imageView)
        
        muchLable = UILabel.init()
        muchLable.font = App_Theme_PinFan_R_15_Font
        muchLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.addSubview(muchLable)
        
        muchView = UIView.init()
        self.addSubview(muchView)
        
        muchIcon = UILabel.init()
        muchIcon.font = App_Theme_PinFan_M_20_Font
        muchIcon.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        muchView.addSubview(muchIcon)
        
        muchIconStr = UILabel.init()
        muchIconStr.text = "币"
        muchIconStr.font = App_Theme_PinFan_M_16_Font
        muchView.addSubview(muchIconStr)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.right.equalTo(self.snp.right).offset(1)
        }
        
        muchLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-6.5)
        }
        
        muchIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self.muchView.snp.left).offset(0)
            make.top.equalTo(self.muchView.snp.top).offset(0)
        }
        
        muchIconStr.snp.makeConstraints { (make) in
            make.left.equalTo(muchIcon.snp.right).offset(0)
            make.top.equalTo(self.muchView.snp.top).offset(2)
        }
        
    }
    
    func changeType(type:MuchViewType){
        switch type {
        case MuchViewType.select:
            imageView.isHidden = false
            self.layer.cornerRadius = 0
            muchLable.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            muchIcon.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            muchIconStr.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)

            self.layer.borderColor = UIColor.clear.cgColor
           
            let frame = self.frame
            self.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 61)
            muchView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.top.equalTo(self.snp.top).offset(9)
                make.height.equalTo(24)
                make.width.equalTo(40)
            }
            muchLable.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.bottom.equalTo(self.snp.bottom).offset(-12)
            }
        default:
            imageView.isHidden = true
            self.layer.cornerRadius = 30
            muchLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            muchIcon.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            muchIconStr.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
            self.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 56)
            muchLable.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.bottom.equalTo(self.snp.bottom).offset(-6.5)
            }
            muchView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.top.equalTo(self.snp.top).offset(9)
                make.height.equalTo(24)
                make.width.equalTo(40)
            }
        }
    }
    
    func setUpMuchViewData(much:String, icon:String) {
        muchIcon.text = icon
        muchLable.text = much
        muchIconStr.text = "币"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias TopUpMuchViewClouse = (_ tag:Int) -> Void
class TopUpMuchView: UIView {

    var topUpMuchViewClouse:TopUpMuchViewClouse!
    var models:NSMutableArray!
    var model:[RechargeRateRuleDTOList]!
    init(frame: CGRect,models:NSMutableArray?, model:[RechargeRateRuleDTOList]?) {
        super.init(frame: frame)
        self.models = models
        if models != nil {
            self.setUpView(models:models!)
        }
        if model != nil {
            self.model = model
            self.setUpViews(models: model!)
        }
    }
    
    func setUpView(models:NSMutableArray){
//        let icon = ["100币","230币","590币","1200币","2420币","6100币"]
//        let much = ["￥10.00","￥20.00","￥50.00","￥100.00","￥200.00","￥500.00"]
        for i in 1...models.count {
            let frame = CGRect.init(x: (i - 1) % 2 == 0 ? 20 : SCREENWIDTH/2 + 7.5, y: CGFloat((i-1) / 2 * 72), width: (SCREENWIDTH - 40 - 15)/2, height: 56)
            let muchView = MuchView.init(frame: frame)
            muchView.tag = i
            self.setUpSingleTap(muchView: muchView)
            var model:RechargeRateRuleDTOList!
            if models[i - 1] is NSDictionary {
                model = RechargeRateRuleDTOList.init(fromDictionary: models[i - 1] as! NSDictionary)
            }else{
                model = models[i - 1] as! RechargeRateRuleDTOList
            }
            muchView.setUpMuchViewData(much: "￥\(model.rechargeMoney!)", icon: "\(model.rechargeCoin!)")
            if i == 1 {
                muchView.changeType(type: .select)
            }else{
                muchView.changeType(type: .normal)
            }
            self.addSubview(muchView)
        }
    }
    
    func setUpViews(models:[RechargeRateRuleDTOList]){
        //        let icon = ["100币","230币","590币","1200币","2420币","6100币"]
        //        let much = ["￥10.00","￥20.00","￥50.00","￥100.00","￥200.00","￥500.00"]
        for i in 1...models.count {
            let frame = CGRect.init(x: (i - 1) % 2 == 0 ? 20 : SCREENWIDTH/2 + 7.5, y: CGFloat((i-1) / 2 * 72), width: (SCREENWIDTH - 40 - 15)/2, height: 56)
            let muchView = MuchView.init(frame: frame)
            muchView.tag = i
            
            self.setUpSingleTap(muchView: muchView)
            let model = models[i - 1]
            
            muchView.setUpMuchViewData(much: "￥\(model.rechargeMoney!)", icon: "\(model.rechargeCoin!)")
            muchView.changeType(type: .normal)
            self.addSubview(muchView)
        }
    }
    
    func setUpSingleTap(muchView:MuchView){
        let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singTap(tag:)))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        muchView.addGestureRecognizer(singTap)
    }
    
    @objc func singTap(tag:UITapGestureRecognizer){
        let viewTag = tag.view?.tag
        if self.model != nil {
            for i in 1...self.model.count {
                let muchView = self.viewWithTag(i) as! MuchView
                if i == viewTag {
                    muchView.changeType(type: .select)
                }else{
                    muchView.changeType(type: .normal)
                }
            }
        }else{
            for i in 1...self.models.count {
                let muchView = self.viewWithTag(i) as! MuchView
                if i == viewTag {
                    muchView.changeType(type: .select)
                }else{
                    muchView.changeType(type: .normal)
                }
            }
        }
        
        if topUpMuchViewClouse != nil {
            topUpMuchViewClouse(viewTag!)
        }
    }
    
    func changeAllTap(){
        if self.model != nil {
            for i in 1...self.model.count {
                let muchView = self.viewWithTag(i) as! MuchView
                muchView.changeType(type: .normal)
            }
        }else{
            for i in 1...self.models.count {
                let muchView = self.viewWithTag(i) as! MuchView
                muchView.changeType(type: .normal)
            }
        }
    }
    
    func changeAllTag(){
        if self.model != nil {
            for i in 1...self.model.count {
                let muchView = self.viewWithTag(i) as! MuchView
                muchView.changeType(type: .normal)
            }
        }else{
            for i in 1...self.models.count {
                let muchView = self.viewWithTag(i) as! MuchView
                muchView.changeType(type: .normal)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TopUpWeekView : UIView {
    
    var weekView:WeekView!
    var imageView:UIImageView!
    
    var topUpMuchViewClouse:TopUpMuchViewClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        
        self.clipsToBounds = false
        self.setUpSingleTap()
        weekView = WeekView.init()
        self.addSubview(weekView)
        weekView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
        }
        weekView.changeType(type: .select)
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "pic_周卡")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-12)
            make.bottom.equalTo(self.snp.bottom).offset(3)
            make.size.equalTo(CGSize.init(width: 103, height: 83))
        }
        self.setUpSingleTap()
    }
    
    func setData(model:WeeklyRechargeRateRuleDTO){
        self.weekView.setData(model: model)
    }
    
    func setUpSingleTap(){
        let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singTap(tag:)))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singTap)
    }
    
    @objc func singTap(tag:UITapGestureRecognizer){
        if topUpMuchViewClouse != nil {
            topUpMuchViewClouse(1000)
        }
        weekView.changeType(type: .select)
    }
    
    func changeWeekViewType(){
        weekView.changeType(type: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WeekView : UIView {
    
    var titleLabel:UILabel!
    var descLabel:UILabel!
    var descsLabel:UILabel!
    var imageView:UIImageView!
    
    var topUpMuchViewClouse:TopUpMuchViewClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        
        self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 36
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "pic_周卡")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-12)
            make.bottom.equalTo(self.snp.bottom).offset(2)
            make.size.equalTo(CGSize.init(width: 103, height: 83))
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_13_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(32)
            make.top.equalTo(self.snp.top).offset(17)
        }
        
        descLabel = UILabel.init()
        descLabel.font = App_Theme_PinFan_M_16_Font
        descLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(32)
            make.bottom.equalTo(self.snp.bottom).offset(-14)
        }
        descsLabel = UILabel.init()
        descsLabel.font = App_Theme_PinFan_R_12_Font
        descsLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        descsLabel.text = "分7天返还"
        self.addSubview(descsLabel)
        descsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.descLabel.snp.right).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-14)
        }
        
    }
    
    func setData(model:WeeklyRechargeRateRuleDTO){
        titleLabel.text = "花\(model.rechargeMoney!)得\(model.rechargeCoinReal!)币哦~"
        descLabel.text = "多送主人\(model.totalMoreAmount!)币"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeType(type:MuchViewType){
        switch type {
        case MuchViewType.select:
            descLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            descsLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        default:
            descLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            titleLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            descsLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        }
    }
    
}
