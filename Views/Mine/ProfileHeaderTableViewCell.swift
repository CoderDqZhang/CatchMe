//
//  ProfileHeaderTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var avatarImage:UIImageView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "头像"
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.contentView.addSubview(titleLabel)
        
        avatarImage = UIImageView.init()
        avatarImage.backgroundColor = UIColor.red
        avatarImage.layer.cornerRadius = 19
        avatarImage.layer.masksToBounds = true
        self.contentView.addSubview(avatarImage)
        
        self.updateConstraints()
    }
    
    func cellSetData(imageUrl:String){
        UIImageViewManger.shareInstance.sd_imageView(url: imageUrl, imageView: avatarImage, placeholderImage: nil) { (image, error, cacheType, url) in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(20)
            })
            
            avatarImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-5)
                make.size.equalTo(CGSize.init(width: 38, height: 38))
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
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
