//
//  BannerCollectionReusableView.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias CyCleScrollerViewClouse = (_ index:Int) -> Void

class BannerCollectionReusableView: UICollectionReusableView {
    
    var cycleScrollView:SDCycleScrollView!
    var cyCleScrollerViewClouse:CyCleScrollerViewClouse!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        if cycleScrollView == nil {
            cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENWIDTH * 162/375), delegate: self, placeholderImage: UIImage.init(named: "Banner_Default_Cover"))
            cycleScrollView.pageDotImage = UIImage.init(named: "banner_normal")
            cycleScrollView.currentPageDotImage = UIImage.init(named: "banner_select")
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            cycleScrollView.pageControlDotSize = CGSize(width: 8, height: 8)
            self.addSubview(cycleScrollView)
            //         --- 轮播时间间隔，默认1.0秒，可自定义
            cycleScrollView.autoScroll = true
            
        }
    }
    
    func setcycleScrollerViewData(_ imageArray:NSArray){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            self.cycleScrollView.imageURLStringsGroup = imageArray as [AnyObject]
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension BannerCollectionReusableView : SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if self.cyCleScrollerViewClouse != nil {
            self.cyCleScrollerViewClouse(index)
        }
    }
}
