//
//  MineHeaderTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import SDWebImage


class MineHeaderTableViewCell: UITableViewCell {

    var headerImage:UIImageView!
    
    var userInfoView:UIView!
    var userName:UILabel!
    var userLoction:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        
        headerImage = UIImageView.init()
        headerImage.image = UIImage.init(named: "默认头像_1")
        headerImage.layer.masksToBounds = true
        headerImage.backgroundColor = UIColor.red
        self.contentView.addSubview(headerImage)
        
        
        
        userInfoView = UIView.init()
        self.contentView.addSubview(userInfoView)
        
        userName = UILabel.init()
        userName.text = "小明0628"
        userName.textAlignment = .center
        userName.font = App_Theme_PinFan_M_20_Font
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userInfoView.addSubview(userName)
        
        userLoction = UILabel.init()
        userLoction.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        userLoction.text = "北京市"
        userLoction.font = App_Theme_PinFan_R_14_Font
        userInfoView.addSubview(userLoction)
        let strs = ["29","在线","游戏中"]
        let types = [GloabelStatusViewType.male,GloabelStatusViewType.oline,GloabelStatusViewType.onGame]
        var maxX:CGFloat = 77
        for i in 0...2 {
            var width:CGFloat = (strs[i] as NSString).width(with: App_Theme_PinFan_R_11_Font, constrainedToHeight: 16) + 14
            if (types[i] == .male) || (types[i] == .male) {
                width = width + 10
            }
            let frame = CGRect.init(x: maxX, y: 45, width: width, height: 16)
            let userStatusView = GloabelStatusView.init(frame: frame, title: strs[i], type: types[i])
            maxX = userStatusView.frame.maxX + 10
            userInfoView.addSubview(userStatusView)
        }
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:UserInfoModel){
        if model.photo != nil && model.photo != "" {
            UIImageViewManger.sd_imageView(url: model.photo, imageView: headerImage, placeholderImage: UIImage.init(named: "默认头像_1")) { (image, error, cacheType, url) in
                let newImageSize = image?.scaled(toWidth: SCREENWIDTH)
                let inputImage = newImageSize?.cropped(to: CGRect.init(x: 0, y: ((newImageSize?.size.height)! - self.contentView.frame.height)/2, width: SCREENWIDTH, height: self.contentView.frame.height))
                self.headerImage.image = inputImage
            }
        }
        
        
        userName.text = model.userName
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            headerImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            
            userInfoView.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.height.equalTo(74)
            })
            
            userName.snp.makeConstraints({ (make) in
                make.top.equalTo(self.userInfoView.snp.top).offset(14)
                make.left.equalTo(self.userInfoView.snp.left).offset(20)
            })
            
            userLoction.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.userInfoView.snp.bottom).offset(-12)
                make.left.equalTo(self.userInfoView.snp.left).offset(20)
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
