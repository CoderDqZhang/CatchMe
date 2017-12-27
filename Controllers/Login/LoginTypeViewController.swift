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
    var loginWeChatView:AnimationTouchView!
    
    var loginImageProc:UIImageView!
    
    var loginImage:FLAnimatedImageView!
    var loginLable:UILabel!
    var titleLabel:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginSuccess(_:)), name: NSNotification.Name(rawValue: WeiXinCode), object: nil)
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FC4F5E_Color)
        // Do any additional setup after loading the view.
    }
    
    override func viewControllerSetNavigationItemBack(){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: WeiXinCode), object: nil)
    }
    
    override func setUpView() {
        
        
        loginImage = FLAnimatedImageView.init()
        self.view.addSubview(loginImage)
        
        loginImageProc = UIImageView.init()
        loginImageProc.isUserInteractionEnabled = true
        loginImageProc.image = UIImage.init(named: "check_1")
        self.view.addSubview(loginImageProc)
        
        loginLable = UILabel.init()
        loginLable.isUserInteractionEnabled = true
        loginLable.text = "登录代表同意用户注册协议与隐私条款"
        loginLable.font = App_Theme_PinFan_R_13_Font
        loginLable.textColor = UIColor.init(hexString: App_Theme_FFFFFF_Color, andAlpha: 0.35)
        self.view.addSubview(loginLable)
        
        loginLable.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-23)
            make.centerX.equalTo(self.view.snp.centerX).offset(4)
        }
        
        loginImageProc.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-24)
            make.right.equalTo(self.loginLable.snp.left).offset(-2)
        }
        
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.buttonClick))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        loginLable.addGestureRecognizer(singleTap)
        
        
        loginWithPhone = UIButton.init(type: .custom)
        loginWithPhone.backgroundColor = UIColor.clear
        loginWithPhone.setTitle("手机号登录", for: .normal)
        loginWithPhone.titleLabel?.font = App_Theme_PinFan_R_16_Font
        loginWithPhone.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        loginWithPhone.reactive.controlEvents(.touchUpInside).observe { (active) in
            NavigationPushView(self, toConroller: LoginSetPhoneViewController())
        }
        self.view.addSubview(loginWithPhone)
        loginWithPhone.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.loginLable.snp.top).offset(IPHONE5 ? -47 : -67)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
        loginWeChatView = AnimationTouchView.init(frame: CGRect.zero) {
            self.loginWeiChat()
        }
        
        self.view.addSubview(loginWeChatView)
        
        if WXApi.isWXAppInstalled() {
            let loginWithWeChat_bg = UIButton.init(type: .custom)
            loginWithWeChat_bg.backgroundColor = UIColor.init(hexString: App_Theme_FF8989_Color)
            loginWithWeChat_bg.layer.cornerRadius = 25
            loginWeChatView.addSubview(loginWithWeChat_bg)
            loginWithWeChat_bg.snp.makeConstraints { (make) in
                make.top.equalTo(self.loginWeChatView.snp.top).offset(2)
                make.left.equalTo(self.loginWeChatView.snp.left).offset(0)
                make.size.equalTo(CGSize.init(width: 200, height: 48))
            }
            
            loginWithWeChat = UIButton.init(type: .custom)
            loginWithWeChat.setImage(UIImage.init(named: "wechat_login"), for: .normal)
            loginWithWeChat.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            loginWithWeChat.setTitle(" 微信登录", for: .normal)
            loginWithWeChat.layer.cornerRadius = 25
            loginWithWeChat.setTitleColor(UIColor.init(hexString: App_Theme_FC4652_Color), for: .normal)
            loginWithWeChat.titleLabel?.font = App_Theme_PinFan_M_17_Font
            loginWeChatView.addSubview(loginWithWeChat)
            
            loginWithWeChat.snp.makeConstraints { (make) in
                make.top.equalTo(self.loginWeChatView.snp.top).offset(0)
                make.left.equalTo(self.loginWeChatView.snp.left).offset(0)
                make.size.equalTo(CGSize.init(width: 200, height: 48))
            }
            
            loginWeChatView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.loginWithPhone.snp.top).offset(-10)
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 200, height: 50))
            }
        }
        
        self.setGIfImage()
        
        
        titleLabel = UIImageView.init()
        titleLabel.image = UIImage.init(named: "text")
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginImage.snp.bottom).offset(11)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
    }
    
    @objc func buttonClick(){
        NavigationPushView(self, toConroller: UserProtocolViewController())
    }
    
    func setGIfImage(){
        let gifPath = Bundle.main.path(forResource: "下场循环", ofType: ".gif")
        //指定音乐路径
        let url = URL.init(fileURLWithPath: gifPath!)
        do {
            let gifData =  try Data.init(contentsOf: url)
            let gifImage = FLAnimatedImage.init(animatedGIFData: gifData)
            loginImage.animatedImage = gifImage
            loginImage.snp.makeConstraints { (make) in
                make.top.equalTo(self.view.snp.top).offset(43 + IPHONEXFRAMEHEIGHT)
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 684 / 750))
            }
        } catch  {
            print("error")
        }
    }
    
    func loginWeiChat(){
        if WXApi.isWXAppInstalled() {
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "App"
            //第三方向微信终端发送一个SendAuthReq消息结构
            if !WXApi.send(req) {
                print("weixin sendreq failed")
            }
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
