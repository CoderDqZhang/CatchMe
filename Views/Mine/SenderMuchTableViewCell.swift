//
//  SenderMuchTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SenderMuchTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var descLabel:UILabel!
    var muchImage:UIImageView!
    var muchLabel:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "邮寄费用"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleLabel.font = App_Theme_PinFan_M_15_Font
        self.contentView.addSubview(titleLabel)
        
        descLabel = UILabel.init()
        descLabel.text = "(两只以上免邮费哦~亲)"
        descLabel.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        descLabel.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(descLabel)
        
        muchLabel = UILabel.init()
        muchLabel.text = "100"
        muchLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        muchLabel.font = App_Theme_PinFan_M_15_Font
        self.contentView.addSubview(muchLabel)
        
        muchImage = UIImageView.init()
        muchImage.image = UIImage.init(named: "coin")
        self.contentView.addSubview(muchImage)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(19)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            descLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.titleLabel.snp.right).offset(5)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            muchLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-18)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            muchImage.snp.makeConstraints({ (make) in
                make.right.equalTo(muchLabel.snp.left).offset(-5)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 22, height: 18))
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
