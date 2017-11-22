//
//  LoginViewModel.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MJExtension
import NIMSDK
import MBProgressHUD

class LoginViewModel: BaseViewModel {
    
    var loginHud:MBProgressHUD!
    
    override init() {
        super.init()
        NIMSDK.shared().loginManager.add(self)
    }
    
    func requestLoginCode(_ number:String){
        let dic = ["phone":number]
        BaseNetWorke.sharedInstance.getUrlWithString(LoginCode, parameters: dic as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let aMinutes:TimeInterval = 60
                (self.controller as! LoginViewController).startWithStartDate(NSDate() as Date, finishDate: NSDate.init(timeIntervalSinceNow: aMinutes) as Date)
            }
        }
    }
    
    func requestLogin(_ form:LoginForm) {
        let dic = ["telephone":form.phone, "verifyCode":form.code]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginUrl, parameters: dic as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                UserDefaultsSetSynchronize(form.phone as AnyObject, key: "telephone")
                let model = UserInfoModel.mj_object(withKeyValues: resultDic.value)
                model?.saveOrUpdate(byColumnName: "telephone", andColumnValue: "'\(form.phone)'")
                self.loginNetNetease()
            }
        }
    }
    
    func loginNetNetease(){
        let loginData = NIMAutoLoginData.init()
        loginData.token = ""
        loginData.account = ""
        loginData.forcedMode = true
        NIMSDK.shared().loginManager.autoLogin(loginData)
    }
    
    func login(){
        
    }
    
//    func savePhotoImage(){
//        if UserInfoModel.shareInstance().avatar != "" {
//            SDWebImageManager.shared().loadImage(with: URL.init(string: UserInfoModel.shareInstance().avatar), options: .retryFailed, progress: { (star, end, url) in
//
//            }) { (image, data, error, cache, finish, url) in
//                if error == nil {
//                    _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
//                }
//            }
//        }
//    }
//
//    func requestAddress(){
//        BaseNetWorke.sharedInstance.getUrlWithString(AddAddress, parameters: nil).observe { (resultDic) in
//            if !resultDic.isCompleted {
//                let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
//                var addressModels:[AddressModel] = []
//                for model in resultModels! {
//                    addressModels.append(AddressModel.init(fromDictionary: model as! NSDictionary))
//                }
//                AddressModel.archiveRootObject(addressModels)
//            }
//        }
//    }
}

extension LoginViewModel : NIMLoginManagerDelegate {
    //网易登录步骤
    func onLogin(_ step: NIMLoginStep) {
        if loginHud == nil {
            loginHud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: nil)
        }
        var str = ""
        switch step {
        case .linking:
            str = "连接服务器"
        case .linkOK:
            str = "连接服务器成功"
        case .linkFailed:
            str = "连接服务器失败"
            loginHud.label.text = str
            loginHud.hide(animated: true)
        case .logining:
            str = "登录中..."
        case .loginOK:
            str = "登录成功"
        case .loseConnection:
            str = "连接断开"
            loginHud.label.text = str
            loginHud.hide(animated: true)
        default:
            break
        }
        loginHud.label.text = str
        if step == .loginOK {
            loginHud.hide(animated: true)
            Notification(LoginStatuesChange, value: nil)
            self.controller?.navigationController?.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    //自动登录失败回调
    func onAutoLoginFailed(_ error: Error) {
         _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "自动登录失败", autoHidder: true)
    }
}

