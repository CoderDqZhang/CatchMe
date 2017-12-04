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

typealias TopViewBackButtonClouse = () ->Void
class CacheMeTopView : UIView {
    var backButton:UIButton!
    var playUser:UIView!
    var roomsUser:UIView!
    var userName:UILabel!
    var avatar:UIImageView!
    
    var detail:UILabel!
    
    init(frame: CGRect,topViewBackButtonClouse:@escaping TopViewBackButtonClouse) {
        super.init(frame: frame)
        backButton = UIButton.init(type: .custom)
        backButton.isUserInteractionEnabled = true
        backButton.layer.masksToBounds = true
        backButton.titleLabel?.textAlignment = .center
        backButton.setImage(UIImage.init(named: "close_1"), for: .normal)
        backButton.setTitleColor(UIColor.init(hexString: App_Theme_FC4652_Color), for: .normal)
        backButton.frame = CGRect.init(x: SCREENWIDTH - 56, y: 10, width: 46, height: 46)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            topViewBackButtonClouse()
        }
        self.addSubview(backButton)
        
        self.setUpPlayUser()
//        self.setUpRoomsUsers()
    }
    
    func setUpPlayUser(){
        playUser = UIView.init()
        playUser.isHidden = true
        playUser.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.4)
        playUser.layer.cornerRadius = 28.5
        self.addSubview(playUser)
        
        playUser.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(4)
            make.left.equalTo(self.snp.left).offset(-30)
            make.right.equalTo(self.snp.left).offset(162)
            make.height.equalTo(57)
        }
        
        avatar = UIImageView.init()
        avatar.layer.cornerRadius = 22.5
        avatar.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(10)
            make.centerY.equalTo(playUser.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: 45, height: 45))
        }
        
        userName = UILabel.init()
        userName.font = App_Theme_PinFan_M_14_Font
        userName.text = "北京小分子"
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(avatar.snp.right).offset(7)
            make.top.equalTo(playUser.snp.top).offset(12)
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
    }
    
    func setData(model:BasicUserDTO?){
        playUser.isHidden = model == nil ? true : false
        if model == nil {
            detail.text = "空闲中..."
        }else{
            detail.text = "正在抓..."
            userName.text = model?.userName
            UIImageViewManger.sd_imageView(url: model?.photo == nil ? "" : (model?.photo)!, imageView: avatar, placeholderImage: nil) { (image, error, cachtType, url) in
                
            }
        }
    }
    
    func setUpRoomsUsers(){
        roomsUser = UIView.init()
        roomsUser.backgroundColor = UIColor.clear
        self.addSubview(roomsUser)
        
        roomsUser.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(4)
            make.left.equalTo(self.playUser.snp.right).offset(29)
            make.right.equalTo(backButton.snp.left).offset(-15)
            make.height.equalTo(57)
        }
        
        let avatar1 = UIImageView.init()
        avatar1.layer.cornerRadius = 22.5
        avatar1.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        roomsUser.addSubview(avatar1)
        avatar1.snp.makeConstraints { (make) in
            make.right.equalTo(self.roomsUser.snp.right).offset(0)
            make.centerY.equalTo(roomsUser.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: 45, height: 45))
        }
        
        let avatar2 = UIImageView.init()
        avatar2.layer.cornerRadius = 22.5
        avatar2.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        roomsUser.addSubview(avatar2)
        avatar2.snp.makeConstraints { (make) in
            make.right.equalTo(avatar1.snp.centerX).offset(0)
            make.centerY.equalTo(roomsUser.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: 45, height: 45))
        }
        
        let avatar3 = UIImageView.init()
        avatar3.layer.cornerRadius = 22.5
        avatar3.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        roomsUser.addSubview(avatar3)
        avatar3.snp.makeConstraints { (make) in
            make.right.equalTo(avatar2.snp.centerX).offset(0)
            make.centerY.equalTo(roomsUser.snp.centerY).offset(0)
            make.size.equalTo(CGSize.init(width: 45, height: 45))
        }
        
        let userName = UILabel.init()
        userName.font = App_Theme_PinFan_M_20_Font
        userName.text = "21"
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        playUser.addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.right.equalTo(avatar3.snp.left).offset(-2)
            make.centerY.equalTo(roomsUser.snp.centerY).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LocalPreView: UIView {
    
    var label:UILabel!
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.1)
        self.setUpView()
    }
    
    func setUpView(){
        
        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "背景图")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
        }
        
//        let effect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
//        let effectView = UIVisualEffectView.init(effect: effect)
//        effectView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
//        self.addSubview(effectView)
        
        label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: SCREENHEIGHT/2, width: SCREENWIDTH, height: 22)
        label.text = "页面加载中..."
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        label.font = App_Theme_PinFan_M_20_Font
        self.addSubview(label)
        
        
        
    }
    
    func changeLabelText(str:String){
        label.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias ToolsViewClouse = ()->Void

class ToolsView: UIView {
    var imageView:UIImageView!
    var label:UILabel!
    var blanceLabel:UILabel!
    var toolsViewClouse:ToolsViewClouse!
    
    init(frame: CGRect, title:String, blance:String?, image:UIImage, tag:Int, toolsViewTap:@escaping ToolsViewClouse) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        self.layer.cornerRadius = 16
        
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        self.toolsViewClouse = toolsViewTap
        self.addGestureRecognizer(singleTap)
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: frame.size.height - 28, width: frame.size.width, height: 20))
        label.textAlignment = .center
        label.text = title
        label.font = App_Theme_PinFan_M_16_Font
        self.addSubview(label)
        
        if blance == nil {
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - 22 )/2, y: 9, width: image.size.width, height: image.size.height))
            imageView.image = image
            self.addSubview(imageView)
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)

        }else{
            let width = ((blance! as NSString).width(with: App_Theme_PinFan_M_20_Font, constrainedToHeight: 24)) + 22
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - width )/2, y: 9, width: image.size.width, height: image.size.height))
            imageView.image = image
            self.addSubview(imageView)
            
            blanceLabel = UILabel.init(frame: CGRect.init(x: imageView.frame.maxX + 4, y: 9, width: width - 22, height: 20))
            blanceLabel.textAlignment = .center
            blanceLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            blanceLabel.font = App_Theme_PinFan_M_20_Font
            blanceLabel.text = blance!
            self.addSubview(blanceLabel)
            
            label.textColor = UIColor.init(hexString: App_Theme_FF515D_Color)
        }
    }
    
    @objc func singleTap(){
        self.toolsViewClouse()
    }
    
    func changeBalance(str:String){
        self.blanceLabel.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias CacheMeToolsViewClouse = (_ tag:NSInteger) ->Void

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
        toolsDesc =  ToolsView.init(frame: CGRect.init(x: 10, y: 0, width: toolsWidth, height: 60), title: "详情", blance: nil, image: UIImage.init(named: "toy")!, tag: 1) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(1)
            }
        }
        self.addSubview(toolsDesc)
        
        playGame = ToolsView.init(frame: CGRect.init(x: toolsDesc.frame.maxX + 8, y: 0, width: toolsWidth * 75 / 48, height: 60), title: "开始抓娃娃", blance: "30", image: UIImage.init(named: "coin_1")!,tag:2) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(2)
            }
        }
        self.addSubview(playGame)
        
        topUp = ToolsView.init(frame: CGRect.init(x: playGame.frame.maxX + 8, y: 0, width: toolsWidth, height: 60), title: "充值", blance: nil, image: UIImage.init(named: "coin_1")!,tag:3) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(3)
            }
        }
        self.addSubview(topUp)
    }
    
    func setData(str:String){
        playGame.changeBalance(str: str)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias GameToolsViewClouse = (_ tag:GameToolsLogic) ->Void

let gameBtnWidht = 60

enum GameToolsLogic:Int {
    case moveTop = 1
    case moveDown = 2
    case moveLeft = 3
    case moveRight = 4
    case moveGO = 5
}

class GameToolsView : UIView {
    var leftBtn:UIButton!
    var rightBtn:UIButton!
    var topBtn:UIButton!
    var bottomBtn:UIButton!
    
    var goBtn:UIButton!
    
    var gameToolsViewClouse:GameToolsViewClouse!
    
    init(frame: CGRect,gameToolsViewClouse: @escaping GameToolsViewClouse) {
        super.init(frame: frame)
        
        topBtn = UIButton.init(frame: CGRect.init(x: 100, y: 28, width: gameBtnWidht, height: gameBtnWidht))
        topBtn.setImage(UIImage.init(named: "up"), for: .normal)
        self.setUpButtonTheme(button: topBtn)
        topBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveTop)
        }
        self.addSubview(topBtn)
        
        leftBtn = UIButton.init(frame: CGRect.init(x: 30, y: 78, width: gameBtnWidht, height: gameBtnWidht))
        leftBtn.setImage(UIImage.init(named: "left"), for: .normal)
        self.setUpButtonTheme(button: leftBtn)
        leftBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveLeft)
        }
        self.addSubview(leftBtn)
        
        
        bottomBtn = UIButton.init(frame: CGRect.init(x: 100, y: 128, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: bottomBtn)
        bottomBtn.setImage(UIImage.init(named: "down"), for: .normal)
        bottomBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveDown)
        }
        self.addSubview(bottomBtn)
        
        rightBtn = UIButton.init(frame: CGRect.init(x: 170, y: 78, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: rightBtn)
        rightBtn.setImage(UIImage.init(named: "right"), for: .normal)
        rightBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveRight)
        }
        self.addSubview(rightBtn)
        
        goBtn = UIButton.init(frame: CGRect.init(x: SCREENWIDTH - 84 - 30, y: 64, width: 84, height: 88))
        goBtn.backgroundColor = UIColor.clear
        goBtn.titleLabel?.textAlignment = .center
        goBtn.layer.masksToBounds = true
        goBtn.setImage(UIImage.init(named: "go"), for: .normal)
        goBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveGO)
        }
        self.addSubview(goBtn)
    }
    
    func setUpButtonTheme(button:UIButton){
        button.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        button.layer.cornerRadius = CGFloat(gameBtnWidht/2)
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
