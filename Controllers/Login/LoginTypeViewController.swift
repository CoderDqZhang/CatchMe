//
//  LoginTypeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class LoginTypeViewController: BaseViewController {

    var loginWithWeChat:UIButton!
    var loginWithPhone:UIButton!
    var loginImage:UIImageView!
    var loginLable:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginSuccess(_:)), name: NSNotification.Name(rawValue: WeiXinCode), object: nil)
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        // Do any additional setup after loading the view.
    }
    
    override func viewControllerSetNavigationItemBack(){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: WeiXinCode), object: nil)
    }
    
    override func setUpView() {
        loginWithWeChat = UIButton.init(type: .custom)
        loginWithWeChat.setImage(UIImage.init(named: "wechat_login"), for: .normal)
        loginWithWeChat.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        loginWithWeChat.setTitle("微信登录", for: .normal)
        loginWithWeChat.layer.cornerRadius = 25
        loginWithWeChat.setTitleColor(UIColor.init(hexString: App_Theme_FC4652_Color), for: .normal)
        loginWithWeChat.titleLabel?.font = App_Theme_PinFan_M_17_Font
        loginWithWeChat.reactive.controlEvents(.touchUpInside).observe { (active) in
            self.loginWeiChat()
        }
        self.view.addSubview(loginWithWeChat)
        loginWithWeChat.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp.centerY).offset(4)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        loginWithPhone = UIButton.init(type: .custom)
        loginWithPhone.backgroundColor = UIColor.clear
        loginWithPhone.setTitle("手机登录", for: .normal)
        loginWithPhone.titleLabel?.font = App_Theme_PinFan_R_16_Font
        loginWithPhone.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        loginWithPhone.reactive.controlEvents(.touchUpInside).observe { (active) in
            NavigationPushView(self, toConroller: LoginSetPhoneViewController())
        }
        self.view.addSubview(loginWithPhone)
        loginWithPhone.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithWeChat.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
        loginLable = UILabel.init()
        loginLable.text = "主人\n带我回家吧"
        loginLable.font = App_Theme_PinFan_R_65_Font
        loginLable.numberOfLines = 0
        loginLable.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.view.addSubview(loginLable)
        loginLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.centerY.equalTo(self.view.snp.centerY).offset(-190)
        }
        
        loginImage = UIImageView.init()
        loginImage.image = UIImage.init(named: "pic_login")
        self.view.addSubview(loginImage)
        loginImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 207/375))
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
    }
    
    func loginWeiChat(){
//        if WXApi.isWXAppInstalled() {
//            let req = SendAuthReq()
//            req.scope = "snsapi_userinfo"
//            req.state = "App"
//            //第三方向微信终端发送一个SendAuthReq消息结构
//            if !WXApi.send(req) {
//                print("weixin sendreq failed")
//            }
//        }
        //测试登录
        let parameters = ["userId":"7"]
        BaseNetWorke.sharedInstance.getUrlWithString(UserInfoUrl, parameters: parameters as AnyObject).observe({ (resultDic) in
            if !resultDic.isCompleted {
                let model:UserInfoModel = UserInfoModel.init(dictionary: resultDic.value as! [AnyHashable : Any])
                model.idField = "\((resultDic.value as! NSDictionary).object(forKey: "id")!)"
                UserDefaultsSetSynchronize(model.neteaseAccountId as AnyObject, key: "neteaseAccountId")
                model.saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(model.neteaseAccountId!)'")
                LoginViewModel.shareInstance.loginNetNetease()
            }
        })
    }

    @objc func loginSuccess(_ object:Foundation.Notification){
        let parameters = ["code":object.object!]
        BaseNetWorke.sharedInstance.postUrlWithString(LoginWeiChat, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let model:UserInfoModel = UserInfoModel.init(dictionary: resultDic.value as! [AnyHashable : Any])
                model.idField = "\((resultDic.value as! NSDictionary).object(forKey: "id")!)"
                UserDefaultsSetSynchronize(model.neteaseAccountId as AnyObject, key: "neteaseAccountId")
                model.saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(model.neteaseAccountId!)'")
                LoginViewModel.shareInstance.loginNetNetease()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
