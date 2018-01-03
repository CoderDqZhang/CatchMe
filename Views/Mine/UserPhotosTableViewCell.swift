//
//  UserPhotosTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 30/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import YYWebImage

typealias UserPhotosTableViewCellClouse = (_ tag:Int, _ view:UIView?) ->Void

class UserPhotosTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var descLabel:UILabel!
    
    var addButton:UIButton!
    var userPhotosTableViewCellClouse:UserPhotosTableViewCellClouse!
    
    var didMakeConstraints = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: App_Theme_F2F2F2_Color)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "TA的相册"
        titleLabel.font = App_Theme_PinFan_R_16_Font
        titleLabel.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.contentView.addSubview(titleLabel)
        
        descLabel = UILabel.init()
        descLabel.text = "点击更换或删除照片 共4张"
        descLabel.font = App_Theme_PinFan_R_13_Font
        descLabel.textColor = UIColor.init(hexString: App_Theme_737373_Color)
        self.contentView.addSubview(descLabel)
        
        addButton = UIButton.init(type: .custom)
        addButton.setImage(UIImage.init(named: "add_photo"), for: .normal)
        self.contentView.addSubview(addButton)
        
        self.updateConstraints()
    }
    
    func setData(imageUrls:NSMutableArray, isOwn:Bool){
        var maxX:CGFloat = 20
        for i in 0...imageUrls.count - 1 {
            let frame = CGRect.init(x: maxX, y: 38, width: (SCREENWIDTH - 40 - 13 * 3)/4, height: (SCREENWIDTH - 40 - 13 * 3)/4)
            let imageView = UIImageView.init()
            imageView.tag = i
            imageView.layer.cornerRadius = 5
            imageView.layer.masksToBounds = true
            imageView.frame = frame
            let singTap = UITapGestureRecognizer.init(target: self, action: #selector(self.imageClick))
            singTap.numberOfTapsRequired = 1
            singTap.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(singTap)
            imageView.isUserInteractionEnabled = true
            maxX = maxX + (SCREENWIDTH - 40 - 13 * 3)/4 + 13
            imageView.yy_setImage(with: URL.init(string: imageUrls[i] as! String), placeholder: nil, options: YYWebImageOptions.allowBackgroundTask, completion: { (image, url, tyoe, stage, error) in
                
            })
        
            self.contentView.addSubview(imageView)
        }
        if isOwn {
            if imageUrls.count == 4 {
                addButton.isHidden = true
            }else{
                addButton.isHidden = false
                addButton.snp.updateConstraints({ (make) in
                    make.left.equalTo(self.contentView.snp.left).offset(maxX)
                })
            }
        }else{
            addButton.isHidden = true
        }
    }
    
    @objc func imageClick(tag:UITapGestureRecognizer){
        let viewTag = tag.view?.tag
        if self.userPhotosTableViewCellClouse != nil {
            self.userPhotosTableViewCellClouse(viewTag!, tag.view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.top.equalTo(self.contentView.snp.top).offset(6)
            })
            descLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView.snp.right).offset(-20)
                make.top.equalTo(self.contentView.snp.top).offset(9)
            })
            addButton.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView.snp.left).offset(20)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                make.size.equalTo(CGSize.init(width: (SCREENWIDTH - 40 - 13 * 3)/4, height: (SCREENWIDTH - 40 - 13 * 3)/4))
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
