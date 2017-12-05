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
        GLoabelViewLabel.addLabel(label: label, view: self)
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
            make.top.equalTo(self.userName.snp.bottom).offset(8)
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

extension ProfileViewModel : UIPickerViewDelegate {
    // returns width of column and height of row for each component.
    //    @available(iOS 2.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    //    
    //    @available(iOS 2.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    //    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return  (self.addressDic[row] as! NSDictionary).object(forKey: "name") as? String
        }else if component == 1 {
            return (((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[row] as! NSDictionary).object(forKey: "name") as? String
        }
        return (((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray)[row] as! NSDictionary).object(forKey: "name") as? String
    }
    
    //    @available(iOS 6.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attributed title is favored if both methods are implemented
    
    //     func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectProvince = row
            selectCity = 0
            selectRegion = 0
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        }else if component == 1 {
            selectCity = row
            selectRegion = 0
            pickerView.reloadComponent(2)
        }else{
            selectRegion = row
        }
    }
}

extension ProfileViewModel : UIPickerViewDataSource {
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return addressDic.count
        }else if component == 1 {
            return ((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray).count
        }else {
            return ((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray).count
        }
    }
}
