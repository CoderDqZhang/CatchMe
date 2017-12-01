
//
//  UIButton+Extentions.swift
//  LiangPiao
//
//  Created by Zhang on 12/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func buttonSetThemColor(_ bgColor:String, selectColor:String, size:CGSize) {
        self.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: bgColor), size: size), for: UIControlState())
        self.setBackgroundImage(UIImage.init(color: UIColor.init(hexString: selectColor), size: size), for: .highlighted)
    }
    
    func buttonSetTitleColor(_ nTitleColor:String, sTitleColor:String?) {
        self.setTitleColor(UIColor.init(hexString: nTitleColor), for: UIControlState())
        if sTitleColor == nil {
            self.setTitleColor(UIColor.init(hexString: UIColor.init(hexString: App_Theme_FFFFFF_Color)), for: .highlighted)
        }else{
            self.setTitleColor(UIColor.init(hexString: sTitleColor), for: .highlighted)
        }
    }
    
    func buttonSetImage(_ nImage:UIImage, sImage:UIImage) {
        self.setImage(nImage, for: UIControlState())
        self.setImage(sImage, for: .selected)
        self.setImage(sImage, for: .highlighted)
    }
    
    func verticalImageAndTitle(spacing:CGFloat) {
        let imageSize = self.imageView?.frame.size
        var titleSize = self.titleLabel?.frame.size
        let textSize = (self.titleLabel?.text as! NSString).size(with: self.titleLabel?.font, constrainedToWidth: 0)
        let frameSize = CGSize.init(width: textSize.width, height: textSize.height)
        if (titleSize?.width)! + 0.5 < frameSize.width {
            titleSize?.width = frameSize.width
        }
        let totalHeight = (imageSize?.height)! + (titleSize?.height)! + spacing
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - (imageSize?.height)!), 0.0, 0.0, -(titleSize?.width)!)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize?.width)!, -(totalHeight - (titleSize?.height)!), 0)
    }
}
