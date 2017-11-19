//
//  LoginViewModel.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MJExtension

class LoginViewModel: BaseViewModel {
    
    override init() {
        
    }
    
    func requestLoginCode(_ number:String, controller:LoginViewController){
        let dic = ["telephone":number]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginCode, parameters: dic as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let aMinutes:TimeInterval = 60
                controller.startWithStartDate(NSDate() as Date, finishDate: NSDate.init(timeIntervalSinceNow: aMinutes) as Date)
            }
        }
    }
    
    func requestLogin(_ form:LoginForm,controller:LoginViewController) {
        let dic = ["telephone":form.phone, "verifyCode":form.code]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginUrl, parameters: dic as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                UserDefaultsSetSynchronize(form.phone as AnyObject, key: "telephone")
                let model = UserInfoModel.mj_object(withKeyValues: (resultDic.value as! NSDictionary).object(forKey: "data"))
                model?.saveOrUpdate()
                Notification(LoginStatuesChange, value: nil)
                controller.navigationController?.dismiss(animated: true, completion: {
                    
                })
                
            }
        }
    }
    
//    func savePhotoImage(){
//        if UserInfoModel.shareInstance().avatar != "" {
//            SDWebImageManager.shared().loadImage(with: URL.init(string: UserInfoModel.shareInstance().avatar), options: .retryFailed, progress: { (star, end, url) in
//
//            }) { (image, data, error, cache, finish, url) in
//                if error == nil {
//                    _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image!, path: "headerImage")
//                }
//            }
//        }
//    }
//
//    func requestAddress(){
//        BaseNetWorke.sharedInstance.getUrlWithString(AddAddress, parameters: nil).observe { (resultDic) in
//            if !resultDic.isCompleted {
//                let resultModels =  NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
//                var addressModels:[AddressModel] = []
//                for model in resultModels! {
//                    addressModels.append(AddressModel.init(fromDictionary: model as! NSDictionary))
//                }
//                AddressModel.archiveRootObject(addressModels)
//            }
//        }
//    }
}
