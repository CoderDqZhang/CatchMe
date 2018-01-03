//
//  UserAuthorityTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 31/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
enum UserAuthorityViewType {
    case close
    case open
}

typealias ChangeMuchClouse = () ->Void

class UserAuthorityView: AnimationTouchView {
    var imageView:UIImageView!
    var titleLable:UILabel!
    var statusLabel:UILabel!
    var muchLabel:UILabel!
    
    var changeMuchClouse:ChangeMuchClouse!
    
    var type:UserAuthorityViewType!
    init(frame:CGRect, image:UIImage, title:String, status:String, much:String, type:UserAuthorityViewType, isOwnUser:Bool, click:@escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        self.type = type
        imageView = UIImageView.init()
        imageView.image = image
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(14)
        }
        
        titleLable = UILabel.init()
        titleLable.text = title
        titleLable.textAlignment = .center
        titleLable.font = App_Theme_PinFan_R_14_Font
        titleLable.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(imageView.snp.bottom).offset(9)
        }
        
        statusLabel = UILabel.init()
        statusLabel.text = status
        statusLabel.textAlignment = .center
        statusLabel.font = App_Theme_PinFan_R_14_Font
        statusLabel.textColor = UIColor.init(hexString: App_Theme_C7C7C7_Color)
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(titleLable.snp.bottom).offset(7)
        }
        
        muchLabel = UILabel.init()
        muchLabel.text = much
        muchLabel.layer.cornerRadius = 13
        muchLabel.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        muchLabel.tag = 100
        muchLabel.layer.masksToBounds = true
        muchLabel.textAlignment = .center
        muchLabel.font = App_Theme_PinFan_R_12_Font
        muchLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(muchLabel)
        let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singleTap(tag:)))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        muchLabel.isUserInteractionEnabled = true
        muchLabel.addGestureRecognizer(singTap)
        
        muchLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(statusLabel.snp.bottom).offset(9)
            make.size.equalTo(CGSize.init(width: 70, height: 26))
        }
        if isOwnUser {
        }else{
            self.userAuthorityType(type:type)
        }
        
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.tag == 100 {
            return false
        }
        return true
    }
    
    @objc func singleTap(tag:UITapGestureRecognizer) {
        if self.changeMuchClouse != nil {
            self.changeMuchClouse()
        }
    }
    
    func userAuthorityType(type:UserAuthorityViewType){
        self.type = type
        muchLabel.isUserInteractionEnabled = type == .open ? true : false
        statusLabel.text = type == .open ? "开启" : "关闭"
        if type == .close {
            titleLable.textColor = UIColor.init(hexString: App_Theme_C7C7C7_Color)
            muchLabel.layer.borderWidth = 0.5
            muchLabel.layer.borderColor = UIColor.init(hexString: App_Theme_C7C7C7_Color)?.cgColor
            muchLabel.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        }else{
            titleLable.textColor = UIColor.init(hexString: titleLable)
            titleLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            muchLabel.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            muchLabel.layer.borderWidth = 0.5
            muchLabel.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
        }
    }
    
    func setUserAuthorityType(image:UIImage,type:UserAuthorityViewType){
        imageView.image = image
        self.type = type
        muchLabel.isUserInteractionEnabled = type == .open ? true : false
        statusLabel.text = type == .open ? "开启" : "关闭"
        if type == .close {
            titleLable.textColor = UIColor.init(hexString: App_Theme_C7C7C7_Color)
            muchLabel.backgroundColor = UIColor.init(hexString: App_Theme_C7C7C7_Color)
        }else{
            titleLable.textColor = UIColor.init(hexString: titleLable)
            muchLabel.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        }
    }
    
    func updateMuchLabel(str:String){
        muchLabel.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum UserAuthorityTableViewCellSelectType {
    case voice
    case oneVideo
    case twoVideo
}

typealias UserAuthorityTableViewCellClouse = (_ type:UserAuthorityTableViewCellSelectType) -> Void

class UserAuthorityTableViewCell: UITableViewCell {

    var voiceView:UserAuthorityView!
    var oneVideoView:UserAuthorityView!
    var twoVideoView:UserAuthorityView!
    var userAuthorityTableViewCellClouse:UserAuthorityTableViewCellClouse!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
    }
    
    func setUpView(isOwnUser:Bool){
        voiceView = UserAuthorityView.init(frame: CGRect.init(x: 29, y: 14, width: 90, height: 196), image: UIImage.init(named: "me_音频开启")!, title: "音频聊天", status: "开启", much: "10币/分", type: .open, isOwnUser:isOwnUser, click: {
            if self.voiceView.type == .close {
                self.voiceView.setUserAuthorityType(image: UIImage.init(named: "me_音频开启")!, type: .open)
                if self.userAuthorityTableViewCellClouse != nil {
                    self.userAuthorityTableViewCellClouse(.voice)
                }
            }else{
                self.voiceView.setUserAuthorityType(image: UIImage.init(named: "me_音频关闭")!, type: .close)
            }
            
        })
        voiceView.changeMuchClouse = {
            if self.userAuthorityTableViewCellClouse != nil {
                self.userAuthorityTableViewCellClouse(.voice)
            }
        }
        self.contentView.addSubview(voiceView)
        
        oneVideoView = UserAuthorityView.init(frame: CGRect.zero, image: UIImage.init(named: "onevideo_open")!, title: "单向视频", status: "开启", much: "30币/分", type: .open, isOwnUser:isOwnUser, click: {
            if self.oneVideoView.type == .close {
                self.oneVideoView.setUserAuthorityType(image: UIImage.init(named: "onevideo_open")!, type: .open)
                if self.userAuthorityTableViewCellClouse != nil {
                    self.userAuthorityTableViewCellClouse(.oneVideo)
                }
            }else{
                self.oneVideoView.setUserAuthorityType(image: UIImage.init(named: "onevideo_close")!, type: .close)
            }
            
        })
        oneVideoView.changeMuchClouse = {
            if self.userAuthorityTableViewCellClouse != nil {
                self.userAuthorityTableViewCellClouse(.oneVideo)
            }
        }
        self.contentView.addSubview(oneVideoView)
        
        twoVideoView = UserAuthorityView.init(frame: CGRect.zero, image: UIImage.init(named: "twovideo_open")!, title: "视频互聊", status: "开启", much: "60币/分", type: .open, isOwnUser:isOwnUser, click: {
            if self.twoVideoView.type == .close {
                self.twoVideoView.setUserAuthorityType(image: UIImage.init(named: "twovideo_open")!, type: .open)
                if self.userAuthorityTableViewCellClouse != nil {
                    self.userAuthorityTableViewCellClouse(.twoVideo)
                }
            }else{
                self.twoVideoView.setUserAuthorityType(image: UIImage.init(named: "twovideo_close")!, type: .close)
            }
        })
        twoVideoView.changeMuchClouse = {
            if self.userAuthorityTableViewCellClouse != nil {
                self.userAuthorityTableViewCellClouse(.twoVideo)
            }
        }
        self.contentView.addSubview(twoVideoView)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(isOwnUser:Bool){
        self.setUpView(isOwnUser: isOwnUser)
        if isOwnUser {
            
        }else{
            voiceView.isUserInteractionEnabled = false
            oneVideoView.isUserInteractionEnabled = false
            twoVideoView.isUserInteractionEnabled = false
        }
    }
    
    func updateUserAuthority(type:UserAuthorityTableViewCellSelectType, much:String) {
        switch type {
        case .voice:
            self.voiceView.updateMuchLabel(str: "\(much)抓/分")
        case .oneVideo:
            self.oneVideoView.updateMuchLabel(str: "\(much)抓/分")
        default:
            self.twoVideoView.updateMuchLabel(str: "\(much)抓/分")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
           
            oneVideoView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 90, height: 196))
            })
            
            twoVideoView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-29)
                make.size.equalTo(CGSize.init(width: 90, height: 196))
            })
            
            voiceView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(29)
                make.size.equalTo(CGSize.init(width: 90, height: 196))
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
