//
//  CacheMeControllerSubViews.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class CacheMeControllerSubViews: NSObject {

}

typealias NELivePlayerLoadFailViewClouse = () ->Void

class NELivePlayerLoadFailView : UIView {
    var imageView:UIImageView!
    var backImage:UIImageView!
    
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var button:CustomTouchButton!
    
    var centerView:UIView!
    
    var nELivePlayerLoadFailViewClouse:NELivePlayerLoadFailViewClouse!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        
        backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "bg_loading_1")
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        
        centerView = UIView.init()
        self.addSubview(centerView)
        
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "pic_waiting")
        centerView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.centerView.snp.top).offset(0)
            make.centerX.equalTo(self.centerView.snp.centerX).offset(0)
        }
        
        titleLabel = UILabel.init()
        titleLabel.text = "网络略慢, 主人请耐心等待"
        titleLabel.font = App_Theme_PinFan_M_18_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.4)
        centerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(0)
            make.centerX.equalTo(self.centerView.snp.centerX).offset(0)
        }
        
        detailLabel = UILabel.init()
        detailLabel.text = "小秘密:有时候重新连接会很快呦"
        detailLabel.font = App_Theme_PinFan_M_15_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        centerView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(3)
            make.centerX.equalTo(self.centerView.snp.centerX).offset(0)
        }
        
        button = CustomTouchButton.init(frame: CGRect.init(x: (SCREENWIDTH - 150)/2, y: 210, width: 150, height: 44), title: "重新连接", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder) { (tag) in
            if self.nELivePlayerLoadFailViewClouse != nil {
                self.nELivePlayerLoadFailViewClouse()
            }
        }
        centerView.addSubview(button)
        
        centerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 258))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias TopViewBackButtonClouse = () ->Void
class CacheMeTopView : UIView {
    var backButton:UIButton!
    var roomsUser:UIView!
    var detail:UILabel!
    var userName :UILabel!
    init(frame: CGRect,topViewBackButtonClouse:@escaping TopViewBackButtonClouse) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        backButton = UIButton.init(type: .custom)
        backButton.isUserInteractionEnabled = true
        backButton.setImage(UIImage.init(named: "back_bar"), for: .normal)
        backButton.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            topViewBackButtonClouse()
        }
        self.addSubview(backButton)
        
        self.setUpRoomsUsers()
    }
    
    func setUpRoomsUsers(){
        roomsUser = UIView.init()
        roomsUser.frame = CGRect.init(x: 44, y: 0, width: SCREENWIDTH - 44 - 18, height: 44)
        self.addSubview(roomsUser)

    }
    
    func setUpData(models:NSMutableArray, count:String){
        self.roomsUser.removeSubviews()
        var maxX = SCREENWIDTH - 44 - 18 - 32
        for i in 0...models.count - 1{
            let frame = CGRect.init(x: maxX, y: 6, width: 32, height: 32)
            let avatar = self.createImageWithModle(frame: frame, model:  SwiftUserModel.init(fromDictionary: models[i] as! NSDictionary))
            roomsUser.addSubview(avatar)
            maxX = maxX - 35
            if i == models.count - 1 {
                userName = UILabel.init()
                userName.font = App_Theme_PinFan_M_20_Font
                self.changeNumberUser(str: "\(count)")
                userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
                roomsUser.addSubview(userName)
                userName.snp.makeConstraints { (make) in
                    make.right.equalTo(avatar.snp.left).offset(-5)
                    make.centerY.equalTo(roomsUser.snp.centerY).offset(0)
                }
            }
        }
        self.updateConstraintsIfNeeded()
    }
    
    func changeNumberUser(str:String){
        let numberText = "\(str)人在房间"
        let attributedString = NSMutableAttributedString.init(string: numberText)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color)!], range: NSRange.init(location: numberText.length - 4, length: 4))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_16_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color)!], range: NSRange.init(location: 0, length: numberText.length - 4))
        userName.attributedText = attributedString
    }
    
    func createImageWithModle(frame:CGRect,model:SwiftUserModel) -> UIImageView{
        let avatar = UIImageView.init()
        avatar.frame = frame
        avatar.layer.cornerRadius = 16
        avatar.layer.masksToBounds = true
        UIImageViewManger.sd_imageView(url: model.photo == nil ? "" : model.photo, imageView: avatar, placeholderImage: UIImage.init(named: "默认头像_2")) { (image, error, cacheType, url) in
            
        }
        return avatar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias TimeDownClouse = () -> Void

class CacheMePlayUserView:UIView {
    
    var backImage:UIImageView!
    var playUser:UIView!
    var userName:UILabel!
    var userName_bg:UILabel!
    var detail_bg:UILabel!
    var avatar:UIImageView!
    var detail:UILabel!
    
    var countDownLabel:UILabel!
    var timeDownClouse:TimeDownClouse!
    var time:Timer!
    
    var numberCount:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpPlayUser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if self.time != nil {
            self.time.invalidate()
        }
    }
    
    func setUpPlayUser(){
        
        playUser = UIView.init()
        playUser.isHidden = true
        playUser.backgroundColor = UIColor.clear
        playUser.layer.cornerRadius = 28.5
        self.addSubview(playUser)
        playUser.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }

        backImage = UIImageView.init()
        backImage.image = UIImage.init(named: "play_user")
        playUser.addSubview(backImage)
        
        backImage.snp.makeConstraints { (make) in
            make.top.equalTo(playUser.snp.top).offset(0)
            make.bottom.equalTo(playUser.snp.bottom).offset(0)
            make.left.equalTo(playUser.snp.left).offset(0)
        }
        
        avatar = UIImageView.init()
        avatar.layer.cornerRadius = 21
        avatar.layer.masksToBounds = true
        avatar.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(self.playUser.snp.left).offset(5)
            make.centerY.equalTo(playUser.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: 42, height: 42))
        }
        
        userName_bg = UILabel.init()
        userName_bg.font = App_Theme_PinFan_M_14_Font
        userName_bg.text = "北京小分子"
        userName_bg.lineBreakMode = .byTruncatingTail
        userName_bg.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        playUser.addSubview(userName_bg)
        userName_bg.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(7)
            make.top.equalTo(playUser.snp.top).offset(9)
            make.width.equalTo(70)
        }
        
        userName = UILabel.init()
        userName.font = App_Theme_PinFan_M_14_Font
        userName.text = "北京小分子"
        userName.lineBreakMode = .byTruncatingTail
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(7)
            make.top.equalTo(playUser.snp.top).offset(8)
            make.width.equalTo(70)
        }
        
        detail_bg = UILabel.init()
        detail_bg.text = "正在抓..."
        detail_bg.font = App_Theme_PinFan_M_14_Font
        detail_bg.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        playUser.addSubview(detail_bg)
        
        detail_bg.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(7)
            make.top.equalTo(userName.snp.bottom).offset(2)
            make.right.equalTo(playUser.snp.right).offset(-7)
        }
        
        detail = UILabel.init()
        detail.text = "正在抓..."
        detail.font = App_Theme_PinFan_M_14_Font
        detail.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(detail)
        
        detail.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(7)
            make.top.equalTo(userName.snp.bottom).offset(1)
            make.right.equalTo(playUser.snp.right).offset(-7)
        }
        
        
        countDownLabel = UILabel.init()
        countDownLabel.isHidden = false
        countDownLabel.backgroundColor = UIColor.clear
        countDownLabel.layer.masksToBounds = true
        countDownLabel.textAlignment = .center
        countDownLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        countDownLabel.font = App_Theme_PinFan_M_28_Font
        self.addSubview(countDownLabel)
        countDownLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-9)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
    }
    
    func setData(model:BasicUserDTO?){
        playUser.isHidden = model == nil ? true : false
        if model == nil {
            detail.text = "空闲中..."
        }else{
            detail.text = "正在抓..."
            userName.text = model?.userName
            detail_bg.text = "正在抓..."
            userName_bg.text = model?.userName
            UIImageViewManger.sd_imageView(url: model?.photo == nil ? "" : (model?.photo)!, imageView: avatar, placeholderImage: UIImage.init(named: "默认头像_2")) { (image, error, cachtType, url) in
                
            }
        }
    }
    
    func setStr(str:String) {
        let attributedString = NSMutableAttributedString.init(string: str)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_22_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: str.length - 1, length: 1))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: 0, length: str.length - 1))
        self.countDownLabel.attributedText = attributedString
    }
    
    func setCountLabelText(count:Int){
        numberCount = count
        if time == nil {
            time = Timer.every(1, {
                if self.numberCount == 0 {
                    if self.timeDownClouse != nil {
                        self.timeDownClouse()
                    }
                }
                self.numberCount = self.numberCount - 1
                if self.numberCount <= -1 {
                    self.setStr(str: "0s")
                    return
                }
                self.setStr(str: "\(self.numberCount)s")
                
            })
        }
    }
}

class LocalPreView: UIView {
    
    var label:UILabel!
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.1)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.setUpView()
    }
    
    func setUpView(){
        
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "bg_loading")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
        }
        
        label = UILabel.init()
        label.frame = CGRect.init()
        label.text = "拼命加载中..."
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.4)
        label.font = App_Theme_PinFan_M_18_Font
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY).offset(58)
        }
        
    }
    
    func changeLabelText(str:String){
        label.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class QuictEnterLocalPreView: UIView {
    
    var label:UILabel!
    var backGroundImage:UIImageView!
    var imageView:UIImageView!
    var backButton:UIButton!
    
    init(frame: CGRect,image:UIImage) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.tag = 10000
        self.layer.masksToBounds = true
        self.setUpView(image:image)
    }
    
    func setUpView(image:UIImage){
        
        backGroundImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        backGroundImage.alpha = 0.1
        backGroundImage.image = image
        backGroundImage.blur(withStyle: .extraLight)
        self.addSubview(backGroundImage)
        
        imageView = UIImageView.init()
        let image = UIImage.init(named: "pic_animation")
        imageView.image = image
        imageView.alpha = 1
        self.addSubview(imageView)
        self.imageView.frame = CGRect.init(x: (SCREENWIDTH - (image?.size.width)!)/2, y: SCREENHEIGHT, width: (image?.size.width)!, height: (image?.size.height)!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backGroundImage.alpha = 1
        }) { (ret) in
            
        }
//        UIView.animate(withDuration: 0.3, animations: {
//            self.imageView.frame = CGRect.init(x: (SCREENWIDTH - (image?.size.width)!)/2, y: SCREENHEIGHT - (image?.size.height)!, width: (image?.size.width)!, height: (image?.size.height)!)
//        }) { (ret) in
//
//        }
        imageView.layer.add(self.setUpAnimation(SCREENHEIGHT - (image?.size.height)! / 2 + 7, velocity: 60.0, finish: { _ in
        }), forKey: "imageViewAnimation")
        
        label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: SCREENHEIGHT/2, width: SCREENWIDTH, height: 22)
        label.text = "随机选取房间中..."
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        label.font = App_Theme_PinFan_M_20_Font
        self.addSubview(label)
        
        _ = Timer.after(3, {
            self.removeSelf()
        })
        
        backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "back_bar_black"), for: .normal)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.removeSelf()
        }
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(self.snp.left).offset(6)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func setUpAnimation(_ float:CGFloat, velocity:CGFloat, finish:@escaping AnimationFinishClouse) ->CASpringAnimation{
        let ani = CASpringAnimation.init(keyPath: "position.y")
        ani.mass = 1.0; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
        ani.stiffness = 1000; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
        ani.damping = 80.0;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        ani.initialVelocity = velocity;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
        ani.duration = ani.settlingDuration;
        ani.toValue = float
        ani.isRemovedOnCompletion = false
        ani.fillMode = kCAFillModeForwards;
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        _ = Timer.after(ani.settlingDuration, {
            finish(true)
        })
        return ani
    }
    
    func removeSelf(){
        UIView.animate(withDuration: 0.3, animations: {
            self.backGroundImage.alpha = 1
        }) { (ret) in
            self.removeFromSuperview()
        }
    }
    
    func changeLabelText(str:String){
        label.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias ToolsViewClouse = ()->Void

class ToolsView: AnimationTouchView {
    
    var imageView:UIImageView!
    var backImageView:UIImageView!
    var fontImageView:UIImageView!
    var label:UILabel!
    var blanceLabel:UILabel!
    var toolsViewClouse:ToolsViewClouse!
    
    init(frame: CGRect, title:String, blance:String?, image:UIImage, tag:Int, toolsViewTap:@escaping ToolsViewClouse) {
        super.init(frame: frame) {
            toolsViewTap()
        }
        
        backImageView = UIImageView.init()
        backImageView.layer.cornerRadius = 30
        backImageView.backgroundColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        backImageView.frame = CGRect.init(x: 0, y: 4, width: frame.size.width, height: frame.size.height)
        self.addSubview(backImageView)
        
        fontImageView = UIImageView.init()
        fontImageView.layer.cornerRadius = 30
        fontImageView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        fontImageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(fontImageView)
        
        self.layer.cornerRadius = 30
        
//        self.toolsViewClouse = toolsViewTap
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height - 28, width: frame.size.width, height: 20))
        label.textAlignment = .center
        label.text = title
        label.font = App_Theme_PinFan_M_16_Font
        self.addSubview(label)
        
        if blance == nil {
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - 22 )/2, y: 9, width: image.size.width, height: image.size.height))
            imageView.image = image
            self.addSubview(imageView)
            label.textColor = UIColor.init(hexString: App_Theme_333333_Color)

        }else{
            let width = ((blance! as NSString).width(with: App_Theme_PinFan_M_20_Font, constrainedToHeight: 24))
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - width - image.size.width + 2)/2, y: 9, width: image.size.width, height: image.size.height))
            imageView.image = image
            self.addSubview(imageView)
            
            blanceLabel = UILabel.init(frame: CGRect.init(x: imageView.frame.maxX + 2, y: 9, width: width + 2, height: 20))
            blanceLabel.textAlignment = .center
            blanceLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            blanceLabel.font = App_Theme_PinFan_M_20_Font
            blanceLabel.text = blance!
            self.addSubview(blanceLabel)
            
            label.textColor = UIColor.init(hexString: App_Theme_FF515D_Color)
            self.updateConstraintsIfNeeded()
        }
    }
    
    @objc func singleTap(){
        
        
    }
    
    func changeBalance(str:String){
        self.blanceLabel.text = str
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias CacheMeToolsViewClouse = (_ tag:NSInteger) ->Void

enum PlayType {
    case canPlay
    case canNotPlay
}
class CacheMeToolsView: UIView {
    var toolsDesc:ToolsView!
    var playGame:ToolsView!
    var topUp:ToolsView!
    
    var cacheMeToolsViewClouse:CacheMeToolsViewClouse!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    //(2x + 75/48x)
    func setUpView(){
        let toolsWidth = (SCREENWIDTH - 36) / (2 + 75/47.5)
        toolsDesc =  ToolsView.init(frame: CGRect.init(x: 10, y: 25, width: toolsWidth, height: 60), title: "详情", blance: nil, image: UIImage.init(named: "toy")!, tag: 1) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(1)
            }
        }
        self.addSubview(toolsDesc)
        
        playGame = ToolsView.init(frame: CGRect.init(x: toolsDesc.frame.maxX + 8, y: 25, width: toolsWidth * 75 / 48, height: 60), title: "开始抓娃娃", blance: "30", image: UIImage.init(named: "coin_1")!,tag:2) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(2)
            }
        }
        self.addSubview(playGame)
        
        topUp = ToolsView.init(frame: CGRect.init(x: playGame.frame.maxX + 8, y: 25, width: toolsWidth, height: 60), title: "充值", blance: nil, image: UIImage.init(named: "coin_1")!,tag:3) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(3)
            }
        }
        self.addSubview(topUp)
    }
    
    func changePlayType(type:PlayType){
        if type == .canNotPlay {
            playGame.isUserInteractionEnabled = false
            playGame.blanceLabel.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
            playGame.imageView.image = UIImage.init(named: "coin_np")
            playGame.label.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        }else{
            playGame.isUserInteractionEnabled = true
            playGame.blanceLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            playGame.imageView.image = UIImage.init(named: "coin_1")
            playGame.label.textColor = UIColor.init(hexString: App_Theme_FF515D_Color)
        }
    }
    
    func changePlayGameCoins(str:String){
        playGame.blanceLabel.text = str
    }
    
    func setData(str:String){
        playGame.changeBalance(str: str)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        AnimationTools.shareInstance.easeInOutAnimation(view: self.toolsDesc, touchStatus: .begin)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        AnimationTools.shareInstance.easeInOutAnimation(view: self.toolsDesc, touchStatus: .end)
//    }
//
//    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
//
//    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
}

typealias GameToolsViewClouse = (_ tag:GameToolsLogic) ->Void

let gameBtnWidht:CGFloat = (UIImage.init(named: "up")?.size.width)!
let gameBtnHeight:CGFloat = (UIImage.init(named: "up")?.size.height)!

enum GameToolsLogic:Int {
    case moveTop = 1
    case moveDown = 2
    case moveLeft = 3
    case moveRight = 4
    case moveGO = 5
}

enum GameToolsViewPlayType {
    case isWaitGameStatus
    case isPlaying
}

let LeftMergern:CGFloat = IPHONE5 ? 30 : 0

class GameToolsView : UIView {
    var leftBtn:AnimationButton!
    var rightBtn:AnimationButton!
    var topBtn:AnimationButton!
    var bottomBtn:AnimationButton!
    
    var goBtn:AnimationButton!
    
    var gameView:UIView!
    
    var gameToolsViewClouse:GameToolsViewClouse!
    
    
    
    init(frame: CGRect,gameToolsViewClouse: @escaping GameToolsViewClouse) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        gameView = UIView.init()
        
        self.addSubview(gameView)
        
        topBtn = AnimationButton.init(frame: CGRect.init(x: 108 - LeftMergern, y: 0, width: gameBtnWidht, height: gameBtnHeight))
        topBtn.setImage(UIImage.init(named: "up"), for: .normal)
        topBtn.setImage(UIImage.init(named: "up"), for: .highlighted)

        self.setUpButtonTheme(button: topBtn)
        topBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveTop)
        }
        gameView.addSubview(topBtn)
        
        leftBtn = AnimationButton.init(frame: CGRect.init(x: 55 - LeftMergern, y: 29, width: gameBtnWidht, height: gameBtnHeight))
        leftBtn.setImage(UIImage.init(named: "left"), for: .normal)
        leftBtn.setImage(UIImage.init(named: "left"), for: .highlighted)
        self.setUpButtonTheme(button: leftBtn)
        leftBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveLeft)
        }
        gameView.addSubview(leftBtn)
        
        
        bottomBtn = AnimationButton.init(frame: CGRect.init(x: 108 - LeftMergern, y: 57, width: gameBtnWidht, height: gameBtnHeight))
        self.setUpButtonTheme(button: bottomBtn)
        bottomBtn.setImage(UIImage.init(named: "down"), for: .normal)
        bottomBtn.setImage(UIImage.init(named: "down"), for: .highlighted)
        bottomBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveDown)
        }
        gameView.addSubview(bottomBtn)
        
        rightBtn = AnimationButton.init(frame: CGRect.init(x: 161 - LeftMergern, y: 29, width: gameBtnWidht, height: gameBtnHeight))
        self.setUpButtonTheme(button: rightBtn)
        rightBtn.setImage(UIImage.init(named: "right"), for: .normal)
        rightBtn.setImage(UIImage.init(named: "right"), for: .highlighted)
        rightBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveRight)
        }
        gameView.addSubview(rightBtn)
        
        let image = UIImage.init(named: "go")
        goBtn = AnimationButton.init(frame: CGRect.init(x: SCREENWIDTH - 55 - (image?.size.width)! + LeftMergern, y: 10, width: (image?.size.width)!, height: (image?.size.height)!))
        goBtn.backgroundColor = UIColor.clear
        goBtn.titleLabel?.textAlignment = .center
        goBtn.layer.masksToBounds = true
        goBtn.setImage(image, for: .normal)
        goBtn.setImage(image, for: .highlighted)
        goBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveGO)
        }
        gameView.addSubview(goBtn)
        
        gameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        leftBtn.setImage(UIImage.init(named: "left_np"), for: .disabled)
        bottomBtn.setImage(UIImage.init(named: "down_np"), for: .disabled)
        topBtn.setImage(UIImage.init(named: "up_np"), for: .disabled)
        goBtn.setImage(UIImage.init(named: "go_np"), for: .disabled)
        rightBtn.setImage(UIImage.init(named: "right_np"), for: .disabled)
        
    }
    
    
    
    func setGameToolsType(type:GameToolsViewPlayType) {
        if type == .isPlaying {
            leftBtn.isEnabled = true
            rightBtn.isEnabled = true
            topBtn.isEnabled = true
            bottomBtn.isEnabled = true
            goBtn.isEnabled = true
        }else{
            leftBtn.isEnabled = false
            rightBtn.isEnabled = false
            topBtn.isEnabled = false
            bottomBtn.isEnabled = false
            goBtn.isEnabled = false
            
        }
    }
    
    func setUpButtonTheme(button:AnimationButton){
        button.layer.cornerRadius = CGFloat(gameBtnWidht/2)
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameTipView : UIView {
    var tipImage:UIImageView!
    var tipLabel:UILabel!
    var tipLabelBg:UIImageView!
    
    init(frame: CGRect, tipStr:String) {
        super.init(frame: frame)
        
        tipLabelBg = UIImageView.init()
        tipLabelBg.image = UIImage.init(color: UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.6), size: CGSize.init(width: 311, height: 54))
        tipLabelBg.layer.cornerRadius = 5
        tipLabelBg.layer.masksToBounds = true
        self.addSubview(tipLabelBg)
        tipLabelBg.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(13)
            make.top.equalTo(self.snp.top).offset(33)
            make.right.equalTo(self.snp.right).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        
        tipImage = UIImageView.init()
        tipImage.image = UIImage.init(named: "pic_info")
        self.addSubview(tipImage)
        
        tipImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
        }
        
        tipLabel = UILabel.init()
        tipLabel.text = tipStr
        tipLabel.textAlignment = .center
        tipLabel.font = App_Theme_PinFan_M_17_Font
        tipLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(57)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-16)
        }
        _ = Timer.after(5, {
            self.tipLabel.text = TipString1
        })
        
        _ = Timer.after(10, {
            self.removeFromSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
