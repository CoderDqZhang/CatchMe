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

    var image:UIImageView!
    
    init(frame: CGRect,topUpHomeViewClouse:@escaping TopUpHomeViewClouse) {
        super.init(frame: frame)
        let singTap = UITapGestureRecognizerManager.shareInstance.initTapGestureRecognizer {
            topUpHomeViewClouse()
        }
        self.backgroundColor = UIColor.red
        self.addGestureRecognizer(singTap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
