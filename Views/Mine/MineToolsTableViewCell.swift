//
//  MineToolsTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
typealias CustomViewButtonClouse = (_ tag:Int) -> Void

class MineToolsTableViewCell: UITableViewCell {

    var version:UILabel!
    var customViewButtonClouse:CustomViewButtonClouse!
    var didMakeConstraints = false
    var myCoins:CustomViewButton!
    
    var lineLabel:GloabLineView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.setUpView()
    }
    
    func setUpView(){
        
        myCoins = CustomViewButton.init(frame: CGRect.init(x: 29, y: 14, width: 90, height: 96), title: "我的娃娃币", image: UIImage.init(named: "coins")!, tag:1, click:{
            if self.customViewButtonClouse != nil {
                self.customViewButtonClouse(1)
            }
        })
        self.contentView.addSubview(myCoins)
        
        let top = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH / 2  - 45, y: 14, width: 90, height: 96), title: "七日大神榜", image: UIImage.init(named: "top")!, tag:2, click:{
            if self.customViewButtonClouse != nil {
                self.customViewButtonClouse(2)
            }
        })
        self.contentView.addSubview(top)
        
        let myCode = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH - 90 - 29, y: 14, width: 90, height: 96), title: "邀请兑换", image: UIImage.init(named: "invite")!, tag:3, click:{
            if self.customViewButtonClouse != nil {
                self.customViewButtonClouse(3)
            }
        })
        self.contentView.addSubview(myCode)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
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
