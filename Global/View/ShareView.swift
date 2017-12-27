//
//  ShareView.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ShareModel:NSObject {
    var title:String = ""
    var desc:String = ""
    var imageUrl:String = ""
    var url:String = ""
    override init() {
        super.init()
    }
}

class GloableServiceView: UIView, UIGestureRecognizerDelegate {
    
    var detailView:UIView!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var cancelButton:UIButton!
    var heightY:CGFloat = 0
    
    init(title:String?, message:String?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.backgroundColor = UIColor.init(hexString: App_Theme_333333_Color, andAlpha: 0.5)
        detailView = UIView()
        detailView.backgroundColor = UIColor.white
        self.setUpTitleView(title!)
        let height = self.setUpDetailView(message!)
        
        detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: heightY + 160)
        
        self.setUpCancelButton()
        self.addSubview(detailView)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(GloableServiceView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT - height - 160, width: SCREENWIDTH, height: self.heightY + 160)
        }, completion: { completion in
            
        })
    }
    
    @objc func singleTapPress(_ sender:UITapGestureRecognizer){
        self.removwSelf()
    }
    
    func removwSelf(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: self.heightY + 160)
        }, completion: { completion in
            self.removeFromSuperview()
        })
    }
    
    func setUpDetailView(_ message:String) -> CGFloat {
        let height = (message as NSString).height(with: App_Theme_PinFan_R_17_Font!, constrainedToWidth: SCREENWIDTH - 30)
        detailLabel = UILabel()
        detailLabel.text = message
        detailLabel.numberOfLines = 0
        detailLabel.textColor = UIColor.init(hexString: App_Theme_556169_Color)
        detailLabel.font = App_Theme_PinFan_R_13_Font
        UILabel.changeLineSpace(for: detailLabel, withSpace: TitleLineSpace)
        detailLabel.textAlignment = .center
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: 15, y: 96, width: SCREENWIDTH - 30, height: height)
        detailView.addSubview(detailLabel)
        self.heightY = height
        return height
    }
    
    func setUpCancelButton(){
        cancelButton =  UIButton(type: .custom)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.removwSelf()
        }
        cancelButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 10, width: 40, height: 40)
        cancelButton.setImage(UIImage.init(named: "Btn_Close"), for: UIControlState())
        detailView.addSubview(cancelButton)
    }
    
    func setUpTitleView(_ title:String){
        let recommentTitle = UILabel()
        let width = (title as NSString).width(with: App_Theme_PinFan_M_14_Font!, constrainedToHeight: 20)
        if IPHONE_VERSION >= 9 {
            recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 48, width: width, height: 20)
        }else{
            recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 48, width: width, height: 20)
        }
        
        recommentTitle.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        recommentTitle.font = App_Theme_PinFan_M_14_Font
        recommentTitle.text = title
        recommentTitle.textAlignment = .center
        detailView.addSubview(recommentTitle)
        
        let lineLabel = GloabLineView(frame: CGRect(x: recommentTitle.frame.minX - 50, y: 58, width: 30, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_333333_Color))
        detailView.addSubview(lineLabel)
        let lineLabel1 = GloabLineView(frame: CGRect(x: recommentTitle.frame.maxX + 20, y: 58, width: 30, height: 0.5))
        lineLabel1.setLineColor(UIColor.init(hexString: App_Theme_333333_Color))
        detailView.addSubview(lineLabel1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        let touchPoint = touch.location(in: self)
        return touchPoint.y < SCREENHEIGHT - (self.height + 160) ? true : false
    }
}


class ShareView: UIView, UIGestureRecognizerDelegate, CAAnimationDelegate {
    var detailView:UIView!
    var shareView:UIView!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var cancelButton:UIButton!
    var heightY:CGFloat = 0
    var wxSession:UIButton!
    var wxTimeLine:UIButton!
    var weiboTimeLine:UIButton!
    var qqSeession:UIButton!
    var qqTimeLine:UIButton!
    var shareImage:UIImage!
    var shareModel:ShareModel!
    var ticketImage:UIImage!
    var shareUrl:String!
    init(title:String, model:ShareModel?, image:UIImage?, url:String?) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        shareImage = image
        self.tag = 10000
        if image == nil {
//            ticketImage = SaveImageTools.sharedInstance.LoadImage("\((model?.id)!).png", path: "TicketShowImages", isSmall: false) != nil ? SaveImageTools.sharedInstance.LoadImage("\((model?.id)!).png", path: "TicketShowImages", isSmall: false) : UIImage.init(named: "AboutUs_Logo")
            shareModel = model
        }
        if url != nil {
            shareUrl = url
        }
        self.backgroundColor = UIColor.init(hexString: App_Theme_333333_Color, andAlpha: 0.5)
        detailView = UIView()
        detailView.backgroundColor = UIColor.white
        self.setUpTitleView(title)
        
        self.setUpCancelButton()
        self.addShareButton()
        detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 188)
        detailView.backgroundColor = UIColor.red
        self.addSubview(detailView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ShareView.singleTapPress(_:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        singleTap.delegate = self
        self.addGestureRecognizer(singleTap)
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT - 188, width: SCREENWIDTH, height: 188)
        }, completion: { completion in
            
        })
    }
    
    @objc func singleTapPress(_ sender:UITapGestureRecognizer){
        self.removwSelf()
    }
    
    func removwSelf(){
        UIView.animate(withDuration: AnimationTime, animations: {
            self.detailView.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 188)
        }, completion: { completion in
            self.removeFromSuperview()
        })
    }
    
    func setUpCancelButton(){
        cancelButton =  UIButton(type: .custom)
        cancelButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.removwSelf()
        }
        cancelButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 10, width: 40, height: 40)
        cancelButton.setImage(UIImage.init(named: "Btn_Close"), for: UIControlState())
        detailView.addSubview(cancelButton)
    }
    
    func addShareButton(){
        shareView = UIView.init()
        var maxX:CGFloat = -16
        if WXApi.isWXAppInstalled() {
            wxSession = UIButton(type: .custom)
            wxSession.buttonSetImage(UIImage.init(named: "Wechat_Normal")!, sImage: UIImage.init(named: "Wechat_Pressed")!)
            wxSession.reactive.controlEvents(.touchUpInside).observe({ (action) in
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeChatSession(self.shareModel.title, description: self.shareModel.desc, image: self.ticketImage, url: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWeChatScreenShotImage(self.shareImage, type: 0)
                }
                self.removwSelf()
            })
            wxSession.tag = 100
            wxSession.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                wxSession.layer.add(self.setUpAnimation(wxSession.layer.position.y - 98, velocity: 6.0), forKey: "wxSession")
                shareView.addSubview(wxSession)
            } else {
                shareView.addSubview(wxSession)
                // Fallback on earlier versions
            }
            maxX = wxSession.frame.maxX
            
            wxTimeLine = UIButton(type: .custom)
            wxTimeLine.tag = 101
            wxTimeLine.buttonSetImage(UIImage.init(named: "Moment_Normal")!, sImage: UIImage.init(named: "Moment_Pressed")!)
            wxTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeChatTimeLine(self.shareModel.title, description: self.shareModel.desc, image: self.ticketImage, url: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWeChatScreenShotImage(self.shareImage, type: 1)
                }
                self.removwSelf()
            })
            wxTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                wxTimeLine.layer.add(self.setUpAnimation(wxTimeLine.layer.position.y - 98, velocity: 5.5), forKey: "wxTimeLine")
                shareView.addSubview(wxTimeLine)
            } else {
                shareView.addSubview(wxTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(wxTimeLine)
            maxX = wxTimeLine.frame.maxX
        }
        
        if WeiboSDK.isWeiboAppInstalled() {
            weiboTimeLine = UIButton(type: .custom)
            weiboTimeLine.tag = 102
            weiboTimeLine.buttonSetImage(UIImage.init(named: "Weibo_Normal")!, sImage: UIImage.init(named: "Weibo_Pressed")!)
            weiboTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareWeiboWebUrl(self.shareModel.url, webTitle: self.shareModel.title, image: self.ticketImage, webDescription: self.shareModel.desc, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareWBScreenShotImag(self.shareImage, text: (Bundle.main.infoDictionary! as NSDictionary).object(forKey: "CFBundleDisplayName") as! String)
                }
            })
            weiboTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                weiboTimeLine.layer.add(self.setUpAnimation(weiboTimeLine.layer.position.y - 98, velocity: 5.0), forKey: "weiboTimeLine")
                shareView.addSubview(weiboTimeLine)
            } else {
                shareView.addSubview(weiboTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(weiboTimeLine)
            maxX = weiboTimeLine.frame.maxX
        }
        
        if TencentOAuth.iphoneQQInstalled() {
            qqSeession = UIButton(type: .custom)
            qqSeession.tag = 103
            qqSeession.buttonSetImage(UIImage.init(named: "QQ_Normal")!, sImage: UIImage.init(named: "QQ_Pressed")!)
            shareView.addSubview(qqSeession)
            qqSeession.reactive.controlEvents(.touchUpInside).observe({ (action) in
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareQQSessionWebUrl((Bundle.main.infoDictionary! as NSDictionary).object(forKey: "CFBundleDisplayName") as! String, webTitle: self.shareModel.title,imageUrl: self.shareModel.imageUrl,  webDescription: self.shareModel.desc, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareQQScreenShotImage(self.shareImage, type: 0)
                }
                self.removwSelf()
            })
            qqSeession.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                qqSeession.layer.add(self.setUpAnimation(qqSeession.layer.position.y - 98, velocity: 4.5), forKey: "qqSeession")
                shareView.addSubview(qqSeession)
            } else {
                shareView.addSubview(qqSeession)
            }
            maxX = qqSeession.frame.maxX
        }
        
        if TencentOAuth.iphoneQZoneInstalled() {
            qqTimeLine = UIButton(type: .custom)
            qqTimeLine.tag = 104
            qqTimeLine.buttonSetImage(UIImage.init(named: "QZone_Normal")!, sImage: UIImage.init(named: "QZone_Pressed")!)
            qqTimeLine.frame = CGRect(x: maxX + 16, y: 90, width: 50, height: 50)
            qqTimeLine.reactive.controlEvents(.touchUpInside).observe({ (action) in
                if self.shareImage == nil {
                    ShareTools.shareInstance.shareQQTimeLineUrl((Bundle.main.infoDictionary! as NSDictionary).object(forKey: "CFBundleDisplayName") as! String, webTitle: self.shareModel.title,imageUrl: self.shareModel.imageUrl, webDescription: self.shareModel.desc, webUrl: self.shareUrl)
                }else{
                    ShareTools.shareInstance.shareQQScreenShotImage(self.shareImage, type: 1)
                }
                self.removwSelf()
            })
            qqTimeLine.frame = CGRect(x: maxX + 16, y: 188, width: 50, height: 50)
            if #available(iOS 9.0, *) {
                qqTimeLine.layer.add(self.setUpAnimation(qqTimeLine.layer.position.y - 98, velocity: 4.0), forKey: "qqTimeLine")
                shareView.addSubview(qqTimeLine)
            } else {
                shareView.addSubview(qqTimeLine)
                // Fallback on earlier versions
            }
            shareView.addSubview(qqTimeLine)
            maxX = qqTimeLine.frame.maxX
        }
        
        shareView.frame = CGRect(x: (SCREENWIDTH - maxX)/2, y: 0, width: maxX, height: 188)
        self.detailView.addSubview(shareView)
    }
    
    func setUpTitleView(_ title:String){
        let recommentTitle = UILabel()
        let width = (title as NSString).width(with: App_Theme_PinFan_M_13_Font!, constrainedToHeight: 20)
        recommentTitle.frame = CGRect(x: (SCREENWIDTH - width) / 2, y: 45, width: width, height: 20)
        recommentTitle.textColor = UIColor.init(hexString: App_Theme_A0A0A0_Color)
        recommentTitle.font = App_Theme_PinFan_M_13_Font
        recommentTitle.text = title
        recommentTitle.textAlignment = .center
        detailView.addSubview(recommentTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool{
        let touchPoint = touch.location(in: self)
        return touchPoint.y < SCREENHEIGHT - (self.heightY + 160) ? true : false
    }
    
    @available(iOS 9.0, *)
    func setUpAnimation(_ float:CGFloat,velocity:CGFloat) ->CASpringAnimation{
        let ani = CASpringAnimation.init(keyPath: "position.y")
        ani.mass = 10.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
        ani.stiffness = 1000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
        ani.damping = 100.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        ani.initialVelocity = velocity;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
        ani.duration = ani.settlingDuration;
        ani.toValue = float
        ani.delegate = self
        ani.isRemovedOnCompletion = false
        ani.fillMode = kCAFillModeForwards;
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        return ani
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if self.wxSession != nil {
            if anim == self.wxSession.layer.animation(forKey: "wxSession") {
                var frame = self.wxSession.frame
                frame.origin.y =  90
                self.wxSession.frame = frame
            }
        }
        if self.wxTimeLine != nil {
            if anim == self.wxTimeLine.layer.animation(forKey: "wxTimeLine") {
                var frame = self.wxTimeLine.frame
                frame.origin.y =  90
                self.wxTimeLine.frame = frame
            }
        }
        if self.weiboTimeLine != nil {
            if anim == self.weiboTimeLine.layer.animation(forKey: "weiboTimeLine") {
                var frame = self.weiboTimeLine.frame
                frame.origin.y =  90
                self.weiboTimeLine.frame = frame
            }
        }
        
        if self.qqSeession != nil {
            if anim == self.qqSeession.layer.animation(forKey: "qqSeession") {
                var frame = self.qqSeession.frame
                frame.origin.y =  90
                self.qqSeession.frame = frame
            }
        }
        
        if self.qqTimeLine != nil {
            if anim == self.qqTimeLine.layer.animation(forKey: "qqTimeLine") {
                var frame = self.qqTimeLine.frame
                frame.origin.y =  90
                self.qqTimeLine.frame = frame
            }
        }
    }
}
