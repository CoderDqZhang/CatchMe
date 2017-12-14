
//
//  SpalshView.swift
//  LiangPiao
//
//  Created by Zhang on 22/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SpalshView: UIView {

    var spalshView:FLAnimatedImageView!
    var time:Timer!
    var titleLabel:UIImageView!
    var appName:UIImageView!
    var descLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FC4F5E_Color)
        self.setGIfImage()
        self.setUpView()
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        titleLabel = UIImageView.init()
        titleLabel.image = UIImage.init(named: "text")
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.spalshView.snp.bottom).offset(11)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        appName = UIImageView.init()
        appName.image = UIImage.init(named: "logo_text")
        self.addSubview(appName)
        
        appName.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-48)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        descLabel = UILabel.init()
        descLabel.text = "Copyright © 2017 All Rights Reserved"
        descLabel.font = App_Theme_PinFan_R_13_Font
        descLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.34)
        self.addSubview(descLabel)
        
        descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-26)
        }
    }
    
    func setGIfImage(){
        spalshView = FLAnimatedImageView.init()
        self.addSubview(spalshView)
        let gifPath = Bundle.main.path(forResource: "出场", ofType: ".gif")
        //指定音乐路径
        let url = URL.init(fileURLWithPath: gifPath!)
        do {
            let gifData =  try Data.init(contentsOf: url)
            let gifImage = FLAnimatedImage.init(animatedGIFData: gifData)
            spalshView.animatedImage = gifImage
            spalshView.snp.makeConstraints { (make) in
                make.top.equalTo(self.snp.top).offset(71)
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 684 / 750))
            }
            time = Timer.after(5, {
                AnimationTools.shareInstance.removeBigViewAnimation(view: self)
                UIApplication.shared.setStatusBarStyle(.default, animated: false)
                self.time.invalidate()
            })
        } catch  {
            print("error")
        }
    }
}
