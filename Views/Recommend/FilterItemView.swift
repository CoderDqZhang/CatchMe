//
//  FilterItemView.swift
//  CatchMe
//
//  Created by Zhang on 05/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit
enum FilterItemViewType {
    case select
    case normal
}

let FilterItemViewWidth:CGFloat = 70
let FilterItemViewHeight:CGFloat = 30
let FilterItemViewSpace:CGFloat = (SCREENWIDTH - 40 - FilterItemViewWidth * 3) / 2

typealias FilterItemViewClouse = (_ tag:Int) -> Void
class FilterItemView: AnimationTouchView {

    var type:FilterItemViewType!
    var imageView:UIImageView!
    var titleLabel:UILabel!
    
    init(frame: CGRect,type:FilterItemViewType, title:String, tag:Int, image:UIImage?,  click: @escaping FilterItemViewClouse) {
        super.init(frame: frame) {
            click(tag)
        }
        self.type = type
        if image != nil {
            imageView = UIImageView.init()
            imageView.image = image
            self.addSubview(imageView)
            imageView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(2)
                make.centerY.equalTo(self.snp.centerY).offset(0)
            })
        }
        titleLabel = UILabel.init()
        titleLabel.text = title
        titleLabel.font = App_Theme_PinFan_M_16_Font
        self.addSubview(titleLabel)
        if image != nil {
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(20)
                make.centerY.equalTo(self.snp.centerY).offset(0)
                
            }
        }else{
            titleLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.centerY.equalTo(self.snp.centerY).offset(0)
                
            }
        }
        
        self.layer.cornerRadius = FilterItemViewHeight / 2
        
        self.changeItemType(type: type)
        
    }
    
    func changeItemType(type:FilterItemViewType){
        if type == .normal {
            self.layer.borderWidth = 0
            self.titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        }else{
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
            self.titleLabel.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
