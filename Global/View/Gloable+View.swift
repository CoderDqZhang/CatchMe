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
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
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
class CustomButton: UIButton {
    
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
            self.layer.cornerRadius = 2.0
            self.setWithBoarderButton()
        case .withBackBoarder:
            self.layer.cornerRadius = 2.0
            self.setwithonBoarderButton()
        default:
            self.layer.cornerRadius = 2.0
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
        
        imageView = UIImageView.init(frame: CGRect.init(x: 10, y: 0, width: 68, height: 68))
        imageView.image = image
        self.addSubview(imageView)
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: 72, width: frame.size.width, height: 20))
        label.textAlignment = .center
        label.text = title
        label.font = App_Theme_PinFan_R_14_Font
        label.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.isUserInteractionEnabled = true
        self.tag = tag!
        self.addSubview(label)
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
        super.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 88))
        imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60))
        imageView.image = image
        self.gloabelImageAndLabelClouse = clouse
        self.addSubview(imageView)
        
        titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 68, width: 60, height: 20))
        titleLabel.text = title
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


class GloabelShareAndConnectUs: UIView {
    
    var isHaveWeChat:Bool = WXApi.isWXAppInstalled()
    var isHaveQQ:Bool = TencentOAuth.iphoneQQInstalled()
    var titleLabel:UILabel!
    var detailView = UIView.init()
    
    var lineLabel:GloabLineView!
    var gloabelShareAndConnectUsClouse:GloabelShareAndConnectUsClouse!
    init(type:GloabelShareAndConnectUsType,clickClouse:@escaping GloabelShareAndConnectUsClouse) {
        super.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 250, width: SCREENWIDTH, height: 250))
        
        self.gloabelShareAndConnectUsClouse = clickClouse
        self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.96)
        
        self.setUpNormaleView()
        
        if type == .share {
            self.setUpShareView()
        }else{
            self.setUpConnectUsView()
        }
    }
    
    func setUpNormaleView(){
        titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_16_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(26)
        }
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
        self.addSubview(lineLabel)
        
        let cancelButton = UIButton.init()
        cancelButton.setImage(UIImage.init(named: "close"), for: .normal)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (active) in
            self.removeSelf()
        }
        self.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-30)
        }
    }
    
    func removeSelf(){
        self.removeFromSuperview()
    }
    
    func setUpShareView(){
        titleLabel.text = "分享赢娃娃币"
        var maxX:CGFloat = 0
        if isHaveWeChat {
            let weChat = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "微信", image: UIImage.init(named: "wechat")!){
                self.gloabelShareAndConnectUsClouse(.weChatChat)
                self.removeSelf()
            }
            maxX = weChat.frame.maxX + 45
            detailView.addSubview(weChat)
            
            let weChatSession = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "朋友圈", image: UIImage.init(named: "contact")!){
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
    
    func setUpConnectUsView(){
        titleLabel.text = "联系我们"
        var maxX:CGFloat = 0
        if isHaveWeChat {
            let weChat = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服微信", image: UIImage.init(named: "wechat")!){
                self.gloabelShareAndConnectUsClouse(.weChatService)
                self.removeSelf()
            }
            maxX = weChat.frame.maxX + 45
            detailView.addSubview(weChat)
        }
        let phoneCall = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服电话", image: UIImage.init(named: "contact")!){
            self.gloabelShareAndConnectUsClouse(.phoneCall)
            self.removeSelf()
        }
        maxX = phoneCall.frame.maxX + 45
        detailView.addSubview(phoneCall)
        
        if isHaveQQ {
            let qq = GloabelImageAndLabel.init(frame: CGRect.init(x: maxX, y: 0, width: 60, height: 88), title: "客服QQ", image: UIImage.init(named: "QQ")!){
                self.gloabelShareAndConnectUsClouse(.QQService)
                self.removeSelf()
            }
            maxX = phoneCall.frame.maxX + 45
            detailView.addSubview(qq)
        }
        detailView.frame = CGRect.init(x: (SCREENWIDTH - maxX + 45)/2, y: 74, width: maxX - 45, height: 88)
        self.addSubview(detailView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


