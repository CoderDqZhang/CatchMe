//
//  NeteaseManager.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import NIMSDK
import MBProgressHUD

class NeteaseManager: NSObject {

    var loginHud:MBProgressHUD!
    
    override init() {
        super.init()
        NIMSDK.shared().loginManager.add(self)
        self.registerAPPKey()
    }
    
    static let shareInstance = NeteaseManager.init()
    
    func registerAPPKey(){
        let options = NIMSDKOption.init(appKey: WANGYIIMAPPKEY)
        NIMSDK.shared().register(with: options)
        NIMSDKConfig.shared().enabledHttpsForInfo = true
    }
    
    deinit {
        NIMSDK.shared().loginManager.remove(self)
    }
    
    func setAutoLogin(){
        let loginData = NIMAutoLoginData.init()
        loginData.token = UserInfoModel.shareInstance().neteaseToken!
        loginData.account = UserInfoModel.shareInstance().neteaseAccountId!
        NIMSDK.shared().loginManager.autoLogin(loginData)
    }
}

extension NeteaseManager : NIMLoginManagerDelegate {
    func onMultiLoginClientsChanged() {
        
    }
    
    func onKick(_ code: NIMKickReason, clientType: NIMLoginClientType) {
        var str = ""
        switch code {
        case .byClient:
            str = "被另外一个客户端踢下线"
        case .byServer:
            str = "被服务器踢下线"
        default:
            str = "手动选择下线"
        }
        _  = Tools.shareInstance.showMessage(KWINDOWDS(), msg: str, autoHidder: true)
    }
    
    //网易登录步骤
    func onLogin(_ step: NIMLoginStep) {
//        if loginHud == nil {
////            loginHud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: nil)
//        }
//        var str = ""
//        switch step {
//        case .linking:
//            str = "连接服务器"
//        case .linkOK:
//            str = "连接服务器成功"
//        case .linkFailed:
//            str = "连接服务器失败"
//            loginHud.label.text = str
//            loginHud.hide(animated: true)
//        case .logining:
//            str = "登录中..."
//        case .loginOK:
//            str = "登录成功"
//        case .loseConnection:
//            str = "连接断开"
//            loginHud.label.text = str
//            loginHud.hide(animated: true)
//        default:
//            break
//        }
//        loginHud.label.text = str
//        if step == .loginOK {
//            loginHud.hide(animated: true)
//            Notification(LoginStatuesChange, value: nil)
//            KWINDOWDS().rootViewController = MainTabBarViewController()
//        }
    }
    
    //自动登录失败回调
    func onAutoLoginFailed(_ error: Error) {
        _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "自动登录失败", autoHidder: true)
        if loginHud != nil {
            loginHud.hide(animated: true)
        }
    }
}

