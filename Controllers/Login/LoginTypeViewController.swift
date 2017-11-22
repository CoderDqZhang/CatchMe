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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        // Do any additional setup after loading the view.
    }
    
    override func viewControllerSetNavigationItemBack(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(LoginTypeViewController.leftBarButtonPress))
    }
    
    override func setUpView() {
        loginWithWeChat = UIButton.init(type: .custom)
        loginWithWeChat.setImage(UIImage.init(named: "male_me"), for: .normal)
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
            NavigationPushView(self, toConroller: LoginViewController())
        }
        self.view.addSubview(loginWithPhone)
        loginWithPhone.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginWithWeChat.snp.bottom).offset(15)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
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
    
    @objc func leftBarButtonPress(){
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
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
