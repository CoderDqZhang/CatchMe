//
//  SendJoyInfoTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SendJoyInfoTableViewCell: UITableViewCell {

    var selectImage:UIImageView!
    var joyImageView:UIImageView!
    var joyName:UILabel!
    var joyNumber:UILabel!
    
    var lineLabel:GloabLineView!
    var isSelect:Bool = true
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.changeSelectData(isSelect: self.isSelect)
    }
    
    func setUpView(){
        selectImage = UIImageView.init()
        self.contentView.addSubview(selectImage)
        
        joyImageView = UIImageView.init()
        self.contentView.addSubview(joyImageView)
        
        joyName = UILabel.init()
        joyName.text = "布朗变身长颈鹿"
        joyName.textColor = UIColor.init(hexString: App_Theme_232326_Color)
        joyName.font = App_Theme_PinFan_M_15_Font
        self.contentView.addSubview(joyName)
        
        joyNumber = UILabel.init()
        joyNumber.text = "x1"
        joyNumber.textColor = UIColor.init(hexString: App_Theme_666666_Color)
        joyNumber.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(joyNumber)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 20, y: 89.5, width: SCREENWIDTH - 20, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func changeSelectData(isSelect:Bool){
        self.isSelect = isSelect
        if isSelect {
            selectImage.image = UIImage.init(named: "check")
        }else{
            selectImage.image = UIImage.init(named: "uncheck")
        }
        self.updateConstraintsIfNeeded()
    }
    
    func cellSetData(model:MyCatchDollsModel, count:Int){
        joyName.text = model.name
        UIImageViewManger.sd_imageView(url: model.images[0], imageView: joyImageView, placeholderImage: nil) { (image, error, cacheType, url) in
            
        }
        joyNumber.text = "x\(count)"
    }
    
    func hidderLineLabel(){
        self.lineLabel.isHidden  = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            selectImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(20)
                make.size.equalTo(CGSize.init(width: 20, height: 20))
                make.centerY.equalTo(self.snp.centerY).offset(0)
            })
            
            joyImageView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(58)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 70, height: 70))
            })
            
            joyName.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.joyImageView.snp.right).offset(8)
            })
            
            joyNumber.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-18)
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
