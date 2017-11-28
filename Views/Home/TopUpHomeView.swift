//
//  TopUpHomeView.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias TopUpHomeViewClouse = () ->Void
class TopUpHomeView: UIView {

    var imageView:UIImageView!
    var label:UILabel!
    
    init(frame: CGRect,topUpHomeViewClouse:@escaping TopUpHomeViewClouse) {
        super.init(frame: frame)
        let singTap = UITapGestureRecognizerManager.shareInstance.initTapGestureRecognizer {
            topUpHomeViewClouse()
        }
        imageView = UIImageView.init()
        self.imageView.image = UIImage.init(named: "recharge")
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 86, height: 86))
        }
        
        label = UILabel.init()
        label.text = "充值"
        label.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        label.font = App_Theme_PinFan_M_12_Font
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom).offset(-18)
        }
        
        self.addGestureRecognizer(singTap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
