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
        UIImageViewManger.sd_imageView(url: model.photo, imageView: avatar, placeholderImage: nil) { (image, error, cacheType, url) in
            
        }
        return avatar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CacheMePlayUserView:UIView {
    
    var playUser:UIView!
    var userName:UILabel!
    var avatar:UIImageView!
    var detail:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpPlayUser()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPlayUser(){
        playUser = UIView.init()
        playUser.isHidden = true
        playUser.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.4)
        playUser.layer.cornerRadius = 28.5
        self.addSubview(playUser)
        
        playUser.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(75)
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
        imageView.image = UIImage.init(named: "背景图")
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
        }
        
        label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: SCREENHEIGHT/2, width: SCREENWIDTH, height: 22)
        label.text = "拼命加载中..."
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
    var backImageView:UIImageView!
    var fontImageView:UIImageView!
    var label:UILabel!
    var blanceLabel:UILabel!
    var toolsViewClouse:ToolsViewClouse!
    
    init(frame: CGRect, title:String, blance:String?, image:UIImage, tag:Int, toolsViewTap:@escaping ToolsViewClouse) {
        super.init(frame: frame)
        
        backImageView = UIImageView.init()
        backImageView.layer.cornerRadius = 30
        backImageView.backgroundColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        backImageView.frame = CGRect.init(x: 0, y: 3, width: frame.size.width, height: frame.size.height)
        self.addSubview(backImageView)
        
        fontImageView = UIImageView.init()
        fontImageView.layer.cornerRadius = 30
        fontImageView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        fontImageView.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(fontImageView)
        
        self.layer.cornerRadius = 30
        
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
            label.textColor = UIColor.init(hexString: App_Theme_333333_Color)

        }else{
            let width = ((blance! as NSString).width(with: App_Theme_PinFan_M_20_Font, constrainedToHeight: 24)) + 22
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - width )/2, y: 9, width: image.size.width, height: image.size.height))
            imageView.image = image
            self.addSubview(imageView)
            
            blanceLabel = UILabel.init(frame: CGRect.init(x: imageView.frame.maxX + 4, y: 9, width: width - 22, height: 20))
            blanceLabel.textAlignment = .center
            blanceLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
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
        toolsDesc =  ToolsView.init(frame: CGRect.init(x: 10, y: 26, width: toolsWidth, height: 60), title: "详情", blance: nil, image: UIImage.init(named: "toy")!, tag: 1) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(1)
                AnimationTools.shareInstance.easeInOutAnimation(view: self.toolsDesc, touchStatus: .begin)
            }
        }
        self.addSubview(toolsDesc)
        
        playGame = ToolsView.init(frame: CGRect.init(x: toolsDesc.frame.maxX + 8, y: 26, width: toolsWidth * 75 / 48, height: 60), title: "开始抓娃娃", blance: "30", image: UIImage.init(named: "coin_1")!,tag:2) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(2)
                AnimationTools.shareInstance.easeInOutAnimation(view: self.playGame, touchStatus: .begin)
            }
        }
        self.addSubview(playGame)
        
        topUp = ToolsView.init(frame: CGRect.init(x: playGame.frame.maxX + 8, y: 26, width: toolsWidth, height: 60), title: "充值", blance: nil, image: UIImage.init(named: "coin_1")!,tag:3) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(3)
                AnimationTools.shareInstance.easeInOutAnimation(view: self.topUp, touchStatus: .begin)
            }
        }
        self.addSubview(topUp)
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

typealias TimeDownClouse = () -> Void

class GameToolsView : UIView {
    var leftBtn:UIButton!
    var rightBtn:UIButton!
    var topBtn:UIButton!
    var bottomBtn:UIButton!
    
    var goBtn:UIButton!
    
    var gameView:UIView!
    
    var gameToolsViewClouse:GameToolsViewClouse!
    
    var countDownLabel:UILabel!
    var timeDownClouse:TimeDownClouse!
    var time:Timer!
    
    init(frame: CGRect,gameToolsViewClouse: @escaping GameToolsViewClouse) {
        super.init(frame: frame)
        
        gameView = UIView.init()
        self.addSubview(gameView)
        
        topBtn = UIButton.init(frame: CGRect.init(x: 53, y: 0, width: gameBtnWidht, height: gameBtnHeight))
        topBtn.setImage(UIImage.init(named: "up"), for: .normal)
        self.setUpButtonTheme(button: topBtn)
        topBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveTop)
        }
        gameView.addSubview(topBtn)
        
        leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 29, width: gameBtnWidht, height: gameBtnWidht))
        leftBtn.setImage(UIImage.init(named: "left"), for: .normal)
        self.setUpButtonTheme(button: leftBtn)
        leftBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveLeft)
        }
        gameView.addSubview(leftBtn)
        
        
        bottomBtn = UIButton.init(frame: CGRect.init(x: 53, y: 57, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: bottomBtn)
        bottomBtn.setImage(UIImage.init(named: "down"), for: .normal)
        bottomBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveDown)
        }
        gameView.addSubview(bottomBtn)
        
        rightBtn = UIButton.init(frame: CGRect.init(x: 105, y: 29, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: rightBtn)
        rightBtn.setImage(UIImage.init(named: "right"), for: .normal)
        rightBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveRight)
        }
        gameView.addSubview(rightBtn)
        
        let image = UIImage.init(named: "go")
        goBtn = UIButton.init(frame: CGRect.init(x: 178, y: 12, width: (image?.size.width)!, height: (image?.size.height)!))
        goBtn.backgroundColor = UIColor.clear
        goBtn.titleLabel?.textAlignment = .center
        goBtn.layer.masksToBounds = true
        goBtn.setImage(image, for: .normal)
        goBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(.moveGO)
        }
        gameView.addSubview(goBtn)
        
        countDownLabel = UILabel.init()
        countDownLabel.isHidden = false
        countDownLabel.backgroundColor = UIColor.clear
        countDownLabel.layer.masksToBounds = true
        countDownLabel.textAlignment = .center
        countDownLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        countDownLabel.font = App_Theme_PinFan_M_28_Font
        gameView.addSubview(countDownLabel)
        countDownLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.goBtn.snp.right).offset(7)
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
        
        gameView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(9)
            make.size.equalTo(CGSize.init(width: goBtn.frame.maxX + 38, height: 100))
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
    }
    
    func setCountLabelText(count:Int){
        var numberCount = count
        var timeDone:Bool = false
        if time == nil {
            time = Timer.every(1, {
                if numberCount == 0 {
                    if self.timeDownClouse != nil && !timeDone {
                        timeDone = true
                        self.timeDownClouse()
                    }
                    self.time = nil
                }else{
                    numberCount = numberCount - 1
                }
                let str = "\(numberCount)s"
                let attributedString = NSMutableAttributedString.init(string: str)
                attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_22_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color)!], range: NSRange.init(location: str.length - 1, length: 1))
                attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color)!], range: NSRange.init(location: 0, length: str.length - 1))
                self.countDownLabel.attributedText = attributedString
            })
        }else{
            
        }
        
    }
    
    func setUpButtonTheme(button:UIButton){
        button.layer.cornerRadius = CGFloat(gameBtnWidht/2)
        button.layer.masksToBounds = true
        button.titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
