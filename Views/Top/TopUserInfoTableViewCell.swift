//
//  TopUserInfoTableViewCell.swift
//  
//
//  Created by Zhang on 20/11/2017.
//

import UIKit

class TopUserInfoTableViewCell: UITableViewCell {

    var numberLable:UILabel!
    var avaterImage:UIImageView!
    var avaterBack:UIImageView!
    var userName:UILabel!
    var medalImage:UIImageView!
    var numberCache:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        numberLable = UILabel.init()
        numberLable.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        numberLable.font = App_Theme_PinFan_M_21_Font
        self.contentView.addSubview(numberLable)
        
        avaterBack = UIImageView.init()
        self.contentView.addSubview(avaterBack)
        
        avaterImage = UIImageView.init()
        avaterImage.layer.cornerRadius = 35
        avaterImage.layer.masksToBounds = true
        self.contentView.addSubview(avaterImage)
        
        medalImage = UIImageView.init()
        self.contentView.addSubview(medalImage)
        
        userName = UILabel.init()
        userName.text = "北京小风子"
        userName.font = App_Theme_PinFan_M_17_Font
        self.contentView.addSubview(userName)
        
        numberCache = UILabel.init()
        numberCache.text = "109"
        numberCache.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        numberCache.font = App_Theme_PinFan_M_28_Font
        self.contentView.addSubview(numberCache)
        
        self.updateConstraints()
    }
    
    func cellSetData(indexPath:IndexPath, model:GameStatistic){
        let numberText = indexPath.row - 1
        numberLable.text = "\(numberText)"
        userName.text = model.name
        UIImageViewManger.shareInstance.sd_imageView(url: model.photo is String ? model.photo as! String : "", imageView: avaterImage, placeholderImage: nil) { (image, error, cacheType, url) in
            
        }
        numberCache.text = "\(model.count!)"
        switch indexPath.row {
        case 2:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_FFC107_Color))
            avaterBack.image = UIImage.init(named: "crown_1")
            medalImage.image = UIImage.init(named: "medal_1")
            medalImage.isHidden = false
        case 3:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_AAAAAA_Color))
            avaterBack.image = UIImage.init(named: "crown_2")
            medalImage.image = UIImage.init(named: "medal_2")
            medalImage.isHidden = false
        case 4:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_FC4652_Color))
            avaterBack.image = UIImage.init(named: "crown_3")
            medalImage.image = UIImage.init(named: "medal_3")
            medalImage.isHidden = false
        default:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_333333_Color))
            medalImage.isHidden = true
        }
    }
    
    func setUpViewsColor(color:UIColor) {
        userName.textColor = color
        avaterImage.backgroundColor = color
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            numberLable.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(30)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            avaterBack.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(53)
                make.top.equalTo(self.contentView.snp.top).offset(10)
                make.size.equalTo(CGSize.init(width: 56, height: 46))
            })
            
            avaterImage.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 70, height: 70))
                make.left.equalTo(self.contentView.snp.left).offset(57)
            })
            
            userName.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.avaterImage.snp.right).offset(13)
            })
            
            medalImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.userName.snp.right).offset(3)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 9, height: 9))
            })
            
            numberCache.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-29)
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
