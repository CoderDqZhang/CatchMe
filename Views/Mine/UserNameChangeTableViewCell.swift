
//
//  UserNameChangeTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 16/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class UserNameChangeTableViewCell: UITableViewCell {

    var textField:UITextField!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        textField = UITextField.init()
        textField.font = App_Theme_PinFan_M_15_Font
        textField.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        textField.placeholder = "输入昵称"
        self.contentView.addSubview(textField)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textField.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.right.equalTo(self.contentView.snp.right).offset(-20)
                make.top.equalTo(self.contentView.snp.top).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(0)
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
