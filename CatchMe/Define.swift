//
//  Define.swift
//  LiangPiao
//
//  Created by Zhang on 28/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import SwifterSwift

let IPHONE_VERSION:Int = (UIDevice.current.systemVersion as! NSString).integerValue
let IPHONE_VERSION_LAST9 = IPHONE_VERSION >= 9 ? true:false
let IPHONE_VERSION_LAST10 = IPHONE_VERSION >= 10 ? true:false
let IPHONE_VERSION_MINE11 = IPHONE_VERSION < 11 ? true:false

let IPHONE4 = SCREENHEIGHT == 480 ? true:false
let IPHONE5 = SCREENHEIGHT == 568 ? true:false
let IPHONE6 = SCREENHEIGHT == 667 ? true:false
let IPHONE6P = SCREENWIDTH == 414 ? true:false
let IPHONE7P = SCREENHEIGHT == 736 ? true:false
let IPHONEX = SCREENHEIGHT == 812.0 ? true : false

let IPAD = UIDevice.current.userInterfaceIdiom == .pad ? true : false

let IPHONEWIDTH320 = SCREENWIDTH == 320 ? true:false
let IPHONEWIDTH375 = SCREENWIDTH == 375 ? true:false
let IPHONEWIDTH414 = SCREENWIDTH == 414 ? true:false

let IPHONEXFRAMEHEIGHT:CGFloat = IPHONEX ? 24 : 0 
let IPHONEXTABBARHEIGHT:CGFloat = IPHONEX ? 30 : 0

let SCREENWIDTH = SwifterSwift.screenWidth
let SCREENHEIGHT = SwifterSwift.screenHeight

let AnimationTime = 0.3

let TitleLineSpace:Float = 3.0

let WeiXinPayStatues = "WeiXinPayStatuesChange"
let AliPayStatues = "AliPayStatuesChange"

let APPCONFIGSTATUS = "APPCONFIGSTATUS"

//let DidRegisterRemoteNotification = "DidRegisterRemoteNotification"
//let DidRegisterRemoteURLNotification = "DidRegisterRemoteURLNotification"
//let DidRegisterRemoteDiviceToken = "DidRegisterRemoteDiviceToken"

let WANGYIIMAPPKEY = "04fdcc5868d168349f86a52c04a9d426"

let WeiXinAppID = "wxde874e2be98bd508"
let WeiXinSECRET = ""
let WeiXinCode = "GetWeiXinCode"
let QQAppID = "1106567944"
let QQAppKey = "KEYbSfLwgRaskE6SWyq"

let WeiboApiKey   =    "3220687526"
let WeiboApiSecret =   "97f3d51f3a1017cf54268accf9b83391"
let WeiboRedirectUrl = "http://sns.whalecloud.com/sina2/callback"

let GaoDeApiKey = "36cf817a65c10eff954c24c3a9edcb3d"

let APPPayRejectKey = "*a$10$R39P4ld0e2TqL7fJEHY73OfKLswkYKiLNWi/q9/C9bZMNG0l000sS"

let NotificationPlayMusic = "NotificationPlayMusic"

let ToolViewNotifacationName = "ToolsViewNotification"
let LoginStatuesChange = "LoginStatuesChange"
let ChangeUserInfoData = "ChangeUserInfoData"

let PayStatusChange = "PayStatusChange"
let BlanceNumberChange = "BlanceNumberChange"


let UMENGAPPKEY = "5a110b9a8f4a9d411600095a"

let PGYAPPKEY = "5b3d53cf700a36ad46f07850474fcb14"

let MUISCCOGIF = "MUISCCOGIF"

let APPVERSION = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

let TipString = "抓中机器内任意物品都算成功"
let TipString1 = "主人，向左滑屏可切换摄像头哟~~"

func KWINDOWDS() -> UIWindow{
    let window = UIApplication.shared.keyWindow
    return window!
}

let SHARE_APPLICATION = UIApplication.shared


func AppCallViewShow(_ view:UIView, phone:String) {
    UIAlertController.shwoAlertControl(view.findViewController()!, style: .alert, title: "联系抓我电话客服", message: phone, cancel: "取消", doneTitle: "确定", cancelAction: {
        
        }, doneAction: {
           UIApplication.shared.openURL(URL.init(string: "tel:\(phone)")!)
    })
}

func UserDefaultsSetSynchronize(_ value:AnyObject,key:String) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}



func UserDefaultsGetSynchronize(_ key:String) -> AnyObject{
    if UserDefaults.standard.object(forKey: key) == nil {
        return "nil" as AnyObject
    }
    return UserDefaults.standard.object(forKey: key)! as AnyObject
}

//let COFIGVALUE:Bool = ConfigModel.shanreInstance.isOnlineVersion


func Storyboard(_ name:String,controllerid:String) -> UIViewController{
    return UIStoryboard.init(name: name, bundle: nil).instantiateViewController(withIdentifier: controllerid)
}

func Notification(_ name:String,value:String?) {
    NotificationCenter.default.post(name: Foundation.Notification.Name(rawValue: name), object: value)
}


func NavigationPushView(_ formviewController:UIViewController, toConroller:UIViewController) {
    toConroller.hidesBottomBarWhenPushed = true
    formviewController.navigationController?.pushViewController(toConroller, animated: true)
}

func NavigaiontPresentView(_ formViewController:UIViewController, toController:UIViewController) {
    formViewController.present(toController, animated: true) {
        
    }
}

func MainThreadAlertShow(_ msg:String,view:UIView){
    DispatchQueue.main.async(execute: {
        _ = Tools.shareInstance.showMessage(view, msg: msg, autoHidder: true)
    })
}

func MainThreanShowErrorMessage(_ error:AnyObject){
    if error is NSDictionary {
        DispatchQueue.main.async(execute: {
            _ = Tools.shareInstance.showErrorMessage(error)
        })
    }
}

func MainThreanShowNetWorkError(_ error:AnyObject){
    DispatchQueue.main.async(execute: {
        _ = Tools.shareInstance.showNetWorkError(error)
    })
}



