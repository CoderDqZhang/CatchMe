//
//  FilterStatusTableViewCell.swift
//  CatchMe
//
//  Created by Zhang on 05/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class FilterStatusTableViewCell: UITableViewCell {

    var titleLabel:UILabel!
    var didMakeConstraints = false
    var lineLabel:GloabLineView!
    var didSetUpView = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.setUpView()
    }
    
    func setUpView(){
        titleLabel = UILabel.init()
        titleLabel.text = "状态"
        titleLabel.textColor = UIColor.init(hexString: App_Theme_DDE0E5_Color)
        textLabel?.font = App_Theme_PinFan_R_14_Font
        self.contentView.addSubview(titleLabel)
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0.5))
        self.contentView.addSubview(lineLabel)
        
        self.updateConstraints()
    }
    
    func cellSetData(array:NSMutableArray, selectItem:Int?){
        if !didSetUpView  {
            for i in 0...array.count - 1 {
                let originX:CGFloat = (20 + CGFloat(i % 3) * (FilterItemViewSpace + FilterItemViewWidth))
                let frame = CGRect.init(x: originX, y: CGFloat(50 + i / 3 * 60), width: FilterItemViewWidth, height: FilterItemViewHeight)
                var itemType:FilterItemViewType = .normal
                if selectItem != nil && selectItem == i {
                    itemType = .select
                }else if i == 0 {
                    itemType = .select
                }
                let item = FilterItemView.init(frame: frame, type: itemType, title: array[i] as! String, tag:i + 1, image: nil, click: { tag in
                    for j in 0...array.count - 1 {
                        let itemView = self.viewWithTag(j + 1) as! FilterItemView
                        if j + 1 == tag {
                            itemView.changeItemType(type: .select)
                        }else{
                            itemView.changeItemType(type: .normal)
                        }
                    }
                })
                item.tag = i + 1
                self.contentView.addSubview(item)
            }
            didSetUpView = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        if !didMakeConstraints {
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(20)
                make.top.equalTo(self.snp.top).offset(20)
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
