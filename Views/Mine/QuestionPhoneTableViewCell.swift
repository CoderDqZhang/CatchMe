//
//  QuestionPhoneTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class QuestionPhoneTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var textField:UITextField!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "QQ号或手机号"
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        self.contentView.addSubview(titleLabel)
        
        textField = UITextField.init()
        let str = "(选填)"
        textField.keyboardType = .numberPad
        textField.placeholder = str
        textField.attributedPlaceholder = NSAttributedString.init(string: str, attributes: [NSAttributedStringKey.font:App_Theme_PinFan_R_15_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_AAAAAA_Color)!])
        textField.font = App_Theme_PinFan_R_14_Font
        textField.textColor = UIColor.init(hexString: App_Theme_222222_Color)
        self.contentView.addSubview(textField)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.size.equalTo(CGSize.init(width: 100, height: 20))
            })
            
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.titleLabel.snp.right).offset(7)
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
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
