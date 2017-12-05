//
//  SetNormalTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SetNormalTableViewCell: UITableViewCell {

    var normalImage:UIImageView!
    var titleLabel:UILabel!
    var isSelect:Bool = true
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        normalImage = UIImageView.init()
        self.contentView.addSubview(normalImage)
        
        titleLabel = UILabel.init()
        titleLabel.text = "设置为默认收货人"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleLabel.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        self.updateConstraints()
    }
    
    func normaleImageSelect(isSelect:Bool) {
        self.isSelect = isSelect
        if isSelect {
            normalImage.image = UIImage.init(named: "check")
        }else{
            normalImage.image = UIImage.init(named: "uncheck")
        }
        self.updateConstraintsIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            normalImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(23)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 16, height: 16))
            })
            titleLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.normalImage.snp.right).offset(4)
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
