//
//  TopAvatarTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopAvatarTableViewCell: UITableViewCell {

    var avatarImage:UIImageView!
    var titleLable:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){

        avatarImage = UIImageView.init()
        avatarImage.image = UIImage.init(named: "top_bg")
        self.contentView.addSubview(avatarImage)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:TopWeeklyModel){
//        UIImageViewManger.sd_imageView(url: model.gameStatistics[0].photo is String ? model.gameStatistics[0].photo as! String : "", imageView: avatarImage, placeholderImage: nil) { (image, error, cacheType, url) in
//
//        }
//        titleLable.text = model.gameStatistics[0].name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
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
