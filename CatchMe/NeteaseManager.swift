//
//  NeteaseManager.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import NIMSDK

class NeteaseManager: NSObject {

    override init() {
        super.init()
        NIMSDK.shared().loginManager.add(self)
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
}
