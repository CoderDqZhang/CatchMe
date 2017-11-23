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
    var genderImage:UIImageView!
    var userName:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_6D4033_Color)
        self.setUpView()
    }
    
    func setUpView(){
        headerImage = UIImageView.init()
        headerImage.layer.cornerRadius = 44
        headerImage.layer.masksToBounds = true
        headerImage.backgroundColor = UIColor.red
        self.contentView.addSubview(headerImage)
        
        genderImage = UIImageView.init()
        genderImage.layer.masksToBounds = true
        self.contentView.addSubview(genderImage)
        
        userName = UILabel.init()
        userName.text = "小明0628"
        userName.textAlignment = .center
        userName.font = App_Theme_PinFan_M_20_Font
        userName.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.contentView.addSubview(userName)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:UserInfoModel){
        if model.photo != nil && model.photo != "" {
            UIImageViewManger.shareInstance.sd_imageView(url: model.photo, imageView: headerImage, placeholderImage: nil) { (image, error, cacheType, url) in
                
            }
        }
        
        genderImage.image = model.gender == 0 ? UIImage.init(named: "female_me") : UIImage.init(named: "male_me")
        
        userName.text = model.userName
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            headerImage.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 88, height: 88))
            })
            genderImage.snp.makeConstraints({ (make) in
                make.left.equalTo(headerImage.snp.left).offset(70)
                make.top.equalTo(headerImage.snp.top).offset(70)
                make.size.equalTo(CGSize.init(width: 18, height: 18))
            })
            userName.snp.makeConstraints({ (make) in
                make.top.equalTo(headerImage.snp.bottom).offset(7)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
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
