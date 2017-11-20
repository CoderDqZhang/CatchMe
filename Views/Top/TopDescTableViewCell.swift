//
//  TopDescTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopDescTableViewCell: UITableViewCell {

    var titleLable:UILabel!
    var timeLable:UILabel!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLable = UILabel.init()
        titleLable.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        titleLable.font = App_Theme_PinFan_M_14_Font
        titleLable.textAlignment = .center
        titleLable.text = "七日大神榜"
        self.contentView.addSubview(titleLable)
        
        timeLable = UILabel.init()
        timeLable.textColor = UIColor.init(hexString: App_Theme_666666_Color)
        timeLable.font = App_Theme_PinFan_R_14_Font
        timeLable.textAlignment = .center
        timeLable.text = "第64周 11.06~11.12"
        self.contentView.addSubview(timeLable)
        
        self.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLable.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView.snp.top).offset(16)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
            })
            timeLable.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(2)
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
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
