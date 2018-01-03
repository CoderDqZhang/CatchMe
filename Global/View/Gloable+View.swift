//
//  Gloable+View.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class Gloable_View: NSObject {

}

class GloabLineView: UIView {
    
    let lineLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        lineLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        //gba(216,216,216,1)
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_EEEEEE_Color)
        self.addSubview(lineLabel)
    }
    
    func setLineColor(_ color:UIColor){
        lineLabel.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CustomButtonType {
    case withNoBoarder
    case withBoarder
    case withBackBoarder
    case widthDisbale
    
}

typealias CustomButtonClouse = (_ tag:NSInteger) -> Void
class CustomTouchButton: AnimationTouchView {
    
    var topButton:UIButton!
    var backButton:UIButton!
    
    var isEnabled:Bool = false
    
    init(frame:CGRect, title:String, tag:NSInteger?, titleFont:UIFont, type:CustomButtonType, pressClouse:@escaping CustomButtonClouse) {
        super.init(frame: frame) {
            pressClouse(tag!)
        }
        self.layer.cornerRadius = frame.size.height / 2
        self.layer.masksToBounds = true
        
        
        if type == .withBackBoarder {
            backButton = UIButton.init(type: .custom)
            backButton.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
            self.addSubview(backButton)
            backButton.layer.cornerRadius = (frame.size.height - 2) / 2
            backButton.layer.masksToBounds = true
            backButton.frame = CGRect.init(x: 0, y: 2, width: frame.size.width, height: frame.size.height - 2)
        }
        
        
        topButton = UIButton.init(type: .custom)
        self.addSubview(topButton)
        topButton.setTitle(title, for: UIControlState())
        topButton.titleLabel?.font = titleFont
        topButton.layer.masksToBounds = true
        topButton.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 2)
        
        if tag != nil {
            self.tag = tag!
        }
        switch type {
        case .withNoBoarder:
            self.setWithNoBoarderButton()
        case .withBoarder:
            topButton.layer.cornerRadius = (frame.height - 2) / 2
            self.setWithBoarderButton()
        case .withBackBoarder:
            topButton.layer.cornerRadius = (frame.height - 2) / 2
            self.setwithonBoarderButton()
        default:
            topButton.layer.cornerRadius = (frame.height - 2) / 2
            self.setWithDisbleBoarderButton()
        }
    }
    
    func setButtonIsEnabled(isEnabled:Bool){
        topButton.isEnabled = isEnabled
        if isEnabled {
            topButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color, andAlpha: 1)
        }else{
            topButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color, andAlpha: 0.7)
        }
    }
    
    func setWithNoBoarderButton(){
        topButton.buttonSetTitleColor(App_Theme_CCCCCC_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F94856_Color).cgColor
        self.layer.borderWidth = 1.0
        topButton.buttonSetTitleColor(App_Theme_F94856_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithDisbleBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_BBC1CB_Color).cgColor
        self.layer.borderWidth = 1.0
        topButton.buttonSetTitleColor(App_Theme_BBC1CB_Color, sTitleColor: App_Theme_BBC1CB_Color)
    }
    
    func setwithonBoarderButton(){
        
        topButton.setTitleColor(UIColor.white, for: UIControlState())
        topButton.buttonSetThemColor(App_Theme_F94856_Color, selectColor: App_Theme_F94856_Color, size: CGSize.init(width: self.frame.size.width, height: self.frame.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomViewButton: AnimationTouchView {
    
    var imageView:UIImageView!
    var label:UILabel!
    //size = 34+11,34 + 14
    init(frame:CGRect, title:String, image:UIImage, tag:NSInteger?, click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        
        imageView = UIImageView.init(frame: CGRect.init(x: 11, y: 0, width: 68, height: 68))
        imageView.image = image
        self.addSubview(imageView)
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: 77, width: frame.size.width, height: 20))
        label.textAlignment = .center
        label.text = title
        label.font = App_Theme_PinFan_R_14_Font
        label.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        self.isUserInteractionEnabled = true
        self.tag = tag!
        self.addSubview(label)
    }
    
    func changeLabelText(str:String) {
        label.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustonPayTypeView: UIView {
    var imageView:UIImageView!
    var lable:UILabel!
    var isSelect:Bool!
    
    init(frame:CGRect, image:UIImage, title:String, isSelect:Bool) {
        super.init(frame: frame)
        imageView = UIImageView.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum GloabelShareAndConnectUsType {
    case share
    case connectUs
}

enum ClickType {
    case weChatService
    case weChatChat
    case weChatSession
    case phoneCall
    case QQService
    case QQChat
}

typealias GloabelImageAndLabelClouse = () ->Void

class GloabelImageAndLabel : AnimationTouchView {
    
    var imageView:UIImageView!
    var titleLabel:UILabel!
    var gloabelImageAndLabelClouse:GloabelImageAndLabelClouse!
    
    init(frame: CGRect,title:String, image:UIImage,clouse:@escaping GloabelImageAndLabelClouse) {
        super.init(frame: frame) {
            clouse()
        }
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        imageView.image = image
        self.gloabelImageAndLabelClouse = clouse
        self.addSubview(imageView)
        
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 68, width: 60, height: 20))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_14_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_444444_Color)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias  GloabelShareAndConnectUsClouse = (_ type:ClickType) ->Void

let GloabelShareAndConnectUsTag = 1000
class GloabelShareAndConnectUs: UIView {
    
    var backGroundImage:UIImageView!
    var isHaveWeChat:Bool = WXApi.isWXAppInstalled()
    var isHaveQQ:Bool = TencentOAuth.iphoneQQInstalled()
    var titleLabel:UILabel!
    var detailView = UIView.init()
    
    var lineLabel:GloabLineView!
    var gloabelShareAndConnectUsClouse:GloabelShareAndConnectUsClouse!
    
    var weChat:GloabelImageAndLabel!
    var weChatSession:GloabelImageAndLabel!
    var qq:GloabelImageAndLabel!
    
    init(type:GloabelShareAndConnectUsType,title:String?,clickClouse:@escaping GloabelShareAndConnectUsClouse) {
        super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 250))
        self.tag = GloabelShareAndConnectUsTag
        AnimationTools.shareInstance.moveAnimation(view: self, frame: CGRect.init(x: 0, y: SCREENHEIGHT - 250, width: SCREENWIDTH, height: 250), finishClouse: { ret in
            
        })
        self.tag = 120
        self.gloabelShareAndConnectUsClouse = clickClouse
        backGroundImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 250))
        backGroundImage.image = UIImage.init(color: UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.75), size: CGSize.init(width: SCREENWIDTH, height: 250))
        backGroundImage.blur()
        self.addSubview(backGroundImage)
        
        self.setUpNormaleView()
        
        if type == .share {
            self.setUpShareView(title:title)
        }else{
            self.setUpConnectUsView(title:title)
        }
    }
    
    func setUpNormaleView(){
        titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_16_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(28)
        }
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.addSubview(lineLabel)
        
        let cancelButton = AnimationButton.init()
        cancelButton.setImage(UIImage.init(named: "close"), for: .normal)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (active) in
            self.removeSelf()
        }
        self.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 40, height: 40))
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-18)
        }
    }
    
    func removeSelf(){
        if weChat != nil {
            weChat.frame = CGRect.init(x: weChat.frame.origin.x, y: 0, width: 60, height: 88)
            weChat.layer.add(AnimationTools.shareInstance.setUpAnimation(244, velocity: 7.0, finish: {_ in
                
            }), forKey: "weChat")
        }
        if weChatSession != nil {
            weChatSession.frame = CGRect.init(x: weChatSession.frame.origin.x, y: 0, width: 60, height: 88)
            weChatSession.layer.add(AnimationTools.shareInstance.setUpAnimation(244, velocity: 7.0, finish: {_ in
                
            }), forKey: "weChat")
        }
        if qq != nil {
            qq.frame = CGRect.init(x: qq.frame.origin.x, y: 0, width: 60, height: 88)
            qq.layer.add(AnimationTools.shareInstance.setUpAnimation(244, velocity: 7.0, finish: {_ in
                
            }), forKey: "weChat")
        }
        
        self.frame = CGRect.init(x: 0, y: SCREENHEIGHT - 250, width: SCREENWIDTH, height: 250)
        self.layer.add(AnimationTools.shareInstance.setUpAnimation(SCREENHEIGHT + 250, velocity: 1.0, finish: {_ in
            
        }), forKey: "AnimationTools")
        _ = Timer.after(1, {
            self.removeFromSuperview()
        })
    }
    
    func setUpShareView(title:String?){
        titleLabel.text = title!
        var maxX:CGFloat = 0
        if isHaveWeChat {
            weChat = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 90, width: 60, height: 88), title: "微信", image: UIImage.init(named: "wechat")!){
                self.gloabelShareAndConnectUsClouse(.weChatChat)
                self.removeSelf()
            }
            _ = Timer.after(0.8, {
                self.weChat.frame = CGRect.init(x: self.weChat.frame.origin.x, y: 0, width: 60, height: 88)
            })
            weChat.layer.add(AnimationTools.shareInstance.setUpAnimation(44, velocity: 8.0, finish: {_ in
            }), forKey: "weChat")
            maxX = weChat.frame.maxX + 45
            detailView.addSubview(weChat)
            
            
            weChatSession = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 90, width: 60, height: 88), title: "朋友圈", image: UIImage.init(named: "friends")!){
                self.gloabelShareAndConnectUsClouse(.weChatSession)
                self.removeSelf()
            }
            _ = Timer.after(0.8, {
                self.weChatSession.frame = CGRect.init(x: self.weChatSession.frame.origin.x, y: 0, width: 60, height: 88)
            })
            weChatSession.layer.add(AnimationTools.shareInstance.setUpAnimation(44, velocity: 6.0, finish: {_ in

            }), forKey: "weChatSession")
            maxX = weChatSession.frame.maxX + 45
            detailView.addSubview(weChatSession)
            
        }
        
        if isHaveQQ {
            
            qq = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 90, width: 60, height: 88), title: "QQ", image: UIImage.init(named: "QQ")!){
                self.gloabelShareAndConnectUsClouse(.QQChat)
                self.removeSelf()
            }
            
            _ = Timer.after(0.8, {
                self.qq.frame = CGRect.init(x: self.qq.frame.origin.x, y: 0, width: 60, height: 88)
            })
            
            qq.layer.add(AnimationTools.shareInstance.setUpAnimation(44, velocity: 2.0, finish: {_ in

            }), forKey: "qq")
            maxX = qq.frame.maxX + 45
            detailView.addSubview(qq)
            
        }
        detailView.frame = CGRect.init(x: (SCREENWIDTH - maxX + 45)/2, y: 74, width: maxX - 45, height: 88)
        self.addSubview(detailView)
    }
    
    func setUpConnectUsView(title:String?){
        titleLabel.text = title!
        var maxX:CGFloat = 0
        if isHaveWeChat {
            let weChat = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服微信", image: UIImage.init(named: "wechat")!){
                self.gloabelShareAndConnectUsClouse(.weChatService)
                self.removeSelf()
            }
            detailView.addSubview(weChat)
            maxX = weChat.frame.maxX + 45
        }
        let phoneCall = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服电话", image: UIImage.init(named: "contact_about")!){
            self.gloabelShareAndConnectUsClouse(.phoneCall)
            self.removeSelf()
        }
        detailView.addSubview(phoneCall)
        maxX = phoneCall.frame.maxX + 45
        
        if isHaveQQ {
            let qq = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服QQ", image: UIImage.init(named: "QQ")!){
                self.gloabelShareAndConnectUsClouse(.QQService)
                self.removeSelf()
            }
            detailView.addSubview(qq)
            maxX = qq.frame.maxX + 45
        }
        detailView.frame = CGRect.init(x: (SCREENWIDTH - maxX + 45)/2, y: 74, width: maxX - 45, height: 88)
        self.addSubview(detailView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

enum GloableAlertViewType {
    case success
    case catchfail
    case topupfail
    case selectSex
    case showUser
}

typealias GloableAlertViewClouse = (_ tag:Int) ->Void

class GloableAlertView: UIView {
    
    var backView:UIView!
    
    var detailView:UIView!
    var topImage:UIImageView!
    var time:Timer!
    var successTime:Timer!
    var timeDone:Bool = false
    
    var gloableAlertViewClouse:GloableAlertViewClouse!
    
    init(title:String, desc:String?, btnTop:String, btnBottom:String, image:UIImage?, topImageUrl:String?, type:GloableAlertViewType, clickClouse:GloableAlertViewClouse!) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.gloableAlertViewClouse = clickClouse
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.7)
        
        backView = UIView.init()
        self.addSubview(backView)
        
        detailView = UIView.init()
        detailView.layer.cornerRadius = 10
        detailView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        backView.addSubview(detailView)
        
        if type == .topupfail {
            detailView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(7)
                make.size.equalTo(CGSize.init(width: 240, height: 230))
            }
        }else if type == .showUser {
            detailView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(7)
                make.size.equalTo(CGSize.init(width: 240, height: 232.5))
            }
        }else{
            detailView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(10)
                make.size.equalTo(CGSize.init(width: 240, height: 200))
            }
        }
        
        topImage = UIImageView.init()
        if image != nil {
            topImage.image = image
        }
        backView.addSubview(topImage)
        if type == .showUser {
            UIImageViewManger.sd_imageView(url: topImageUrl!, imageView: topImage, placeholderImage: nil, completedBlock: { (image, error, cacheType, url) in
                
            })
            topImage.layer.borderColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)?.cgColor
            topImage.layer.borderWidth = 2.0
            topImage.layer.cornerRadius = 46
            topImage.clipsToBounds = true
            topImage.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 92, height: 92))
                make.bottom.equalTo(self.detailView.snp.top).offset(46)
            }
        }else{
            topImage.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.bottom.equalTo(self.detailView.snp.top).offset(type == .success ? 7 : type == .catchfail ? 21 : type == .selectSex ? 8 : 18)
            }
        }

        AnimationTools.shareInstance.scalAnimation(view: backView)
        if type == .showUser {
            backView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 223.5))
            }
        }else{
            backView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: (type == .topupfail ? 230 : 200) +  (image?.size.height)!))
            }
        }
        
        let titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_18_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        UILabel.changeLineSpace(for: titleLabel, withSpace: 4)
        titleLabel.textAlignment = .center
        detailView.addSubview(titleLabel)
        
        if type == .showUser {
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(self.topImage.snp.bottom).offset(8)
            }
        }else{
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(self.detailView.snp.top).offset(27)
            }
        }
        
        if desc != nil {
            let descLabel = UILabel.init()
            descLabel.font = App_Theme_PinFan_R_12_Font
            descLabel.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
            descLabel.text = desc
            descLabel.numberOfLines = 0
            UILabel.changeLineSpace(for: titleLabel, withSpace: 4)
            descLabel.textAlignment = .center
            detailView.addSubview(descLabel)
            
            descLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(titleLabel.snp.bottom).offset(3)
            }
        }
        
        
        let leftLabel = self.createLabel()
        detailView.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.detailView.snp.left).offset(-9)
            make.size.equalTo(CGSize.init(width: 18, height: 18))
            make.top.equalTo(self.detailView.snp.top).offset(162)
        }
        
        let rightLabel = self.createLabel()
        detailView.addSubview(rightLabel)
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.detailView.snp.right).offset(9)
            make.size.equalTo(CGSize.init(width: 18, height: 18))
            make.top.equalTo(self.detailView.snp.top).offset(26)
        }
        if type == .selectSex {
            self.setUpSexView(btnTop: btnTop, btnBottom: btnBottom)
        }else{
            self.setUpView(btnTop: btnTop, btnBottom: btnBottom, type: type)
        }
    }
    
    func setUpSexView(btnTop:String, btnBottom:String){
        let male = AnimationButton.init(frame: CGRect.zero)
        male.setImage(UIImage.init(named: "帅哥"), for: .normal)
        male.setImage(UIImage.init(named: "帅哥"), for: .highlighted)
        male.reactive.controlEvents(.touchUpInside).observe { (btn) in
            self.gloableAlertViewClouse(100)
            self.removeSelf()
        }
        detailView.addSubview(male)
        male.snp.makeConstraints { (make) in
            make.left.equalTo(detailView.snp.left).offset(26)
            make.bottom.equalTo(detailView.snp.bottom).offset(-45)
        }
        
        let maleLabel = UILabel.init()
        maleLabel.text = btnTop
        maleLabel.font = App_Theme_PinFan_R_14_Font
        maleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        detailView.addSubview(maleLabel)
        maleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(detailView.snp.left).offset(52)
            make.bottom.equalTo(detailView.snp.bottom).offset(-21)
        }
        
        let female = AnimationButton.init(frame: CGRect.zero)
        female.setImage(UIImage.init(named: "美女"), for: .normal)
        female.setImage(UIImage.init(named: "美女"), for: .highlighted)
        female.reactive.controlEvents(.touchUpInside).observe { (btn) in
            self.gloableAlertViewClouse(200)
            self.removeSelf()
        }
        detailView.addSubview(female)
        female.snp.makeConstraints { (make) in
            make.right.equalTo(detailView.snp.right).offset(-26)
            make.bottom.equalTo(detailView.snp.bottom).offset(-45)
        }
        
        let femaleLabel = UILabel.init()
        femaleLabel.text = btnBottom
        femaleLabel.font = App_Theme_PinFan_R_14_Font
        femaleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        detailView.addSubview(femaleLabel)
        femaleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(detailView.snp.right).offset(-52)
            make.bottom.equalTo(detailView.snp.bottom).offset(-21)
        }
        
    }
    
    func setUpView(btnTop:String, btnBottom:String, type:GloableAlertViewType) {
        
        let detailTopView = AnimationTouchView.init(frame: CGRect.zero) {
            if self.time != nil {
                self.time.invalidate()
            }
            if !self.timeDone {
                self.gloableAlertViewClouse(100)
            }
            self.removeSelf()
        }
        detailView.addSubview(detailTopView)

        let topButton_bg = self.createButton(title: btnTop)
        topButton_bg.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
        detailTopView.addSubview(topButton_bg)
        
        let topButton = self.createButton(title: btnTop)
        detailTopView.addSubview(topButton)
        
        topButton.snp.makeConstraints { (make) in
            make.left.equalTo(detailTopView.snp.left).offset(0)
            make.top.equalTo(detailTopView.snp.top).offset(0)
            make.size.equalTo(CGSize.init(width: 150, height: 42))
        }
        topButton_bg.snp.makeConstraints { (make) in
            make.left.equalTo(detailTopView.snp.left).offset(0)
            make.top.equalTo(detailTopView.snp.top).offset(2)
            make.size.equalTo(CGSize.init(width: 150, height: 42))
        }
        
        if type == .topupfail {
            detailTopView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(self.detailView.snp.top).offset(92)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }else if type == .showUser {
            detailTopView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(self.detailView.snp.top).offset(107)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }else{
            detailTopView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.top.equalTo(self.detailView.snp.top).offset(67)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }
        
        let detailBottomView = AnimationTouchView.init(frame: CGRect.zero) {
            if self.time != nil {
                self.time.invalidate()
            }
            self.gloableAlertViewClouse(200)
            self.removeSelf()
        }
        detailView.addSubview(detailBottomView)
        
        let btn_bg = self.createButton(title: btnBottom)
        if type == .topupfail {
            btn_bg.backgroundColor = UIColor.init(hexString: App_Theme_F5F5F5_Color)
        }else if type == .showUser {
            btn_bg.backgroundColor = UIColor.init(hexString: App_Theme_EAEAEA_Color)
        }else{
            btn_bg.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
        }
        detailBottomView.addSubview(btn_bg)
        btn_bg.snp.makeConstraints { (make) in
            make.left.equalTo(detailBottomView.snp.left).offset(0)
            make.top.equalTo(detailBottomView.snp.top).offset(2)
            make.size.equalTo(CGSize.init(width: 150, height: 42))
        }
        let btn = self.createButton(title: btnBottom)
        detailBottomView.addSubview(btn)
        if type == .showUser {
            btn.backgroundColor = UIColor.init(hexString: App_Theme_1081FF_Color)
        }
        btn.snp.makeConstraints { (make) in
            make.left.equalTo(detailBottomView.snp.left).offset(0)
            make.top.equalTo(detailBottomView.snp.top).offset(0)
            make.size.equalTo(CGSize.init(width: 150, height: 42))
        }
        if type == .topupfail {
            detailBottomView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.bottom.equalTo(self.detailView.snp.bottom).offset(-37)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }else if type == .showUser {
            detailBottomView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.bottom.equalTo(self.detailView.snp.bottom).offset(-25)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }else{
            detailBottomView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
                make.bottom.equalTo(self.detailView.snp.bottom).offset(-32)
                make.size.equalTo(CGSize.init(width: 150, height: 44))
            }
        }
        
        var number = 5
        if type == .catchfail {
            time = Timer.every(1, {
                number = number - 1
                if number == 0 {
                    self.removeSelf()
                    self.gloableAlertViewClouse(200)
                    self.time.invalidate()
                }
                topButton.setTitle("再试一次\(number)s", for: .normal)
            })
        }else if type == .topupfail{
            btn.backgroundColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        }else if type == .success {
            successTime = Timer.every(1, {
                number = number - 1
                if number == 0 {
                    self.timeDone = true
                    topButton.setTitle("无力再试", for: .normal)
                    self.gloableAlertViewClouse(1000)
                    self.successTime.invalidate()
                }else{
                    topButton.setTitle("再试一次\(number)s", for: .normal)
                }
            })
        }else if type == .showUser {
            
        }
    }
    
    deinit {
        time.invalidate()
    }
    
    func removeSelf(){
        AnimationTools.shareInstance.removeViewAnimation(view: self.backView, finish: {_ in 
            self.removeFromSuperview()
        })
    }
    
    func createButton(title:String) ->UIButton{
        let button = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        button.titleLabel?.font = App_Theme_PinFan_M_16_Font
        button.layer.cornerRadius = 21
        button.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        return button
    }
    
    func createLabel() ->UILabel {
        let label = UILabel.init()
        label.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GLoabelViewLabel:UIView {
    class func addLabel(label:UILabel,view:UIView, isWithNumber:Bool){
        GLoabelViewLabel.setUpLeftLabel(label: label, view: view, isWithNumber: isWithNumber)
        GLoabelViewLabel.setUpRightLabel(label: label, view: view, isWithNumber: isWithNumber)
    }
    
    class func setUpLeftLabel(label:UILabel,view:UIView, isWithNumber:Bool){
        let leftLabel = UIImageView.init()
        leftLabel.image = UIImage.init(named: "left_label")
        view.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.right.equalTo(label.snp.left).offset(-4)
            make.centerY.equalTo(label.snp.centerY).offset(isWithNumber ? 4 : 0)
        }
        view.updateConstraintsIfNeeded()
    }
    
    class func setUpRightLabel(label:UILabel,view:UIView, isWithNumber:Bool){
        let rightLabel = UIImageView.init()
        rightLabel.image = UIImage.init(named: "left_label")
        view.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(4)
            make.centerY.equalTo(label.snp.centerY).offset(isWithNumber ? 4 : 0)
        }
        view.updateConstraintsIfNeeded()
    }
}


typealias BackButtonClouse = () ->Void

class GLoabelNavigaitonBar:UIView {
    var title:UILabel!
    var backButton:UIButton!
    
    init(frame: CGRect, click:@escaping BackButtonClouse) {
        super.init(frame:frame)
        title = UILabel.init()
        title.text = "七日大神榜"
        title.font = App_Theme_PinFan_R_17_Font
        title.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(13)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "back_bar"), for: .normal)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            click()
        }
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(10)
            make.left.equalTo(self.snp.left).offset(6)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func changeBackGroundColor(isTheme:Bool){
        self.backgroundColor = isTheme ? UIColor.init(hexString: App_Theme_FC4652_Color) : UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum GloabelStatusViewType {
    case male
    case female
    case oline
    case onGame
}

class GloabelStatusView:UIView {
    
    var titleLabel:UILabel!
    init(frame:CGRect, title:String?, type:GloabelStatusViewType) {
        super.init(frame: frame)
        self.layer.cornerRadius = frame.size.height / 2
        self.layer.masksToBounds = true
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.font = App_Theme_PinFan_M_11_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        switch type {
        case .male:
            self.setUpMaleView()
        case .female:
            self.setUpFemaleView()
        case .oline:
            self.setUpOnlineView()
        default:
            self.setUpOnGameView()
        }
    }
    
    func setUpMaleView(){
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "male")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(6)
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(imageView.snp.right).offset(3)
            make.right.equalTo(self.snp.right).offset(-6)
        }
        self.backgroundColor = UIColor.init(hexString: App_Theme_0070E9_Color)
        
    }
    
    func setUpFemaleView(){
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "female")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(6)
        }
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(imageView.snp.right).offset(3)
            make.right.equalTo(self.snp.right).offset(-6)
        }
        self.backgroundColor = UIColor.init(hexString: App_Theme_F61262_Color)
    }
    
    func setUpOnlineView(){
        self.backgroundColor = UIColor.init(hexString: App_Theme_00C700_Color)
    }
    
    func setUpOnGameView(){
        self.backgroundColor = UIColor.init(hexString: App_Theme_F5A623_Color)
    }
    
    
    func setUpImageView(image:UIImage){
        let imageView = UIImageView.init()
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.centerX).offset(4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias GloableBottomViewClouse = () ->Void
class GloableBottomView: UIView {
    var label:UILabel!
    var gloableBottomViewClouse:GloableBottomViewClouse!
    
    init(frame: CGRect, title:String, click:@escaping GloableBottomViewClouse) {
        super.init(frame: frame)
        self.gloableBottomViewClouse = click
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
        
        label = UILabel.init()
        label.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        label.text = title
        label.textAlignment = .center
        label.font = App_Theme_PinFan_R_20_Font
        label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
        }
    }
    
    @objc func singleTap() {
        if self.gloableBottomViewClouse != nil {
            self.gloableBottomViewClouse()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

