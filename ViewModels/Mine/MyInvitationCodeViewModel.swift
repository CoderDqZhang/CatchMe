//
//  MyInvitationCodeViewModel.swift
//  CatchMe
//
//  Created by Zhang on 05/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyInvitationCodeViewModel: BaseViewModel {

    var shareCode:String = ""
    override init() {
        super.init()
    }
    
    func requestShareCode(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField,"shareCode":shareCode]
        BaseNetWorke.sharedInstance.postUrlWithString(ShareCodeUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "兑换成功", autoHidder: true)
            }
        }
    }
}
