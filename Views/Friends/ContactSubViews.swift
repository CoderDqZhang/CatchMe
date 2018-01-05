//
//  ContactSubViews.swift
//  CatchMe
//
//  Created by Zhang on 04/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class ContactSubViews: UIView {

}

class CoinView: AnimationTouchView {

    var coinLabel:UILabel!
    
    init(frame: CGRect, title:String,click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        
        let backImageView = UIImageView.init()
        backImageView.image = UIImage.init(named: "充值背景")
        self.addSubview(backImageView)
        
        backImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        
        coinLabel = UILabel.init()
        coinLabel.text = title
        coinLabel.font = App_Theme_PinFan_M_16_Font
        coinLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(coinLabel)
        coinLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.left.equalTo(self.snp.left).offset(30)
        }
        
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "coin")
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(6)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTitle(str:String) {
        coinLabel.text = str
    }
}

class ContactUserInfoView: UIView, SDCycleScrollViewDelegate {
    var descLabel:UILabel!
    var pageControl:UIPageControl!
    var cycleScrollView:SDCycleScrollView!
    var userInfoView:UserInfoView!
    var conectStatus:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView(model:UserInfoModel.shareInstance())
    }
    
    func setUpView(model:UserInfoModel){
        descLabel = UILabel.init()
        descLabel.text = "TA有其他照片滑动看看"
        descLabel.font = App_Theme_PinFan_R_14_Font
        descLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.5)
        self.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
        }
        
        pageControl = UIPageControl.init()
        pageControl.numberOfPages = 4
        pageControl.setNormalControl(image: UIImage.init(named: "circle_2-1"), size: CGSize.init(width: 8, height: 8))
        pageControl.setCurrentControl(image: UIImage.init(named: "circle_1-1"), size: CGSize.init(width: 10, height: 10))
        pageControl.currentPage = 0
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(descLabel.snp.bottom).offset(12)
        }
        
        if cycleScrollView == nil {
            cycleScrollView = SDCycleScrollView(frame: CGRect.zero, delegate: self, placeholderImage: nil)
            cycleScrollView.imageURLStringsGroup = ["http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg","http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1f01hkxyjhej20u00jzacj.jpg"]
            cycleScrollView.pageDotImage = UIImage.init(named: "circle_2-1")
            cycleScrollView.currentPageDotImage = UIImage.init(named: "circle_1-1")
            cycleScrollView.currentPageDotColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            cycleScrollView.pageControlDotSize = CGSize(width: 12, height: 12)
            cycleScrollView.showPageControl = false
            self.addSubview(cycleScrollView)
            //         --- 轮播时间间隔，默认1.0秒，可自定义
            cycleScrollView.autoScroll = true
            cycleScrollView.snp.makeConstraints({ (make) in
                make.top.equalTo(pageControl.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize.init(width: 180, height: 190))
            })
        }
        
        userInfoView = UserInfoView.init(frame:CGRect.zero)
        self.addSubview(userInfoView)
        userInfoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(cycleScrollView.snp.bottom).offset(0)
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 180, height: 47))
        }
        
        
        conectStatus = UILabel.init()
        conectStatus.text = "我是一只小鸟邀请你语音聊天"
        conectStatus.font = App_Theme_PinFan_M_16_Font
        conectStatus.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.5)
        self.addSubview(conectStatus)
        conectStatus.snp.makeConstraints { (make) in
            make.top.equalTo(cycleScrollView.snp.bottom).offset(21)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        if pageControl != nil {
            pageControl.currentPage = index
            pageControl.updateCurrentPageDisplay()
            pageControl.setNormalControl(image: UIImage.init(named: "circle_2-1"), size: CGSize.init(width: 8, height: 8))
            pageControl.setCurrentControl(image: UIImage.init(named: "circle_1-1"), size: CGSize.init(width: 10, height: 10))
        }
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContactBottomButton:AnimationTouchView {
    var titleLabel:UILabel!
    var imageView:UIImageView!
    
    init(frame:CGRect, title:String,image:UIImage, click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        
        self.backgroundColor = UIColor.brown
        
        imageView = UIImageView.init()
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(0)
            make.centerX.equalToSuperview()
        }
        
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_R_16_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ContactWailActionType {
    case waitingOtherAccpet
    case responseOtherConnact
    case conneactSuccessMe
    case conneactSuccessOther
    case myCollectViewShow
    case otherCollectViewShow
}

class ContactBottomView: UIView {
    
    var handUpButton:ContactBottomButton!
    var accpetButton:ContactBottomButton!
    var closeCamerButton:ContactBottomButton!
    var userCollectButton:ContactBottomButton!
    var time:Timer!
    var timeLabel:UILabel!
    
    var type:ContactWailActionType!
    
    var contactLocalViewClouse:ContactLocalViewClouse!
    
    init(frame: CGRect,type:ContactWailActionType, click: @escaping ContactLocalViewClouse) {
        super.init(frame: frame)
        self.type = type
        self.contactLocalViewClouse = click
        self.setUpView(type:type)
    }
    
    func setUpView(type:ContactWailActionType){
        handUpButton = ContactBottomButton.init(frame: CGRect.zero, title: "挂断", image: UIImage.init(named: "挂断")!, click: {
            self.contactLocalViewClouse(.handUp)
        })
        self.addSubview(handUpButton)
        if type != .responseOtherConnact {
            handUpButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.top.equalTo(self.snp.top).offset(48)
                make.size.equalTo(CGSize.init(width: 80, height: 100))
            }
        }else{
            handUpButton.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(28)
                make.top.equalTo(self.snp.top).offset(48)
                make.size.equalTo(CGSize.init(width: 80, height: 100))
            }
        }
        
        
        if type == .responseOtherConnact {
            accpetButton = ContactBottomButton.init(frame: CGRect.zero, title: "接听", image: UIImage.init(named: "接听")!, click: {
                self.contactLocalViewClouse(.accpetVideo)
            })
            self.addSubview(accpetButton)
            accpetButton.snp.makeConstraints { (make) in
                make.right.equalTo(self.snp.right).offset(-28)
                make.top.equalTo(self.snp.top).offset(48)
                make.size.equalTo(CGSize.init(width: 80, height: 100))
            }
        }else{
            if accpetButton != nil {
                accpetButton.isHidden = true
            }
        }

        closeCamerButton = ContactBottomButton.init(frame: CGRect.zero, title: "关闭摄像头", image: UIImage.init(named: "关闭摄像头")!, click: {
            self.contactLocalViewClouse(.closeCamera)
        })
        self.addSubview(closeCamerButton)
        closeCamerButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(28)
            make.top.equalTo(self.snp.top).offset(48)
            make.size.equalTo(CGSize.init(width: 80, height: 100))
        }
        if type == .conneactSuccessMe || type == .conneactSuccessOther {
            closeCamerButton.isHidden = false
        }else{
            closeCamerButton.isHidden = true
        }
        
        
        userCollectButton = ContactBottomButton.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 120), title: "我的心愿单", image: UIImage.init(named: "我的心愿单")!, click: {
            self.contactLocalViewClouse(.showCollect)
        })
        self.addSubview(userCollectButton)
        userCollectButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-28)
            make.top.equalTo(self.snp.top).offset(48)
            make.size.equalTo(CGSize.init(width: 80, height: 100))
        }
        if type == .conneactSuccessMe || type == .conneactSuccessOther {
            userCollectButton.isHidden = false
        }else{
            userCollectButton.isHidden = true
        }
        
    }
    
    func changeContactBottomView(type:ContactWailActionType) {
        switch type {
        case .conneactSuccessMe:
            break;
        case .conneactSuccessOther:
            break;
        default:
            break;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ContactBottomViewButtomType {
    case handUp
    case closeCamera
    case showCollect
    case accpetVideo
    case coinLabel
}

typealias ContactLocalViewClouse = (_ type:ContactBottomViewButtomType) ->Void

class ContactLocalView: UIView {
    var coinView:CoinView!
    var contactUserInfoView:ContactUserInfoView!
    var bottomView:ContactBottomView!
    var backgroundView:UIImage!
    var contactLocalViewClouse:ContactLocalViewClouse!
    
    init(frame: CGRect, type:ContactWailActionType, click: @escaping ContactLocalViewClouse) {
        self.contactLocalViewClouse = click
        super.init(frame: frame)
        self.setUpView(type:type)
        self.backgroundColor = UIColor.brown
    }
    
    func setUpView(type:ContactWailActionType){
        coinView = CoinView.init(frame: CGRect.zero, title: "500", click: {
            self.contactLocalViewClouse(.coinLabel)
        })
        
        self.addSubview(coinView)
        coinView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20)
            make.top.equalTo(self.snp.top).offset(32)
        }
        
        contactUserInfoView = ContactUserInfoView.init(frame: CGRect.zero)
        contactUserInfoView.backgroundColor = UIColor.blue
        self.addSubview(contactUserInfoView)
        contactUserInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset((SCREENHEIGHT - 320)/4)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.height.equalTo(320)
        }
        self.changeContactWailActionType(type: type)
        
        bottomView = ContactBottomView.init(frame: CGRect.zero, type: type, click: { (click) in
            self.contactLocalViewClouse(click)
        })
        bottomView.backgroundColor = UIColor.red
        self.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.height.equalTo(173)
        }
    }
    
    func changeContactWailActionType(type:ContactWailActionType) {
        if type == .waitingOtherAccpet || type == .responseOtherConnact {
            if contactUserInfoView != nil {
                contactUserInfoView.isHidden = false
            }
        }else{
            if contactUserInfoView != nil {
                contactUserInfoView.isHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
