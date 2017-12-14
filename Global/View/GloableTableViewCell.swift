//
//  GloableTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class GloableTableViewCell: NSObject {

}

class GloableTitleLabelTextFieldCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var textField:UITextField!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleLabel.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        textField = UITextField.init()
        textField.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        textField.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(textField)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 23, y: 49.0, width: SCREENWIDTH - 46, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, placeholderStr:String? ,textFieldStr:String?){
        titleLabel.text = title
        if placeholderStr != nil {
            textField.placeholder = placeholderStr
        }
        if textFieldStr != nil {
            textField.text = textFieldStr
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(23)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
            })
            textField.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(90)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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

class GloableMaxTitleLabelTextFieldCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var textView:UITextView!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleLabel.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        textView = UITextView()
        textView.isScrollEnabled = false
        textView.returnKeyType = .done
        textView.placeholderLabel.font = App_Theme_PinFan_R_14_Font
        textView.placeholderLabel.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        textView.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        textView.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(textView)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 23, y: 80.0, width: SCREENWIDTH - 46, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.contentView.addSubview(lineLabel)
        self.updateConstraints()
    }
    
    func cellSetData(title:String, placeholderStr:String? ,textFieldStr:String?){
        titleLabel.text = title
        if placeholderStr != nil {
            textView.placeholder = placeholderStr
        }
        if textFieldStr != nil {
            textView.text = textFieldStr
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(23)
                make.top.equalTo(self.contentView.snp.top).offset(15)
            })
            
            textView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(7)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(90)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
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

class GloableTitleLabelTitleDescCell: UITableViewCell {
    
    var titleLabel:UILabel!
    var titleDesc:UILabel!
    
    var rightImage:UIImageView!
    
    var lineLabel:GloabLineView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleLabel.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        titleDesc = UILabel.init()
        titleDesc.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        titleDesc.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleDesc)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 23, y: 49, width: SCREENWIDTH - 46, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.contentView.addSubview(lineLabel)
        
        rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "arrow")
        self.contentView.addSubview(rightImage)
     
        self.updateConstraints()

    }
    
    func cellSetData(title:String, titleDescStr:String? ){
        titleLabel.text = title
        if titleDescStr != nil {
            titleDesc.text = titleDescStr
        }
    }
    
    func changeTitleDesc(str:String) {
        titleDesc.text = str
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(23)
                make.top.equalTo(self.contentView.snp.top).offset(15)
            })
            
            titleDesc.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(15)
                make.left.equalTo(self.contentView.snp.left).offset(90)
                make.right.equalTo(self.contentView.snp.right).offset(-15)
            })
            
            rightImage.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.right.equalTo(self.snp.right).offset(-20)
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

class GloabTitleAndFieldCell: UITableViewCell {
    var titleLabel:UILabel!
    var textField:UITextField!
    var lineLable:GloabLineView!
    var rightImage:UIImageView!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.contentView.addSubview(titleLabel)
        
        textField = UITextField()
        textField.font = App_Theme_PinFan_R_14_Font
        textField.textAlignment = .right
        textField.tintColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        textField.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        self.contentView.addSubview(textField)
        
        lineLable = GloabLineView(frame: CGRect(x: 20,y: 0,width: SCREENWIDTH - 20, height: 0.5))
        lineLable.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.contentView.addSubview(lineLable)
        
        rightImage = UIImageView.init()
        rightImage.image = UIImage.init(named: "arrow")
        self.addSubview(rightImage)
        
        self.updateConstraintsIfNeeded()
    }
    
    func setTextFieldText(_ text:String) {
        textField.text = text
        textField.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
    }
    
    
    
    func setData(_ title:String, detail:String, laceholder:String) {
        titleLabel.text = title
        textField.text = detail
        textField.attributedPlaceholder = NSAttributedString.init(string: laceholder, attributes: [NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_DDE0E5_Color)!])
        
        
    }
    
    func hideLineLabel() {
        self.lineLable.isHidden = true
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.width.equalTo(70)
            })
            
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.titleLabel.snp.right).offset(24)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-38)
            })
            
            lineLable.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-0.5)
            })
            
            rightImage.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(0)
                make.right.equalTo(self.snp.right).offset(-20)
            }
            
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GloabTitleAndSwitchCell: UITableViewCell {
    var titleLabel:UILabel!
    var switchView:UISwitch!
    
    var didMakeConstraints:Bool = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView() {
        titleLabel = UILabel()
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.contentView.addSubview(titleLabel)
        
        switchView = UISwitch.init()
        switchView.onTintColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        switchView.reactive.controlEvents(.valueChanged).observe { (ret) in
            let str = ret.value!.isOn ? "true" : "false"
            UserDefaultsSetSynchronize(str as AnyObject, key: MUISCCOGIF)
        }
        switchView.tintColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        self.contentView.addSubview(switchView)
        self.updateConstraintsIfNeeded()
    }
    
    func cellSetData(str:String, isOn:Bool){
        titleLabel.text = str
        switchView.isOn = isOn
    }
    
    override func updateConstraints() {
        if !self.didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.width.equalTo(70)
            })
            
            switchView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
            })
        
            self.didMakeConstraints = true
        }
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

