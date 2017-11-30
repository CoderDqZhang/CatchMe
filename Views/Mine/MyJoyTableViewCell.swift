//
//  MyJoyTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class MyJoyTableViewCell: UITableViewCell {

    var dollsView:UIView!
    var dollsImage:UIImageView!
    var dollsName:UILabel!
    var dollsDesc:UILabel!
    var cacheTime:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        dollsView = UIView.init()
        dollsView.layer.cornerRadius = 6
        dollsView.layer.borderColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)?.cgColor
        dollsView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        dollsView.layer.borderWidth = 1
        self.contentView.addSubview(dollsView)
        
        dollsImage = UIImageView.init()
        dollsView.addSubview(dollsImage)
        
        dollsName = UILabel.init()
        dollsName.text = "布朗熊变声长颈鹿"
        dollsName.textAlignment = .left
        dollsName.font = App_Theme_PinFan_M_16_Font
        dollsName.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        dollsView.addSubview(dollsName)
        
        dollsDesc = UILabel.init()
        dollsDesc.text = "抓中时间"
        dollsDesc.textAlignment = .left
        dollsDesc.font = App_Theme_PinFan_M_13_Font
        dollsDesc.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        dollsView.addSubview(dollsDesc)
        
        cacheTime = UILabel.init()
        cacheTime.text = "2017-11-04 17:27:30"
        cacheTime.textAlignment = .left
        cacheTime.font = App_Theme_PinFan_M_13_Font
        cacheTime.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        dollsView.addSubview(cacheTime)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellSetData(model:MyCatchDollsModel){
        cacheTime.text = "\(Date.init(unixTimestamp: Double(model.time / 1000)).dateString())"
        dollsName.text = model.name
        
        UIImageViewManger.sd_imageView(url: model.images[0], imageView: dollsImage, placeholderImage: nil) { (image, error, cacheType, url) in

        }
        
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            dollsView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            
            dollsImage.snp.makeConstraints({ (make) in
                make.left.equalTo(dollsView.snp.left).offset(21)
                make.centerY.equalTo(dollsView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 106, height: 106))
            })
            
            dollsName.snp.makeConstraints({ (make) in
                make.left.equalTo(dollsImage.snp.right).offset(5)
                make.top.equalTo(dollsView.snp.top).offset(34)
            })
            
            dollsDesc.snp.makeConstraints({ (make) in
                make.left.equalTo(dollsImage.snp.right).offset(5)
                make.top.equalTo(dollsName.snp.bottom).offset(11)
            })
            
            cacheTime.snp.makeConstraints({ (make) in
                make.left.equalTo(dollsImage.snp.right).offset(5)
                make.top.equalTo(dollsDesc.snp.bottom).offset(3)
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

