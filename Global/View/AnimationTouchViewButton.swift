//
//  AnimationTouchViewButton.swift
//  CatchMe
//
//  Created by Zhang on 31/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum AnimationTouchViewButtonType {
    case redbg
}

class AnimationTouchViewButton: AnimationTouchView {

    var topButton:UIButton!
    var backImage:UIImageView!
    
    init(frame: CGRect, type:AnimationTouchViewButtonType,title:String?, titleImage:UIImage?, click: @escaping TouchClickClouse) {
        super.init(frame: frame) {
            click()
        }
        backImage = UIImageView.init()
        backImage.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
        backImage.frame = CGRect.init(x: 0, y: 2, width: frame.size.width, height: frame.size.height - 2)
        backImage.layer.cornerRadius = 23
        backImage.layer.masksToBounds = true
        self.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self.snp.top).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
        
        
        topButton = UIButton.init(type: .custom)
        topButton.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 2)
        topButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        topButton.setImage(titleImage, for: .normal)
        topButton.setTitle(title, for: .normal)
        topButton.layer.cornerRadius = 23
        topButton.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        topButton.titleLabel?.font = App_Theme_PinFan_M_17_Font
        self.addSubview(topButton)

        topButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
        }
        
        self.setUpTochViewButtonType(type: type)
    }
    
    func setUpTochViewButtonType(type:AnimationTouchViewButtonType) {
        switch type {
        case .redbg:
            topButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            backImage.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
