//
//  Gloable+View.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class Gloable_View: NSObject {

}

class GloabLineView: UIView {
    
    let lineLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        lineLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        lineLabel.backgroundColor = UIColor.init(hexString: App_Theme_E9EBF2_Color)
        self.addSubview(lineLabel)
    }
    
    func setLineColor(_ color:UIColor){
        lineLabel.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum CustomButtonType {
    case withNoBoarder
    case withBoarder
    case withBackBoarder
    case widthDisbale
    
}

typealias CustomButtonClouse = (_ tag:NSInteger) -> Void
class CustomButton: UIButton {
    
    init(frame:CGRect, title:String, tag:NSInteger?, titleFont:UIFont, type:CustomButtonType, pressClouse:@escaping CustomButtonClouse) {
        super.init(frame: frame)
        self.setTitle(title, for: UIControlState())
        self.titleLabel?.font = titleFont
        self.layer.masksToBounds = true
        self.frame = frame
        if tag != nil {
            self.tag = tag!
        }
        switch type {
        case .withNoBoarder:
            self.setWithNoBoarderButton()
        case .withBoarder:
            self.layer.cornerRadius = 2.0
            self.setWithBoarderButton()
        case .withBackBoarder:
            self.layer.cornerRadius = 2.0
            self.setwithonBoarderButton()
        default:
            self.layer.cornerRadius = 2.0
            self.setWithDisbleBoarderButton()
        }
        self.reactive.controlEvents(.touchUpInside).observe { (action) in
            if tag != nil {
                self.tag = 1000
            }
            pressClouse(tag!)
        }
    }
    
    func setWithNoBoarderButton(){
        self.buttonSetTitleColor(App_Theme_F94856_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_F94856_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_F94856_Color, sTitleColor: App_Theme_6D4033_Color)
    }
    
    func setWithDisbleBoarderButton(){
        self.layer.borderColor = UIColor.init(hexString: App_Theme_BBC1CB_Color).cgColor
        self.layer.borderWidth = 1.0
        self.buttonSetTitleColor(App_Theme_BBC1CB_Color, sTitleColor: App_Theme_BBC1CB_Color)
    }
    
    func setwithonBoarderButton(){
        self.setTitleColor(UIColor.white, for: UIControlState())
        self.buttonSetThemColor(App_Theme_F94856_Color, selectColor: App_Theme_F94856_Color, size: CGSize.init(width: self.frame.size.width, height: self.frame.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CustomViewButton: UIView {
    
    var imageView:UIImageView!
    var label:UILabel!
    //size = 34+11,34 + 14
    init(frame:CGRect, title:String, image:UIImage, tag:NSInteger?) {
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: CGRect.init(x: 10, y: 0, width: 68, height: 68))
        imageView.image = image
        self.addSubview(imageView)
        
        label = UILabel.init(frame: CGRect.init(x: 0, y: 72, width: frame.size.width, height: 20))
        label.textAlignment = .center
        label.text = title
        label.font = App_Theme_PinFan_R_14_Font
        label.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.isUserInteractionEnabled = true
        self.tag = tag!
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustonPayTypeView: UIView {
    var imageView:UIImageView!
    var lable:UILabel!
    var isSelect:Bool!
    
    init(frame:CGRect, image:UIImage, title:String, isSelect:Bool) {
        super.init(frame: frame)
        imageView = UIImageView.init()
//        imageView.frame = CGRect.init(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
