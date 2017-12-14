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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.setUpView()
    }
    
    func setUpView(){
        myCoins = CustomViewButton.init(frame: CGRect.init(x: 29, y: 40, width: 90, height: 96), title: "我的娃娃币", image: UIImage.init(named: "coins")!, tag:1)
        self.setUpSingTap(myCoins)
        self.contentView.addSubview(myCoins)
        
        let myMoppet = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH / 2  - 45, y: 40, width: 90, height: 96), title: "抓到的娃娃", image: UIImage.init(named: "mine_joys")!, tag:2)
        self.setUpSingTap(myMoppet)
        self.contentView.addSubview(myMoppet)
        
        let top = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH - 90 - 29, y: 40, width: 90, height: 96), title: "7日大神榜", image: UIImage.init(named: "top")!, tag:3)
        self.setUpSingTap(top)
        self.contentView.addSubview(top)
        
        let myCode = CustomViewButton.init(frame: CGRect.init(x: 29, y: 168, width: 90, height: 96), title: "邀请兑换", image: UIImage.init(named: "invite")!, tag:4)
        self.setUpSingTap(myCode)
        self.contentView.addSubview(myCode)
        
        
        let myQuestion = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH / 2 - 45, y: 168, width: 90, height: 96), title: "问题反馈", image: UIImage.init(named: "question")!, tag:5)
        self.setUpSingTap(myQuestion)
        self.contentView.addSubview(myQuestion)
        
        let contactUs = CustomViewButton.init(frame: CGRect.init(x: SCREENWIDTH - 90 - 29, y: 168, width: 90, height: 96), title: "关于我们", image: UIImage.init(named: "contact")!, tag:6)
        self.setUpSingTap(contactUs)
        self.contentView.addSubview(contactUs)
        
        version = UILabel.init()
        version.text = "抓我 iPhone版v \(APPVERSION)"
        version.font = App_Theme_PinFan_R_12_Font
        version.textAlignment = .center
        version.textColor = UIColor.init(hexString: App_Theme_A0A0A0_Color)
        self.contentView.addSubview(version)
        
        self.updateConstraints()
    }
    
    func setUpSingTap(_ view:CustomViewButton) {
        let sinGleTap = UITapGestureRecognizer.init(target: self, action: #selector(MineToolsTableViewCell.siglePress(_:)))
        sinGleTap.numberOfTapsRequired = 1
        sinGleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(sinGleTap)
    }
    
    @objc func siglePress(_ tag:UITapGestureRecognizer) {
        let viewTag = tag.view?.tag
        if self.customViewButtonClouse != nil {
            self.customViewButtonClouse(viewTag!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            let bottom = IPHONEX ? 18 : 15
            version.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.contentView.snp.centerX).offset(0)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-bottom)
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
