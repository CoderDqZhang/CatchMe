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
    var rightImage:UIImageView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
    }
    
    func setUpView(){
        numberLable = UILabel.init()
        numberLable.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        numberLable.font = App_Theme_PinFan_R_21_Font
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
        
        rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "arrow")
        self.addSubview(rightImage)
    
        self.updateConstraints()
    }

    func cellSetData(indexPath:IndexPath, model:GameStatistic){
        numberLable.text = "\(model.rank!)"
        userName.text = model.name
        UIImageViewManger.sd_imageView(url: model.photo is String ? model.photo as! String : "", imageView: avaterImage, placeholderImage: UIImage.init(named: "默认头像_1")) { (image, error, cacheType, url) in
            
        }
        numberCache.text = "\(model.count!)"
        switch indexPath.row {
        case 2:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_FFC107_Color))
            avaterBack.image = UIImage.init(named: "crown_1")
            medalImage.image = UIImage.init(named: "medal_1")
            userName.font = App_Theme_PinFan_M_17_Font
            medalImage.isHidden = false
            avaterBack.isHidden = false
        case 3:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_AAAAAA_Color))
            avaterBack.image = UIImage.init(named: "crown_2")
            medalImage.image = UIImage.init(named: "medal_2")
            userName.font = App_Theme_PinFan_M_17_Font
            medalImage.isHidden = false
            avaterBack.isHidden = false
        case 4:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_FC4652_Color))
            avaterBack.isHidden = false
            avaterBack.image = UIImage.init(named: "crown_3")
            medalImage.image = UIImage.init(named: "medal_3")
            userName.font = App_Theme_PinFan_M_17_Font
            medalImage.isHidden = false
            numberLable.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(30)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
            })
            
            avaterBack.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(52)
                make.top.equalTo(self.contentView.snp.top).offset(4)
                make.size.equalTo(CGSize.init(width: 56, height: 46))
            })
            
            avaterImage.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
                make.size.equalTo(CGSize.init(width: 70, height: 70))
                make.left.equalTo(self.contentView.snp.left).offset(57)
            })
            
            userName.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
                make.left.equalTo(self.avaterImage.snp.right).offset(13)
            })
            
            medalImage.snp.remakeConstraints({ (make) in
                make.left.equalTo(self.userName.snp.right).offset(3)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
            })
            
            numberCache.snp.remakeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(2)
                make.right.equalTo(self.contentView.snp.right).offset(-49)
            })
            
            rightImage.snp.remakeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(2)
                make.right.equalTo(self.snp.right).offset(-30)
            }
        default:
            self.setUpViewsColor(color: UIColor.init(hexString: App_Theme_333333_Color))
            avaterBack.isHidden = true
            userName.font = App_Theme_PinFan_R_17_Font
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
                make.left.equalTo(self.contentView.snp.left).offset(52)
                make.top.equalTo(self.contentView.snp.top).offset(5)
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
                make.right.lessThanOrEqualTo(self.contentView.snp.right).offset(-63)
            })
            
            medalImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.userName.snp.right).offset(3)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            
            numberCache.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-49)
            })
            
            rightImage.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.right.equalTo(self.snp.right).offset(-30)
            }
            
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
