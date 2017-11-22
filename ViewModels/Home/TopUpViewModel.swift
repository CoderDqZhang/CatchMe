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
    var topUpMuch:Int!
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.paySuccess(_:)), name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    @objc func paySuccess(_ object:Foundation.Notification){
        if Int(object.object as! String) != 100 {
            //支付成功执行更新方法
        }else{
            //支付失败
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: PayStatusChange), object: nil)
    }
    
    func wxPay(){
        
    }
    
    func aliPay(){
        
    }
}
