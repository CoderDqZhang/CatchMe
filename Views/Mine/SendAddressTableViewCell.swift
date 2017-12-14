//
//  SendAddressTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class NoneAddress: UIView {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel.init(frame: CGRect.init(x: (SCREENWIDTH - 126) / 2, y: 0, width: 126, height: frame.size.height))
        label.text = "添加收货人信息"
        label.textAlignment = .center
        
        label.font = App_Theme_PinFan_M_18_Font
        label.textColor = UIColor.init(hexString: App_Theme_DDDDDD_Color)
        self.addSubview(label)
        GLoabelViewLabel.addLabel(label: label, view: self, isWithNumber: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Address: UIView {
    var locationImage:UIImageView!
    var userName:UILabel!
    var phone:UILabel!
    var address:UILabel!
    var rightImage:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        locationImage = UIImageView.init()
        locationImage.image = UIImage.init(named: "location")
        self.addSubview(locationImage)
        locationImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(21)
        }
        
        userName = UILabel.init()
        userName.text = "收货人：张梅"
        userName.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        userName.font = App_Theme_PinFan_M_16_Font
        self.addSubview(userName)
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(52)
            make.top.equalTo(self.snp.top).offset(23)
        }
        
        phone = UILabel.init()
        phone.text = "18363899723"
        phone.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        phone.font = App_Theme_PinFan_M_16_Font
        self.addSubview(phone)
        
        phone.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-23)
            make.top.equalTo(self.snp.top).offset(23)
        }
        
        address = UILabel.init()
        address.numberOfLines = 0
        address.text = "收货地址：北京朝阳区四环到五环之间绿地中心-中国竟20层"
        address.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        address.font = App_Theme_PinFan_R_14_Font
        self.addSubview(address)
        address.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(52)
            make.right.equalTo(self.snp.right).offset(-23)
            make.top.equalTo(self.userName.snp.bottom).offset(7)
        }
        
        rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "arrow")
        self.addSubview(rightImage)
        rightImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(self.snp.right).offset(-20)
        }
        
    }
    
    func setData(model:AddressModel) {
        let dic = LocalJsonFile.init().fileRead(fileName: "AddressValueKey", type: "txt")!
        let pronvice:String = dic.object(forKey: "\(model.province)") as! String
        let city:String = dic.object(forKey: "\(model.city)") as! String
        let county:String = dic.object(forKey: "\(model.county)") as! String
        address.text = "收货地址：\(pronvice)\(city)\(county)\(model.address!)"
        phone.text = model.telephone
        userName.text = "收货人：\(model.consignee!)"
        UILabel.changeSpace(for: address, withLineSpace: 2, wordSpace: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SendAddressTableViewCell: UITableViewCell {

    var noneAddressView:NoneAddress!
    var addressView:Address!
    var bottomImage:UIImageView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        bottomImage = UIImageView.init()
        bottomImage.image = UIImage.init(named: "Combined_Shape")
        self.contentView.addSubview(bottomImage)
        
        addressView = Address.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 104))
        self.contentView.addSubview(addressView)
        addressView.isHidden = true
        
        noneAddressView = NoneAddress.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 104))
        self.contentView.addSubview(noneAddressView)
        
        self.updateConstraints()
    }
    
    func cellSetData(isHaveAddress:Bool,model:AddressModel?) {
        addressView.isHidden = !isHaveAddress
        noneAddressView.isHidden = isHaveAddress
        if isHaveAddress {
            if model != nil {
                addressView.setData(model: model!)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            didMakeConstraints = true
            bottomImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(30)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
            })
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
