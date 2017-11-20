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
        avatarImage.backgroundColor = UIColor.red
        self.contentView.addSubview(avatarImage)
        
        titleLable = UILabel.init()
        titleLable.text = "北京小疯子占领了大神榜封面"
        titleLable.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        titleLable.font = App_Theme_PinFan_M_14_Font
        titleLable.textAlignment = .center
        self.contentView.addSubview(titleLable)
        
        self.updateConstraints()
    }
    
    func cellSetData(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            avatarImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.top.equalTo(self.contentView.snp.top).offset(0)
            })
            
            titleLable.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-11)
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
