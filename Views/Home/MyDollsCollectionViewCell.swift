//
//  MyDollsCollectionViewCell.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyDollsCollectionViewCell: UICollectionViewCell {
 
    var statusImage:UIImageView!
    var statusLabel:UILabel!
    var dollsImage:UIImageView!
    var coinsImage:UIImageView!
    var coinsNumber:UILabel!
    var dollsName:UILabel!
    var isHaveDolls:UIImageView!
    
    var didMakeConstraints = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F2F2F2_Color)?.cgColor
        self.setUpView()
    }
    
    func setUpView(){
        
        dollsImage = UIImageView.init()
        dollsImage.layer.cornerRadius = 6
        dollsImage.layer.masksToBounds = true
        self.contentView.addSubview(dollsImage)
        
        statusImage = UIImageView.init()
        statusImage.image = UIImage.init(named: "tag_vacant")
        self.contentView.addSubview(statusImage)
        
        coinsImage = UIImageView.init()
        coinsImage.image = UIImage.init(named: "coin")
        self.contentView.addSubview(coinsImage)
        
        isHaveDolls = UIImageView.init()
        isHaveDolls.clipsToBounds = true
        isHaveDolls.image = UIImage.init(named: "stamp")
        self.contentView.addSubview(isHaveDolls)
        
        coinsNumber = UILabel.init()
        coinsNumber.text = "20"
        coinsNumber.textColor = UIColor.init(hexString: App_Theme_FB1531_Color)
        coinsNumber.font = App_Theme_PinFan_M_18_Font
        self.contentView.addSubview(coinsNumber)
        
        statusLabel = UILabel.init()
        
        statusLabel.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        statusLabel.font = App_Theme_PinFan_M_11_Font
        self.contentView.addSubview(statusLabel)
        
        dollsName = UILabel.init()
        dollsName.text = "布朗熊变身长颈鹿"
        dollsName.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        dollsName.font = App_Theme_PinFan_M_16_Font
        self.contentView.addSubview(dollsName)
        
        self.updateConstraints()
    }
    
    func cellSetData(model:Labels){
        dollsName.text = model.name
        coinsNumber.text = "\(model.price!)"
        
        UIImageViewManger.sd_imageView(url: model.imageAddress, imageView: dollsImage, placeholderImage: nil) { (image, error, cahce, url) in
            self.dollsImage.image = image
        }
        statusImage.image = model.freeStatus == 1 ? UIImage.init(named: "tag_vacant") : UIImage.init(named: "tag_hot")
        statusLabel.text = model.freeStatus == 1 ? "有空闲" : "热抓中"
        isHaveDolls.isHidden = model.ownStatus == 0 ? false : true
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            statusImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })
            
            statusLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(18.5)
                make.left.equalTo(self.contentView.snp.left).offset(23)
            })

            dollsImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
            
            coinsImage.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-38)
                make.left.equalTo(self.contentView.snp.left).offset(14)
            })
            
            coinsNumber.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-37)
                make.left.equalTo(self.coinsImage.snp.right).offset(3)
            })
            
            dollsName.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-11)
                make.left.equalTo(self.contentView.snp.left).offset(15)
            })
            
            isHaveDolls.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.size.equalTo(CGSize.init(width: 49, height: 59))
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
