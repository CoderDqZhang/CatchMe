//
//  Tools.swift
//  LiangPiao
//
//  Created by Zhang on 23/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit
import MBProgressHUD

let HUDBackGroudColor = "000000"
let CustomViewWidth:CGFloat = 190
let CustomViewFont = IPHONE_VERSION > 9 ? UIFont.init(name: ".SFUIText-Medium", size: 17.0):UIFont.init(name: ".HelveticaNeueInterface-Bold", size: 17.0)
let TextLabelMarger:CGFloat = 20

class HUDCustomView: UIView {
    class func customViewWidthMessage(_ message:String) -> AnyObject {
        let customView =  UIView(frame: CGRect.init(x: CGFloat(UIScreen.main.bounds.size.width - CustomViewWidth) / 2, y: (UIScreen.main.bounds.size.height - 60) / 2, width: CustomViewWidth, height: 60))
        let messageHeight = (message as NSString).height(with: CustomViewFont!, constrainedToWidth: CustomViewWidth - TextLabelMarger * 2)
        var frame = customView.frame
        if messageHeight > 60 {
            frame.size.height = messageHeight
            frame.origin.y = (UIScreen.main.bounds.size.height - messageHeight) / 2
        }else{
            frame.size.height = 60;
        }
        customView.frame = frame;
        customView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        customView.addSubview(HUDCustomView.setUpLabel(frame, text: message))
        return customView;
    }
    
    class func setUpLabel(_ frame:CGRect, text:String) -> UILabel{
        let textLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: CustomViewWidth - TextLabelMarger * 2, height: frame.size.height))
        textLabel.font = CustomViewFont
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.white
        textLabel.text = text
        textLabel.textAlignment = .center
        return textLabel;
        
    }
    
    class func getHudMinSize(_ msg:String) ->CGSize {
        let minWidth = (msg as NSString).width(with: CustomViewFont!, constrainedToHeight: 14) + 67
        let minHeigth = (msg as NSString).height(with: CustomViewFont!, constrainedToWidth: minWidth) + 40
        return CGSize(width: minWidth, height: minHeigth)
    }
}

class Tools: NSObject {

    
    override init() {
        
    }
    
    static let shareInstance = Tools()
    
    func showLoading(_ view:UIView, msg:String?) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.bezelView.backgroundColor = UIColor.init(hexString: HUDBackGroudColor, andAlpha: 1)
        hud.bezelView.layer.cornerRadius = 12.0
        if msg != nil {
            hud.label.text = msg
            hud.label.numberOfLines = 0;
            hud.label.textColor = UIColor.white
            hud.label.font = CustomViewFont;
        }
        return hud
    }
    
    func hiddenLoading(hud:MBProgressHUD) {
        hud.hide(animated: true)
    }
    
    func showMessage(_ view:UIView, msg:String, autoHidder:Bool) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView
        hud.bezelView.backgroundColor = UIColor.init(hexString: HUDBackGroudColor, andAlpha: 1)
        hud.bezelView.layer.cornerRadius = 12.0
        hud.label.numberOfLines = 0;
        hud.label.textColor = UIColor.white
        hud.label.font = CustomViewFont;
        hud.minSize = HUDCustomView.getHudMinSize(msg)
        hud.label.text = msg;
        hud.bezelView.layer.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        hud.hide(animated: true, afterDelay: 2.0)
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        return hud
    }
    
    func showErrorMessage(_ errorDic:AnyObject) ->MBProgressHUD? {
        if (errorDic is NSDictionary) {
            if (errorDic as! NSDictionary).object(forKey: "message") != nil {
                return self.showMessage(KWINDOWDS(), msg:(errorDic as! NSDictionary).object(forKey: "message") as! String , autoHidder: true)
            }else{
                return self.showMessage(KWINDOWDS(), msg:"网络服务错误" , autoHidder: true)
            }
        }else{
            return self.showMessage(KWINDOWDS(), msg:"网络服务错误" , autoHidder: true)
        }
    }
    
    func showNetWorkError(_ error:AnyObject) ->MBProgressHUD {
        let netWorkError = (error as! NSError)
        print(netWorkError)
        return self.showMessage(KWINDOWDS(), msg:netWorkError.localizedDescription , autoHidder: true)
    }
    
    func showAliPathError(_ error:String) ->MBProgressHUD {
        return self.showMessage(KWINDOWDS(), msg: error, autoHidder: true)
    }
    
   
}
