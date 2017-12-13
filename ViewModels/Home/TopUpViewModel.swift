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
    var topUpMuch:Int = 1000
    var models:TopUpModel!
    var model:AliPayInfoModel!
    var weChatModel:Wxpay!
    var isWeChat:Bool = false
    
    var time:Timer!
    var hud:MBProgressHUD!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.paySuccess(_:)), name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    @objc func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) != 100 {
            //支付成功执行更新方法
            hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "加载中")
            time = Timer.every(1, {
                self.getOrderOrNo()
            })
            
        }else{
            //支付失败
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    func requestTopUp(){
        BaseNetWorke.sharedInstance.postUrlWithString(TopUp, parameters: nil).observe { (resultDic) in
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
    
    func getOrderOrNo(){
        let str = isWeChat ? self.weChatModel.orderNo  : self.model.orderNo
        let parameters = ["orderNo":str]
        BaseNetWorke.sharedInstance.postUrlWithString(RecordByOrderNo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if (resultDic.value is NSDictionary) {
                    if ((resultDic.value as! NSDictionary).object(forKey: "isSuccess")! as! Bool) {
                        UserInfoModel.shareInstance().coinAmount = "\((resultDic.value as! NSDictionary).object(forKey: "coinAmount")!)"
                        (self.controller as! TopUpViewController).setBalanceText(str: "\(UserInfoModel.shareInstance().coinAmount!)")
                        UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                        self.hud.hide(animated: true)
                        self.time.invalidate()
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
                self.weChatModel = Wxpay.init(fromDictionary: resultDic.value as! NSDictionary)
                let request = PayReq()
                request.prepayId = self.weChatModel.payInfo.prepayid
                request.partnerId = self.weChatModel.payInfo.partnerid
                request.package = self.weChatModel.payInfo.package
                request.nonceStr = self.weChatModel.payInfo.noncestr
                request.timeStamp = UInt32(self.weChatModel.payInfo.timestamp)!
                request.sign = self.weChatModel.payInfo.sign
                WXApi.send(request)
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
                self.model = AliPayInfoModel.init(fromDictionary: resultDic.value as! NSDictionary)
                AlipaySDK.defaultService().payOrder(self.model.payInfo, fromScheme: "CatchMeAlipay") { (resultDic) in
                    print("resultDic")
                }
            }
        }
    }
}
