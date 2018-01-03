//
//  UserSocialTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 30/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
class UserSocialView: AnimationTouchView {
    
    var titleLabel:UILabel!
    var descLabel:UILabel!
    
    init(frame:CGRect, title:String, desc:String, click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = App_Theme_PinFan_M_24_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(14)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        descLabel = UILabel.init()
        descLabel.text = desc
        descLabel.textAlignment = .center
        descLabel.font = App_Theme_PinFan_R_14_Font
        descLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-14)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum UserSocialTableViewCellType {
    case friendsY
    case friendsM
    case dolls
    case collect
}

typealias UserSocialTableViewCellClouse = (_ type:UserSocialTableViewCellType) ->Void

class UserSocialTableViewCell: UITableViewCell {

    var friendsY:UserSocialView!
    var friendsM:UserSocialView!
    var dollsView:UserSocialView!
    var collectView:UserSocialView!
    
    var userSocialTableViewCellClouse:UserSocialTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        friendsY = UserSocialView.init(frame: CGRect.zero, title: "223", desc: "我的抓友", click: {
            if self.userSocialTableViewCellClouse != nil {
                self.userSocialTableViewCellClouse(.friendsY)
            }
        })
        self.contentView.addSubview(friendsY)
        
        friendsM = UserSocialView.init(frame: CGRect.zero, title: "08", desc: "关注我的", click: {
            if self.userSocialTableViewCellClouse != nil {
                self.userSocialTableViewCellClouse(.friendsM)
            }
        })
        self.contentView.addSubview(friendsM)
        
        dollsView = UserSocialView.init(frame: CGRect.zero, title: "23", desc: "我的娃娃", click: {
            if self.userSocialTableViewCellClouse != nil {
                self.userSocialTableViewCellClouse(.dolls)
            }
        })
        self.contentView.addSubview(dollsView)
        
        collectView = UserSocialView.init(frame: CGRect.zero, title: "12", desc: "我的心愿", click: {
            if self.userSocialTableViewCellClouse != nil {
                self.userSocialTableViewCellClouse(.collect)
            }
        })
        self.contentView.addSubview(collectView)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            friendsY.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.size.width.equalTo(SCREENWIDTH/4)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            friendsM.snp.makeConstraints({ (make) in
                make.left.equalTo(self.friendsY.snp.right).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.size.width.equalTo(SCREENWIDTH/4)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            dollsView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.friendsM.snp.right).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.size.width.equalTo(SCREENWIDTH/4)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            collectView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.dollsView.snp.right).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.size.width.equalTo(SCREENWIDTH/4)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
