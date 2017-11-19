//
//  ShareManager.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ShareManager: NSObject {

    override init() {
        super.init()
        WXApi.registerApp(WeiXinAppID)
        WeiboSDK.registerApp(WeiboApiKey)
        WeiboSDK.enableDebugMode(true)
    }
    
    
}
