//
//  FilterAgeTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 05/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class FilterAgeTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var didMakeConstraints = false
    var rangeSliderCustom:RangeSeekSlider!
    var setUpViewComplet = false
    var lineLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "年龄"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        textLabel?.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        rangeSliderCustom = RangeSeekSlider.init(frame: CGRect.zero)
        rangeSliderCustom.delegate = self
        rangeSliderCustom.handleImage = UIImage.init(color: UIColor.init(hexString: App_Theme_FC4652_Color), size: CGSize.init(width: 40, height: 40))
        rangeSliderCustom.selectedHandleDiameterMultiplier = 1.0
        rangeSliderCustom.colorBetweenHandles = UIColor.init(hexString: App_Theme_FC4652_Color)
        rangeSliderCustom.lineHeight = 5.0
        rangeSliderCustom.addTarget(self, action: #selector(self.slideViewChange), for: UIControlEvents.valueChanged)
        self.contentView.addSubview(rangeSliderCustom)
        
        self.updateConstraints()
    }
    
    @objc func slideViewChange(){
        
    }
    
    func cellSetData(minX:Float, maxX:Float, start:Float){
        if !setUpViewComplet {
            rangeSliderCustom.minValue = CGFloat(minX)
            rangeSliderCustom.maxValue = CGFloat(maxX)
            rangeSliderCustom.selectedMinValue = CGFloat(minX)
            rangeSliderCustom.selectedMaxValue = CGFloat(maxX)
            setUpViewComplet = true
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(20)
                make.top.equalTo(self.snp.top).offset(20)
            })
            
            rangeSliderCustom.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(20)
                make.right.equalTo(self.snp.right).offset(-20)
                make.top.equalTo(self.snp.top).offset(40)
            })
            
            didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

extension FilterAgeTableViewCell : RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
    }
}
