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
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F2F2F2_Color)?.cgColor
        self.setUpView()
    }
    
    func setUpView(){
        statusImage = UIImageView.init()
        statusImage.backgroundColor = UIColor.red
        self.contentView.addSubview(statusImage)
        
        dollsImage = UIImageView.init()
        dollsImage.backgroundColor = UIColor.black
        self.contentView.addSubview(dollsImage)
        
        coinsImage = UIImageView.init()
        coinsImage.backgroundColor = UIColor.blue
        self.contentView.addSubview(coinsImage)
        
        isHaveDolls = UIImageView.init()
        isHaveDolls.clipsToBounds = true
        isHaveDolls.backgroundColor = UIColor.brown
        self.contentView.addSubview(isHaveDolls)
        
        coinsNumber = UILabel.init()
        coinsNumber.text = "20"
        coinsNumber.textColor = UIColor.init(hexString: App_Theme_FB1531_Color)
        coinsNumber.font = App_Theme_PinFan_M_18_Font
        self.contentView.addSubview(coinsNumber)
        
        dollsName = UILabel.init()
        dollsName.text = "布朗熊变身长颈鹿"
        dollsName.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        dollsName.font = App_Theme_PinFan_M_16_Font
        self.contentView.addSubview(dollsName)
        
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        if !didMakeConstraints {
            statusImage.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(15)
                make.size.equalTo(CGSize.init(width: 50, height: 20))
            })

            dollsImage.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 136, height: 136))
            })
            
            coinsImage.snp.makeConstraints({ (make) in
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-38)
                make.left.equalTo(self.contentView.snp.left).offset(14)
                make.size.equalTo(CGSize.init(width: 24, height: 19))
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
                make.right.equalTo(self.contentView.snp.right).offset(10)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.size.equalTo(CGSize.init(width: 60, height: 60))
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
