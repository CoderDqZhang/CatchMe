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
    var models = NSMutableArray.init()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.paySuccess(_:)), name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    @objc func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) != 100 {
            //支付成功执行更新方法
            let coinAmount = UserInfoModel.shareInstance().coinAmount.int! + TopUpModel.init(fromDictionary: self.models[topUpMuch - 1] as! NSDictionary).rechargeCoin
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
                self.models = NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                (self.controller as! TopUpViewController).setUpTopView()
            }
        }
    }
    
    func wxPay(){
        
    }
    
    func aliPay(){
        let parameters = ["ruleId":TopUpModel.init(fromDictionary: self.models[self.topUpMuch - 1] as! NSDictionary).id,"userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(AliPayInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                AlipaySDK.defaultService().payOrder(resultDic.value! as! String, fromScheme: "CatchMeAlipay") { (resultDic) in
                    print("resultDic")
                }
            }
        }
    }
}
