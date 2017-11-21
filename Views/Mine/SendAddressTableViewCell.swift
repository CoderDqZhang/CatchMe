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
        label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        label.text = "添加收货人信息"
        label.textAlignment = .center
        label.font = App_Theme_PinFan_M_18_Font
        label.textColor = UIColor.init(hexString: App_Theme_DDDDDD_Color)
        self.addSubview(label)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    
    func setUpView(){
        locationImage = UIImageView.init()
        locationImage.backgroundColor = UIColor.red
        self.addSubview(locationImage)
        locationImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.snp.left).offset(21)
            make.size.equalTo(CGSize.init(width: 18, height: 22))
        }
        
        userName = UILabel.init()
        userName.text = "收货人：张梅"
        userName.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        userName.font = App_Theme_PinFan_M_16_Font
        self.addSubview(userName)
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(52)
            make.top.equalTo(self.snp.top).offset(20)
        }
        
        phone = UILabel.init()
        phone.text = "18363899723"
        phone.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        phone.font = App_Theme_PinFan_M_16_Font
        self.addSubview(phone)
        
        phone.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-43)
            make.top.equalTo(self.snp.top).offset(20)
        }
        
        address = UILabel.init()
        address.numberOfLines = 0
        address.text = "收货地址：北京朝阳区四环到五环之间绿地中心-中国竟20层"
        address.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        address.font = App_Theme_PinFan_R_14_Font
        self.addSubview(address)
        address.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(52)
            make.right.equalTo(self.snp.right).offset(-43)
            make.top.equalTo(self.userName.snp.bottom).offset(7)
        }
        
    }
    
    func setData(model:AddressModel) {
        address.text = "收货地址：\(model.city!)\(model.address!)"
        phone.text = model.phone
        userName.text = "收货人：\(model.userName!)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SendAddressTableViewCell: UITableViewCell {

    var noneAddressView:NoneAddress!
    var addressView:Address!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        addressView = Address.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 104))
        self.contentView.addSubview(addressView)
        addressView.isHidden = true
        
        noneAddressView = NoneAddress.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 104))
        self.contentView.addSubview(noneAddressView)
        
        self.updateConstraints()
    }
    
    func cellSetData(isHaveAddress:Bool,model:AddressModel) {
        addressView.isHidden = !isHaveAddress
        noneAddressView.isHidden = isHaveAddress
        if isHaveAddress {
            addressView.setData(model: model)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
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
