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
    var model:SessionShareModel!
    
    override init() {
        super.init()
        self.getShareCodeInfo()
    }
    
    func requestShareCode(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField,"shareCode":shareCode]
        BaseNetWorke.sharedInstance.postUrlWithString(ShareCodeUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "兑换成功", autoHidder: true)
            }
        }
    }
    
    func getShareCodeInfo(){
        let parameters = ["type":"0"]
        BaseNetWorke.sharedInstance.getUrlWithString(Socialsharecard, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = SessionShareModel.init(fromDictionary: resultDic.value as! NSDictionary)
            }
        }
    }
}
