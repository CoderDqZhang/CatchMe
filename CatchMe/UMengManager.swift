//
//  UMengManager.swift
//  CatchMe
//
//  Created by Zhang on 18/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class UMengManager: NSObject {

    override init() {
        super.init()
    }
    static let shareInstance = UMengManager()
    
    func setUpUMengManger(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        UMConfigure.initWithAppkey(UMENGAPPKEY, channel: "App Store")
        //设置加密
        UMConfigure.setEncryptEnabled(true)
        //设置点对点
        MobClick.setScenarioType(.E_UM_NORMAL)
        
        if UserInfoModel.isLoggedIn() {
            MobClick.profileSignIn(withPUID: UserInfoModel.shareInstance().idField)
        }else{
            MobClick.profileSignIn(withPUID: "UserNoLogin")
        }
        
    }
    
}
