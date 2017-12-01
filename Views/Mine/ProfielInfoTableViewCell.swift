//
//  ProfielInfoTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfielInfoTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var detailLabel:UILabel!
    
    var linLabel:GloabLineView!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "头像"
        titleLabel.font = App_Theme_PinFan_M_15_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.contentView.addSubview(titleLabel)
        
        detailLabel = UILabel.init()
        detailLabel.text = "头像"
        detailLabel.font = App_Theme_PinFan_R_14_Font
        detailLabel.textColor = UIColor.init(hexString: App_Theme_AAAAAA_Color)
        self.contentView.addSubview(detailLabel)
        
//        linLabel = GloabLineView.init(frame: CGRect.init(x: 20, y: 54, width: SCREENWIDTH - 20, height: 0.5))
//        self.contentView.addSubview(linLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(title:String, desc:String){
        titleLabel.text = title
        detailLabel.text = desc
    }
    
    func updateCellDesc(desc:String){
        detailLabel.text = desc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.left.equalTo(self.contentView.snp.left).offset(20)
            })
            
            detailLabel.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.contentView.snp.centerY).offset(0)
                make.right.equalTo(self.contentView.snp.right).offset(-5)
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
