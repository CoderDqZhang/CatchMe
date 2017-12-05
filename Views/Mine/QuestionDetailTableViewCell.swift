//
//  QuestionDetailTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class QuestionDetailTableViewCell: UITableViewCell {

    var textView:UITextView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        textView = UITextView.init()
        textView.placeholder = "一起聊聊抓我吧"
        textView.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        textView.placeholderColor = UIColor.init(hexString: App_Theme_888888_Color)
        textView.font = App_Theme_PinFan_R_16_Font
        self.contentView.addSubview(textView)
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            textView.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                 make.right.equalTo(self.contentView.snp.right).offset(-20)
                 make.top.equalTo(self.contentView.snp.top).offset(16)
                 make.bottom.equalTo(self.contentView.snp.bottom).offset(-16)
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
