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
        self.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        if cycleScrollView == nil {
            cycleScrollView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: IPHONEWIDTH320 ? 137 : IPHONEWIDTH375 ? 160 : 180), delegate: self, placeholderImage: nil)
            cycleScrollView.pageDotImage = UIImage.init(named: "banner_normal")
            cycleScrollView.currentPageDotImage = UIImage.init(named: "banner_select")
            cycleScrollView.currentPageDotColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            cycleScrollView.pageControlDotSize = CGSize(width: 12, height: 12)
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
