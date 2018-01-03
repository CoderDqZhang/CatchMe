//
//  FriendsCollectionViewCell.swift
//  CatchMe
//
//  Created by Zhang on 30/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum UserActionButtonViewType {
    case normal
    case disable
}

class UserActionButtonView: AnimationTouchView {
    var titleLabel:UILabel!
    var imageView:UIImageView!
    init(frame: CGRect, title:String, image:UIImage,type:UserActionButtonViewType, click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        
        imageView = UIImageView.init()
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(6)
        }
        
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.font = App_Theme_PinFan_R_11_Font
        if type == .normal{
            self.isUserInteractionEnabled = true
            titleLabel.textColor = UIColor.init(hexString: App_Theme_7A7A7A_Color)
        }else{
            self.isUserInteractionEnabled = false
            titleLabel.textColor = UIColor.init(hexString: App_Theme_D8D8D8_Color)
        }
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(imageView.snp.bottom).offset(6)
        }        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum UserActionType {
    case voice
    case onevideo
    case twovideo
}

typealias FriendsCollectionViewCellClouse = (_ type:UserActionType) -> Void

class FriendsCollectionViewCell: UICollectionViewCell {
    
    var statusImage:UIImageView!
    var statusLabel:UILabel!
    var avatarImage:UIImageView!
    
    var userInfoView:UIView!
    var userName:UILabel!
    var userLoction:UILabel!
    var userCoins:UILabel!
    var userStatusView:GloabelStatusView!
    var coinImage:UIImageView!
    
    var userAction:UIView!
    var microphone:UserActionButtonView!
    var videoOne:UserActionButtonView!
    var videoTwo:UserActionButtonView!
    
    var friendsCollectionViewCellClouse:FriendsCollectionViewCellClouse!
    var didMakeConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.setUpView()
    }
    
    func setUpView(){
        
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.brown
        avatarImage.layer.cornerRadius = 6
        avatarImage.layer.masksToBounds = true
        self.contentView.addSubview(avatarImage)
        
        statusImage = UIImageView.init()
        statusImage.image = UIImage.init(named: "tag_vacant")
        self.contentView.addSubview(statusImage)
        
        statusLabel = UILabel.init()
        statusLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        statusLabel.font = App_Theme_PinFan_M_11_Font
        self.contentView.addSubview(statusLabel)
        
        userInfoView = UIView.init()
        self.contentView.addSubview(userInfoView)
        
        userName = UILabel.init()
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userName.text = "泰迪熊"
        userName.font = App_Theme_PinFan_R_13_Font
        userInfoView.addSubview(userName)
        
        userLoction = UILabel.init()
        userLoction.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userLoction.text = "北京市"
        userLoction.font = App_Theme_PinFan_R_13_Font
        userInfoView.addSubview(userLoction)
        
        //        userStatusView = GloabelStatusView.init(frame: CGRect.zero, title: "29", type: GloabelStatusViewType.male)
        //        userInfoView.addSubview(userStatusView)
        
        coinImage = UIImageView.init()
        coinImage.image = UIImage.init(named: "白钻石")
        userInfoView.addSubview(coinImage)
        
        userCoins = UILabel.init()
        userCoins.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.7)
        userCoins.text = "330"
        userCoins.font = App_Theme_PinFan_M_13_Font
        userInfoView.addSubview(userCoins)
        
        userAction = UIView.init()
        self.contentView.addSubview(userAction)
        
        microphone = UserActionButtonView.init(frame: CGRect.zero, title: "音频聊天", image: UIImage.init(named: "friends_音频状态关")!, type:.disable, click: {
            if self.friendsCollectionViewCellClouse != nil{
                self.friendsCollectionViewCellClouse(.voice)
            }
        })
        userAction.addSubview(microphone)
        
        videoOne = UserActionButtonView.init(frame: CGRect.zero, title: "单向视频", image: UIImage.init(named: "friends_单向视频关")!,type:.disable, click: {
            if self.friendsCollectionViewCellClouse != nil{
                self.friendsCollectionViewCellClouse(.onevideo)
            }
        })
        userAction.addSubview(videoOne)
        
        videoTwo = UserActionButtonView.init(frame: CGRect.zero, title: "视频互聊", image: UIImage.init(named: "friends_互聊状态开")!,type:.normal, click: {
            if self.friendsCollectionViewCellClouse != nil{
                self.friendsCollectionViewCellClouse(.twovideo)
            }
        })
        userAction.addSubview(videoTwo)
        
        
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
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-60)
            })
            
            userInfoView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-60)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.height.equalTo(47)
            })
            
            userAction.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.height.equalTo(60)
            })
            
            userName.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.userInfoView.snp.bottom).offset(-23)
                make.left.equalTo(self.userInfoView.snp.left).offset(8)
            })
            
            userLoction.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.userInfoView.snp.bottom).offset(-6)
                make.left.equalTo(self.userInfoView.snp.left).offset(8)
            })
            
            userCoins.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.userInfoView.snp.bottom).offset(-4)
                make.right.equalTo(self.userInfoView.snp.right).offset(-18)
            })
            
            coinImage.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.userInfoView.snp.bottom).offset(-6)
                make.right.equalTo(self.userCoins.snp.left).offset(-4)
            })
            
            microphone.snp.makeConstraints({ (make) in
                make.left.equalTo(self.userAction.snp.left).offset(6)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: ((SCREENWIDTH - 14) / 2 - 12) / 3, height: 60))
            })
            
            videoOne.snp.makeConstraints({ (make) in
                make.left.equalTo(self.microphone.snp.right).offset(6)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
                make.centerX.equalTo(self.userAction.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: ((SCREENWIDTH - 14) / 2 - 12) / 3, height: 60))
            })
            
            videoTwo.snp.makeConstraints({ (make) in
                make.right.equalTo(self.userAction.snp.right).offset(-6)
                make.centerY.equalTo(self.userAction.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: ((SCREENWIDTH - 14) / 2 - 12) / 3, height: 60))
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
