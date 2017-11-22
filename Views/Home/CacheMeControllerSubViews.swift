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
    
    init(frame: CGRect,topViewBackButtonClouse:@escaping TopViewBackButtonClouse) {
        super.init(frame: frame)
        backButton = UIButton.init(type: .custom)
        backButton.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        backButton.layer.cornerRadius = 23
        backButton.layer.masksToBounds = true
        backButton.titleLabel?.textAlignment = .center
        backButton.setTitle("X", for: .normal)
        backButton.setTitleColor(UIColor.init(hexString: App_Theme_FC4652_Color), for: .normal)
        backButton.frame = CGRect.init(x: SCREENWIDTH - 50, y: 14, width: 46, height: 46)
        backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            topViewBackButtonClouse()
        }
        self.addSubview(backButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LocalPreView: UIView {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.1)
        self.setUpView()
    }
    
    func setUpView(){
        
        let effect = UIBlurEffect.init(style: UIBlurEffectStyle.dark)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        self.addSubview(effectView)
        
        label = UILabel.init()
        label.frame = CGRect.init(x: 0, y: SCREENHEIGHT/2, width: SCREENWIDTH, height: 22)
        label.text = "页面加载中..."
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: App_Theme_000000_Color)
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
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - 22 )/2, y: 9, width: 26, height: 21))
            imageView.image = image
            self.addSubview(imageView)
            label.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)

        }else{
            let width = ((blance! as NSString).width(with: App_Theme_PinFan_M_20_Font, constrainedToHeight: 24)) + 22
            imageView = UIImageView.init(frame: CGRect.init(x: (frame.size.width  - width )/2, y: 9, width: 26, height: 21))
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
        toolsDesc =  ToolsView.init(frame: CGRect.init(x: 10, y: 0, width: toolsWidth, height: 60), title: "详情", blance: nil, image: UIImage.init(named: "toys")!, tag: 1) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(1)
            }
        }
        self.addSubview(toolsDesc)
        
        playGame = ToolsView.init(frame: CGRect.init(x: toolsDesc.frame.maxX + 8, y: 0, width: toolsWidth * 75 / 48, height: 60), title: "开始抓娃娃", blance: "30", image: UIImage.init(named: "recharge")!,tag:2) {
            if self.cacheMeToolsViewClouse != nil {
                self.cacheMeToolsViewClouse(2)
            }
        }
        self.addSubview(playGame)
        
        topUp = ToolsView.init(frame: CGRect.init(x: playGame.frame.maxX + 8, y: 0, width: toolsWidth, height: 60), title: "充值", blance: nil, image: UIImage.init(named: "recharge")!,tag:3) {
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

typealias GameToolsViewClouse = (_ tag:Int) ->Void

let gameBtnWidht = 60

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
        topBtn.setTitle("上边", for: .normal)
        self.setUpButtonTheme(button: topBtn)
        topBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(2)
        }
        self.addSubview(topBtn)
        
        leftBtn = UIButton.init(frame: CGRect.init(x: 30, y: 78, width: gameBtnWidht, height: gameBtnWidht))
        leftBtn.setTitle("左边", for: .normal)
        self.setUpButtonTheme(button: leftBtn)
        leftBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(1)
        }
        self.addSubview(leftBtn)
        
        
        bottomBtn = UIButton.init(frame: CGRect.init(x: 100, y: 128, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: bottomBtn)
        bottomBtn.setTitle("下边", for: .normal)
        bottomBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(3)
        }
        self.addSubview(bottomBtn)
        
        rightBtn = UIButton.init(frame: CGRect.init(x: 170, y: 78, width: gameBtnWidht, height: gameBtnWidht))
        self.setUpButtonTheme(button: rightBtn)
        rightBtn.setTitle("右边", for: .normal)
        rightBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(4)
        }
        self.addSubview(rightBtn)
        
        goBtn = UIButton.init(frame: CGRect.init(x: SCREENWIDTH - 96 - 20, y: 76, width: 96, height: 60))
        goBtn.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.3)
        goBtn.titleLabel?.textAlignment = .center
        goBtn.layer.cornerRadius = 16
        goBtn.layer.masksToBounds = true
        goBtn.setTitle("抓取", for: .normal)
        goBtn.reactive.controlEvents(.touchUpInside).observe { (action) in
            gameToolsViewClouse(5)
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
