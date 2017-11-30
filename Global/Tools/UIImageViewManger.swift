//
//  UIImageViewManger.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import SDWebImage

typealias DownLoadImageCompletionBlock = (_ image:UIImage?, _ error:Error?, _ url:URL) -> Void


class UIImageViewManger: NSObject {

    class func sd_imageView(url:String, imageView:UIImageView,placeholderImage:UIImage?, completedBlock: SDWebImage.SDExternalCompletionBlock? = nil){
        imageView.sd_setShowActivityIndicatorView(true)
        imageView.sd_setIndicatorStyle(.gray)
        imageView.sd_setImage(with: URL.init(string: url), placeholderImage: placeholderImage, options: .retryFailed, completed: completedBlock)
    }
    
}
