//
//  SelectMuchView.swift
//  CatchMe
//
//  Created by Zhang on 31/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
typealias SelectMuchViewClouse = (_ much:String) ->Void
class SelectMuchView: UIView {

    var backView:UIView!
    
    var detailView:UIView!
    var topImage:UIImageView!
    var scrollerView:UIScrollView!
    var titleLable:UILabel!
    var descLable:UILabel!
    var muchLable:UILabel!
    var muchDescLable:UILabel!
    
    var closeButton:UIButton!
    
    var titleLabel:UILabel!
    var descLabels:UILabel!
    var muchDesc:UILabel!
    
    var start:Int = 0
    var end:Int = 100
    
    var selectMuchViewClouse:SelectMuchViewClouse!
    init(title:String, desc:String?, much:String, image:UIImage?,start:Int, end:Int, clickClouse:SelectMuchViewClouse!) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        self.start = start
        self.end = end
        self.backgroundColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.7)
        self.selectMuchViewClouse = clickClouse
        backView = UIView.init()
        self.addSubview(backView)
        
        detailView = UIView.init()
        detailView.layer.cornerRadius = 10
        detailView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        backView.addSubview(detailView)
        
        detailView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.centerY.equalTo(self.snp.centerY).offset(-30)
            make.size.equalTo(CGSize.init(width: 240, height: 230))
        }
        
        topImage = UIImageView.init()
        topImage.image = UIImage.init(named: "叶子")
        backView.addSubview(topImage)
        topImage.snp.makeConstraints { (make) in
            make.top.equalTo(detailView.snp.top).offset(-19)
            make.left.equalTo(detailView.snp.left).offset(-17)
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = App_Theme_PinFan_M_18_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        UILabel.changeLineSpace(for: titleLabel, withSpace: 4)
        titleLabel.textAlignment = .center
        detailView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
            make.top.equalTo(detailView.snp.top).offset(16)
        }
        
        descLabels = UILabel.init()
        descLabels.font = App_Theme_PinFan_R_12_Font
        descLabels.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        descLabels.text = desc
        descLabels.numberOfLines = 0
        UILabel.changeLineSpace(for: titleLabel, withSpace: 4)
        descLabels.textAlignment = .center
        detailView.addSubview(descLabels)
        
        descLabels.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        let leftLabel = self.createLabel()
        detailView.addSubview(leftLabel)
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.detailView.snp.left).offset(-9)
            make.size.equalTo(CGSize.init(width: 18, height: 18))
            make.top.equalTo(self.detailView.snp.top).offset(162)
        }
        
        let rightLabel = self.createLabel()
        detailView.addSubview(rightLabel)
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.detailView.snp.right).offset(9)
            make.size.equalTo(CGSize.init(width: 18, height: 18))
            make.top.equalTo(self.detailView.snp.top).offset(26)
        }
        
        
        muchLable = UILabel.init()
        muchLable.font = App_Theme_PinFan_M_36_Font
        muchLable.textColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        muchLable.text = much
        muchLable.numberOfLines = 0
        UILabel.changeLineSpace(for: muchLable, withSpace: 4)
        muchLable.textAlignment = .center
        detailView.addSubview(muchLable)
        
        muchLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
            make.top.equalTo(descLabels.snp.bottom).offset(16)
        }
        
        muchDesc = UILabel.init()
        muchDesc.font = App_Theme_PinFan_R_12_Font
        muchDesc.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        muchDesc.text = "抓币/分"
        muchDesc.numberOfLines = 0
        muchDesc.textAlignment = .center
        detailView.addSubview(muchDesc)
        
        muchDesc.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.detailView.snp.centerX).offset(0)
            make.top.equalTo(muchLable.snp.bottom).offset(2)
        }
        
        muchDescLable = UILabel.init()
        muchDescLable.font = App_Theme_PinFan_R_12_Font
        muchDescLable.textColor = UIColor.init(hexString: App_Theme_9E9E9E_Color)
        muchDescLable.text = "1个小时赚60，够玩两次哦"
        muchDescLable.numberOfLines = 0
        muchDescLable.textAlignment = .center
        detailView.addSubview(muchDescLable)
        muchDescLable.snp.makeConstraints { (make) in
            make.bottom.equalTo(detailView.snp.bottom).offset(-19)
            make.centerX.equalTo(detailView.snp.centerX).offset(0)
        }
        
        
        
        
        closeButton = AnimationButton.init(frame: CGRect.zero)
        closeButton.setImage(UIImage.init(named: "close_home"), for: .normal)
        closeButton.reactive.controlEvents(.touchUpInside).observe { (btn) in
            self.removeSelf()
        }
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(detailView.snp.bottom).offset(19)
            make.centerX.equalTo(self.snp.centerX).offset(0)
        }
        
        scrollerView = UIScrollView.init(frame: CGRect.init(x: (SCREENWIDTH - 196) / 2, y: (SCREENHEIGHT / 2) + 10, width: 196, height: 27))
        scrollerView.delegate = self
        for i in 0...20 {
            let line = GloabLineView.init(frame: CGRect.init(x: i * 15 + 196 / 2, y: 0, width: 1, height: 27))
            line.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
            scrollerView.addSubview(line)
        }
        self.addSubview(scrollerView)
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.contentSize = CGSize.init(width: 496, height: 27)
        
        let lineLabel = GloabLineView.init(frame: CGRect.init(x: SCREENWIDTH / 2 - 1, y: (SCREENHEIGHT / 2) + 4, width: 2, height: 38))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_FC4F5E_Color))
        self.addSubview(lineLabel)
        
        self.updateConstraintsIfNeeded()
    }
    
    func removeSelf(){
        scrollerView.isHidden = true
        AnimationTools.shareInstance.removeViewAnimation(view: self.detailView, finish: {_ in
            if self.selectMuchViewClouse != nil {
                self.selectMuchViewClouse(self.muchLable.text!)
            }
            self.removeFromSuperview()
        })
    }
    
    
    func createLabel() ->UILabel {
        let label = UILabel.init()
        label.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectMuchView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.muchLable.text = "\((start + (end - start) * Int(scrollView.contentOffset.x) / 300 ))"
        muchDescLable.text = "1个小时赚\((start + (end - start) * Int(scrollView.contentOffset.x) / 300) * 60)，够玩\(((start + (end - start) * Int(scrollView.contentOffset.x) / 300) * 60) / 49)次哦"
    }
}
