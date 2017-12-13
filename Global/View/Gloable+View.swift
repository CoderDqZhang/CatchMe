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
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
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
class CustomButton: AnimationButton {
    
    init(frame:CGRect, title:String, tag:NSInteger?, titleFont:UIFont, type:CustomButtonType, pressClouse:@escaping CustomButtonClouse) {
        super.init(frame: frame)
        self.setTitle(title, for: UIControlState())
        self.titleLabel?.font = titleFont
        self.layer.masksToBounds = true
        self.frame = frame
        if tag != nil {
            self.tag = tag!
        }
        switch type {
        case .withNoBoarder:
            self.setWithNoBoarderButton()
        case .withBoarder:
            self.layer.cornerRadius = frame.height / 2
            self.setWithBoarderButton()
        case .withBackBoarder:
            self.layer.cornerRadius = frame.height / 2
            self.setwithonBoarderButton()
        default:
            self.layer.cornerRadius = frame.height / 2
            self.setWithDisbleBoarderButton()
        }
        self.reactive.controlEvents(.touchUpInside).observe { (action) in
            if tag != nil {
                self.tag = 1000
            }
            pressClouse(tag!)
        }
    }
    
    func setWithNoBoarderButton(){
        self.buttonSetTitleColor(App_Theme_CCCCCC_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F94856_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_F94856_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithDisbleBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_BBC1CB_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_BBC1CB_Color, sTitleColor: App_Theme_BBC1CB_Color)
    }
    
    func setwithonBoarderButton(){
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.buttonSetThemColor(App_Theme_F94856_Color, selectColor: App_Theme_F94856_Color, size: CGSize.init(width: self.frame.size.width, height: self.frame.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomViewButton: UIView {
    
    var imageView:UIImageView!
    var label:UILabel!
    //size = 34+11,34 + 14
    init(frame:CGRect, title:String, image:UIImage, tag:NSInteger?) {
        super.init(frame: frame)
        
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

class GloabelImageAndLabel:UIView {
    
    var imageView:UIImageView!
    var titleLabel:UILabel!
    var gloabelImageAndLabelClouse:GloabelImageAndLabelClouse!
    
    init(frame: CGRect,title:String, image:UIImage,clouse:@escaping GloabelImageAndLabelClouse) {
        super.init(frame: frame)
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
        
        let sigleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.sigleTapPress))
        sigleTap.numberOfTapsRequired = 1
        sigleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(sigleTap)
    }
    
    @objc func sigleTapPress(){
        self.gloabelImageAndLabelClouse()
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
    init(type:GloabelShareAndConnectUsType,title:String?,clickClouse:@escaping GloabelShareAndConnectUsClouse) {
        super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 250))
        self.tag = GloabelShareAndConnectUsTag
        AnimationTools.shareInstance.moveAnimation(view: self, frame: CGRect.init(x: 0, y: SCREENHEIGHT - 250, width: SCREENWIDTH, height: 250), finishClouse: { ret in
            
        })
        
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
        AnimationTools.shareInstance.moveAnimation(view: self, frame: CGRect.init(x: 0, y: SCREENHEIGHT + 20, width: SCREENWIDTH, height: 250), finishClouse: { ret in
            if ret {
                self.removeFromSuperview()
            }
        })
    }
    
    func setUpShareView(title:String?){
        titleLabel.text = title!
        var maxX:CGFloat = 0
        if isHaveWeChat {
            let weChat = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "微信", image: UIImage.init(named: "wechat")!){
                self.gloabelShareAndConnectUsClouse(.weChatChat)
                self.removeSelf()
            }
            maxX = weChat.frame.maxX + 45
            detailView.addSubview(weChat)
            
            let weChatSession = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "朋友圈", image: UIImage.init(named: "friends")!){
                self.gloabelShareAndConnectUsClouse(.weChatSession)
                self.removeSelf()
            }
            maxX = weChatSession.frame.maxX + 45
            detailView.addSubview(weChatSession)
        }
        
        if isHaveQQ {
            let qq = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "QQ", image: UIImage.init(named: "QQ")!){
                self.gloabelShareAndConnectUsClouse(.QQChat)
                self.removeSelf()
            }
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
    init(title:String, btnTop:String, btnBottom:String, image:UIImage, type:GloableAlertViewType, clickClouse:GloableAlertViewClouse!) {
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
        }else{
            detailView.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(10)
                make.size.equalTo(CGSize.init(width: 240, height: 200))
            }
        }
        
        topImage = UIImageView.init()
        topImage.image = image
        backView.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.detailView.snp.top).offset(type == .success ? 7 : type == .catchfail ? 21 : 18)
        }
        AnimationTools.shareInstance.scalAnimation(view: backView)
        backView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: (type == .topupfail ? 230 : 200) +  image.size.height))
        }
        
        let titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_18_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        UILabel.changeLineSpace(for: titleLabel, withSpace: 4)
        titleLabel.textAlignment = .center
        detailView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
            make.top.equalTo(self.detailView.snp.top).offset(27)
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
        
        self.setUpView(btnTop: btnTop, btnBottom: btnBottom, type: type)
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
                    topButton.setTitle("退出按钮", for: .normal)
                    self.gloableAlertViewClouse(1000)
                    self.successTime.invalidate()
                }else{
                    topButton.setTitle("再试一次\(number)s", for: .normal)
                }
            })
        }
    }
    
    deinit {
        time.invalidate()
    }
    
    func removeSelf(){
        AnimationTools.shareInstance.removeViewAnimation(view: self.backView)
        self.removeFromSuperview()
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
        title.text = "大神榜"
        title.font = App_Theme_PinFan_R_17_Font
        title.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(title)
        
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(3)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "back_bar"), for: .normal)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            click()
        }
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(6)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


