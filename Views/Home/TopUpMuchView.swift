//
//  TopUpMuchView.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum MuchViewType {
    case select
    case normal
}

class MuchView: UIView {
    var imageView:UIImageView!
    var muchLable:UILabel!
    var muchIcon:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30
        self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true

        imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "rechang_choosen")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 90, bottom: 0, right: 64), resizingMode: .stretch)
        self.addSubview(imageView)
        
        muchLable = UILabel.init()
        muchLable.font = App_Theme_PinFan_R_15_Font
        muchLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.addSubview(muchLable)
        
        muchIcon = UILabel.init()
        muchIcon.font = App_Theme_PinFan_M_20_Font
        muchIcon.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.addSubview(muchIcon)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.right.equalTo(self.snp.right).offset(0)
        }
        
        muchLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
        
        muchIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self.snp.top).offset(9)
        }
        
    }
    
    func changeType(type:MuchViewType){
        switch type {
        case MuchViewType.select:
            imageView.isHidden = false
            self.layer.cornerRadius = 0
            muchLable.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            muchIcon.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.layer.borderColor = UIColor.clear.cgColor
            muchIcon.snp.remakeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(60)
                make.top.equalTo(self.snp.top).offset(9)
            }
            
            muchLable.snp.remakeConstraints { (make) in
                make.left.equalTo(self.snp.left).offset(60)
                make.bottom.equalTo(self.snp.bottom).offset(-8)
            }
        default:
            imageView.isHidden = true
            self.layer.cornerRadius = 30
            muchLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            muchIcon.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            self.layer.borderColor = UIColor.init(hexString: App_Theme_FC4652_Color)?.cgColor
            muchIcon.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.top.equalTo(self.snp.top).offset(9)
            }
            
            muchLable.snp.remakeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX).offset(0)
                make.bottom.equalTo(self.snp.bottom).offset(-8)
            }
        }
    }
    
    func setUpMuchViewData(much:String, icon:String) {
        muchLable.text = much
        muchIcon.text = icon
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias TopUpMuchViewClouse = (_ tag:Int) -> Void
class TopUpMuchView: UIView {

    var topUpMuchViewClouse:TopUpMuchViewClouse!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        let icon = ["100币","230币","590币","1200币","2420币","6100币"]
        let much = ["￥10.00","￥20.00","￥50.00","￥100.00","￥200.00","￥500.00"]
        for i in 1...6 {
            let frame = CGRect.init(x: (i - 1) % 2 == 0 ? 20 : SCREENWIDTH/2 + 7.5, y: CGFloat((i-1) / 2 * 80), width: (SCREENWIDTH - 40 - 15)/2, height: 60)
            let muchView = MuchView.init(frame: frame)
            muchView.tag = i
            self.setUpSingleTap(muchView: muchView)
            muchView.setUpMuchViewData(much: much[i - 1], icon: icon[i - 1])
            if i == 1 {
                muchView.changeType(type: .select)
            }else{
                muchView.changeType(type: .normal)
            }
            self.addSubview(muchView)
        }
    }
    
    func setUpSingleTap(muchView:MuchView){
        let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.singTap(tag:)))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        muchView.addGestureRecognizer(singTap)
    }
    
    @objc func singTap(tag:UITapGestureRecognizer){
        let viewTag = tag.view?.tag
        for i in 1...6 {
            let muchView = self.viewWithTag(i) as! MuchView
            if i == viewTag {
                muchView.changeType(type: .select)
            }else{
                muchView.changeType(type: .normal)
            }
        }
        if topUpMuchViewClouse != nil {
            topUpMuchViewClouse(viewTag!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
