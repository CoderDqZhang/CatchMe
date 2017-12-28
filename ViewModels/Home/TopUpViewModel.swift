 //
//  TopUpViewModel.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MBProgressHUD
 
class TopUpViewModel: BaseViewModel {

    //topUpMuch 1 == 10,2==20,3==50,4==100,5=200,6==500
    var topUpMuch:Int = 7
    var models:TopUpModel!
    var model:AliPayInfoModel!
    var weChatModel:Wxpay!
    var isWeChat:Bool = false
    var time:Timer!
    var hud:MBProgressHUD!
    var orderNo:String!
    
    var paySuccess:Bool = true

    override init() {
        super.init()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.paySuccess(_:)), name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
//    @objc func paySuccess(_ object:Foundation.Notification){
//        if Int(object.object as! String) != 100 {
//            //支付成功执行更新方法
//            hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "加载中")
//            time = Timer.every(1, {
//                self.getOrderOrNo()
//            })
//
//        }else{
//            //支付失败
//        }
//    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
//    }
    
    func requestTopUp(){
        let parameters = ["platformType":"2"]
        BaseNetWorke.sharedInstance.postUrlWithString(TopUp, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (self.controller as! TopUpViewController).isPlayGameView {
                    self.controller?.navigationController?.popViewController()
                }
                self.models = TopUpModel.init(fromDictionary: resultDic.value as! NSDictionary)
                (self.controller as! TopUpViewController).setUpTopView()
                (self.controller as! TopUpViewController).setUpWeekView()
            }
        }
    }
    
    func rechargeAppPay(rejectStr:String){
        if self.orderNo != nil {
            var str:String = ""
            if self.topUpMuch != 7 {
                str = "\(APPPayRejectKey)orderNo=\(self.orderNo!)&receipt=\(rejectStr)&timeStamp=\(Int(Date.init().timeIntervalSince1970))\(APPPayRejectKey)"
            }else{
                str = "\(APPPayRejectKey)orderNo=\(self.orderNo!)&receipt=\(rejectStr)&timeStamp=\(Int(Date.init().timeIntervalSince1970))\(APPPayRejectKey)"
            }
            let parameters = ["orderNo":self.orderNo,"receipt":rejectStr,"timeStamp":Int(Date.init().timeIntervalSince1970),"sign":str.md5()] as [String : Any]
            BaseNetWorke.sharedInstance.postUrlWithString(ApplePay, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted{
                    if resultDic.value != nil {
                        if resultDic.value as! Bool {
                            self.hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: nil)
                            self.time = Timer.every(1, {
                                self.getOrderOrNo()
                            })
                        }
                    }
                }
            }
        }
    }
    
    func getOrderOrNo(){
//        let str:String!
//        if isWeChat {
//            if self.weChatModel.orderNo == nil {
//                print("代码增加微信是错")
//            }
//            str = self.weChatModel.orderNo == nil ? UserDefaultsGetSynchronize("orderNo") as! String : self.weChatModel.orderNo
//        }else{
//            if self.model.orderNo == nil {
//                print("代码增加支付宝是错")
//            }
//            str = self.model.orderNo == nil ? UserDefaultsGetSynchronize("orderNo") as! String : self.model.orderNo
//        }
        let parameters = ["orderNo":self.orderNo]
        BaseNetWorke.sharedInstance.postUrlWithString(RecordByOrderNo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (resultDic.value is NSDictionary) {
                    if ((resultDic.value as! NSDictionary).object(forKey: "isSuccess")! as! Bool) {
                        self.paySuccess = true
                        UserInfoModel.shareInstance().coinAmount = "\((resultDic.value as! NSDictionary).object(forKey: "coinAmount")!)"
                        DispatchQueue.main.async(execute: {
                            (self.controller as! TopUpViewController).setBalanceText(str: "\(UserInfoModel.shareInstance().coinAmount!)")
                        })
                        UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                        if self.hud != nil {
                            self.hud.hide(animated: true)
                            self.time.invalidate()
                        }
                    }else{
//                        if self.hud != nil {
//                            self.hud.hide(animated: true)
//                            self.time.invalidate()
//                        }
                    }
                }
            }
        }
    }
    
    func wxPay(){
        var parameters:[String : Any]!
        if self.topUpMuch != 1000 {
            parameters = ["ruleId":models.rechargeRateRuleDTOList[topUpMuch - 1].id,"userId":UserInfoModel.shareInstance().idField]
        }else{
            parameters = ["ruleId":models.weeklyRechargeRateRuleDTO.id,"userId":UserInfoModel.shareInstance().idField]
        }
        isWeChat = true
        BaseNetWorke.sharedInstance.postUrlWithString(WeChatPayUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let orderNo = (resultDic.value as! NSDictionary).object(forKey: "orderNo") as! String
                self.weChatModel = Wxpay.init(fromDictionary: resultDic.value as! NSDictionary)
                self.weChatModel.orderNo = orderNo
                UserDefaultsSetSynchronize(orderNo as AnyObject, key: "orderNo")
                
            }
        }
    }

    func aliPay(){
        isWeChat = false
        var parameters:[String : Any]!
        if self.topUpMuch != 1000 {
            parameters = ["ruleId":models.rechargeRateRuleDTOList[topUpMuch - 1].id,"userId":UserInfoModel.shareInstance().idField]
        }else{
            parameters = ["ruleId":models.weeklyRechargeRateRuleDTO.id,"userId":UserInfoModel.shareInstance().idField]
        }
        BaseNetWorke.sharedInstance.postUrlWithString(AliPayInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let orderNo = (resultDic.value as! NSDictionary).object(forKey: "orderNo") as! String
                self.model = AliPayInfoModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.model.orderNo = orderNo
                UserDefaultsSetSynchronize(orderNo as AnyObject, key: "orderNo")
                
            }
        }
    }
    
    func getOrderInPurchase(){
        if paySuccess {
            var parameters:[String : Any]!
            if self.topUpMuch != 7 {
                parameters = ["ruleId":models.rechargeRateRuleDTOList[topUpMuch - 1].id]
            }else{
                parameters = ["ruleId":models.weeklyRechargeRateRuleDTO.id]
            }
            BaseNetWorke.sharedInstance.postUrlWithString(InPurchase, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    if resultDic.value != nil {
                        if resultDic.value != nil {
                            self.paySuccess = false
                            let orderNo = resultDic.value!
                            self.orderNo = orderNo as! String
                            UserDefaultsSetSynchronize(orderNo as AnyObject, key: "orderNo")
                            (self.controller as! TopUpViewController).requestProduceData(model: self.models)
                        }
                    }
                }
            }
        }else{
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请稍后", autoHidder: true)
        }
    }
}
