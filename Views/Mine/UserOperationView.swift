//
//  UserOperationView.swift
//  CatchMe
//
//  Created by Zhang on 31/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum UserOperationViewType {
    case unfollow
    case shield
    case complain
}

typealias UserOperationViewClickType = (_ type:UserOperationViewType) -> Void

class UserOperationView: UIView {

    var detailView:UIView!
    
    var unfollowView:AnimationTouchViewButton!
    var shieldView:AnimationTouchViewButton!
    var complainView:AnimationTouchViewButton!
    var userOperationViewClickType:UserOperationViewClickType!
    
    init(frame: CGRect, click:@escaping UserOperationViewClickType) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.7)
        
        let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.removeSelf))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singTap)
        
        detailView = UIView.init(frame: CGRect.init(x: 25, y: SCREENHEIGHT, width: SCREENWIDTH - 50 , height: 212))
        detailView.layer.cornerRadius = 10
        detailView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.addSubview(detailView)
        
        
        unfollowView = AnimationTouchViewButton.init(frame: CGRect.zero, type: .redbg, title: "取消关注", titleImage: nil, click: {
            click(.unfollow)
            self.removeSelf()
        })
        detailView.addSubview(unfollowView)
        unfollowView.snp.makeConstraints { (make) in
            make.left.equalTo(detailView.snp.left).offset(18)
            make.right.equalTo(detailView.snp.right).offset(-18)
            make.top.equalTo(detailView.snp.top).offset(18)
            make.height.equalTo(44)
        }
        
        shieldView = AnimationTouchViewButton.init(frame: CGRect.zero, type: .redbg, title: "屏蔽TA", titleImage: nil, click: {
            click(.shield)
            self.removeSelf()
        })
        detailView.addSubview(shieldView)
        shieldView.snp.makeConstraints { (make) in
            make.left.equalTo(detailView.snp.left).offset(18)
            make.right.equalTo(detailView.snp.right).offset(-18)
            make.top.equalTo(unfollowView.snp.bottom).offset(25)
            make.height.equalTo(44)
        }
        
        complainView = AnimationTouchViewButton.init(frame: CGRect.zero, type: .redbg, title: "投诉TA", titleImage: nil, click: {
            click(.complain)
            self.removeSelf()
        })
        
        detailView.addSubview(complainView)
        complainView.snp.makeConstraints { (make) in
            make.left.equalTo(detailView.snp.left).offset(18)
            make.right.equalTo(detailView.snp.right).offset(-18)
            make.top.equalTo(shieldView.snp.bottom).offset(25)
            make.height.equalTo(44)
        }
        
        self.enterAnimation()
    }
    
    @objc func removeSelf(){
        AnimationTools.shareInstance.moveAnimation(view: self.detailView, frame: CGRect.init(x: 25, y: SCREENHEIGHT, width: SCREENWIDTH - 50, height: 212)) { (ret) in
           self.removeFromSuperview()
        }
    }
    
    func enterAnimation(){
        AnimationTools.shareInstance.moveAnimation(view: self.detailView, frame: CGRect.init(x: 25, y: SCREENHEIGHT - 212 - 25, width: SCREENWIDTH - 50, height: 212)) { (ret) in
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
