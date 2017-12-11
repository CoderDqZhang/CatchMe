 //
//  TopUpViewModel.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit



class TopUpViewModel: BaseViewModel {

    //topUpMuch 1 == 10,2==20,3==50,4==100,5=200,6==500
    var topUpMuch:Int = 1
    var models:TopUpModel!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.paySuccess(_:)), name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    @objc func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) != 100 {
            //支付成功执行更新方法
            
            let coinAmount = UserInfoModel.shareInstance().coinAmount.int! + models.rechargeRateRuleDTOList[topUpMuch - 1].rechargeCoin
            UserInfoModel.shareInstance().coinAmount = "\(coinAmount)"
            UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
            (self.controller as! TopUpViewController).setBalanceText(str: "\(coinAmount)")
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
                self.models = TopUpModel.init(fromDictionary: resultDic.value as! NSDictionary)
                (self.controller as! TopUpViewController).setUpTopView()
                (self.controller as! TopUpViewController).setUpWeekView()
            }
        }
    }
    
    func wxPay(){
        if self.topUpMuch != 100 {
            let parameters = ["ruleId":models.rechargeRateRuleDTOList[topUpMuch - 1].id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
            BaseNetWorke.sharedInstance.postUrlWithString(WeChatPayUrl, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    let model = Wxpay.init(fromDictionary: resultDic.value as! NSDictionary)
                    let request = PayReq()
                    request.prepayId = model.prepayid
                    request.partnerId = model.partnerid
                    request.package = model.package
                    request.nonceStr = model.noncestr
                    request.timeStamp = UInt32(model.timestamp)!
                    request.sign = model.sign
                    WXApi.send(request)
                }
            }
        }else{
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请选择一个充值金额", autoHidder: true)
        }
    }
    
    func aliPay(){
        if self.topUpMuch != 100 {
            let parameters = ["ruleId":models.rechargeRateRuleDTOList[topUpMuch - 1].id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
            BaseNetWorke.sharedInstance.postUrlWithString(AliPayInfo, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    AlipaySDK.defaultService().payOrder(resultDic.value! as! String, fromScheme: "CatchMeAlipay") { (resultDic) in
                        print("resultDic")
                    }
                }
            }
        }else{
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请选择一个充值金额", autoHidder: true)
        }
        
    }
}
