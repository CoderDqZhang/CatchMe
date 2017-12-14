//
//  ProfileLogoutTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 01/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias ProfileLogoutTableViewCellClouse = () ->Void
class ProfileLogoutTableViewCell: UITableViewCell {

    var logoutView:CustomTouchButton!
    var profileLogoutTableViewCellClouse:ProfileLogoutTableViewCellClouse!
    
    var didMakeConstraints = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    func setUpView(){
        logoutView = CustomTouchButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200)/2, y: 12, width: 200, height: 48), title: "退出登录", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: .withBackBoarder, pressClouse: { (tag) in
            if self.profileLogoutTableViewCellClouse != nil {
                self.profileLogoutTableViewCellClouse()
            }
        })
        self.contentView.addSubview(logoutView)
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
