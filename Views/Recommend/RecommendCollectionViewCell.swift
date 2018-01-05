//
//  RecommendCollectionViewCell.swift
//  CatchMe
//
//  Created by Zhang on 29/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    var userName:UILabel!
    var userLoction:UILabel!
    var userCoins:UILabel!
    var userStatusView:GloabelStatusView!
    var coinImage:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        userName = UILabel.init()
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userName.text = "泰迪熊"
        userName.font = App_Theme_PinFan_R_13_Font
        self.addSubview(userName)
        
        userLoction = UILabel.init()
        userLoction.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userLoction.text = "北京市"
        userLoction.font = App_Theme_PinFan_R_13_Font
        self.addSubview(userLoction)
        
        userStatusView = GloabelStatusView.init(frame: CGRect.init(x: 59, y: 28, width: 35, height: 14), title: "29", type: GloabelStatusViewType.male)
        self.addSubview(userStatusView)
        
        coinImage = UIImageView.init()
        coinImage.image = UIImage.init(named: "白钻石")
        self.addSubview(coinImage)
        
        userCoins = UILabel.init()
        userCoins.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.7)
        userCoins.text = "330"
        userCoins.font = App_Theme_PinFan_M_13_Font
        self.addSubview(userCoins)
        self.updateConstraintss()
    }
    
    
    func updateConstraintss() {
        userName.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-23)
            make.left.equalTo(self.snp.left).offset(8)
        })
        
        userLoction.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-6)
            make.left.equalTo(self.snp.left).offset(8)
        })
        
        userStatusView.snp.makeConstraints({ (make) in
            make.left.equalTo(userLoction.snp.right).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-6)
            make.size.equalTo(CGSize.init(width: 34, height: 14))
        })
        
        userCoins.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-4)
            make.right.equalTo(self.snp.right).offset(-18)
        })
        
        coinImage.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-6)
            make.right.equalTo(self.userCoins.snp.left).offset(-4)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecommendCollectionViewCell: UICollectionViewCell {
    
    var statusImage:UIImageView!
    var statusLabel:UILabel!
    var avatarImage:UIImageView!
    
    var userInfoView:UserInfoView!
    
    var userAction:UIView!
    var microphone:UIImageView!
    var videoOne:UIImageView!
    var videoTwo:UIImageView!
    var actionBtn:AnimationButton!
    
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F2F2F2_Color)?.cgColor
        self.setUpView()
    }
    
    func setUpView(){
        
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.brown
        avatarImage.layer.masksToBounds = true
        self.contentView.addSubview(avatarImage)
        
        statusImage = UIImageView.init()
        statusImage.image = UIImage.init(named: "tag_vacant")
        self.contentView.addSubview(statusImage)
        
        statusLabel = UILabel.init()
        statusLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        statusLabel.font = App_Theme_PinFan_M_11_Font
        self.contentView.addSubview(statusLabel)
        
        userInfoView = UserInfoView.init()
        self.contentView.addSubview(userInfoView)
        
        userAction = UIView.init()
        self.contentView.addSubview(userAction)
        
        microphone = UIImageView.init()
        microphone.image = UIImage.init(named: "音频状态关")
        userAction.addSubview(microphone)
        
        videoOne = UIImageView.init()
        videoOne.image = UIImage.init(named: "单向状态关")
        userAction.addSubview(videoOne)
        
        videoTwo = UIImageView.init()
        videoTwo.image = UIImage.init(named: "互聊状态关")
        userAction.addSubview(videoTwo)
        
        
        actionBtn = AnimationButton.init(frame: CGRect.zero)
        actionBtn.setTitle("关注", for: .normal)
        actionBtn.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        actionBtn.layer.cornerRadius = 12
        actionBtn.layer.masksToBounds = true
        actionBtn.titleLabel?.font = App_Theme_PinFan_R_14_Font
        actionBtn.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        userAction.addSubview(actionBtn)
        
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            statusImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })

            statusLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(18.5)
                make.left.equalTo(self.contentView.snp.left).offset(23)
            })

            avatarImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-40)
            })
            
            userInfoView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-40)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.height.equalTo(47)
            })
                        
            userAction.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.height.equalTo(40)
            })
            
            
            
            microphone.snp.makeConstraints({ (make) in
                make.left.equalTo(self.userAction.snp.left).offset(8)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
            })
            
            videoOne.snp.makeConstraints({ (make) in
                make.left.equalTo(self.microphone.snp.right).offset(6)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
            })
            
            videoTwo.snp.makeConstraints({ (make) in
                make.left.equalTo(self.videoOne.snp.right).offset(6)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
            })
            
            actionBtn.snp.makeConstraints({ (make) in
                make.right.equalTo(self.userAction.snp.right).offset(-10)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 56, height: 24))
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
