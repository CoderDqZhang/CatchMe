//
//  LoginTypeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class LoginTypeViewController: BaseViewController {

    var loginWithWeChat:CustomButton!
    var loginWithPhone:CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewControllerSetNavigationItemBack(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(LoginTypeViewController.leftBarButtonPress))
    }
    
    override func setUpView() {
        loginWithWeChat = CustomButton.init(frame: CGRect.init(x: 30, y: 130, width: SCREENWIDTH - 60, height: 40), title: "微信登录", tag: 0, titleFont: App_Theme_PinFan_R_15_Font!, type: CustomButtonType.withBackBoarder, pressClouse: { (tag) in
            self.loginWeiChat()
        })
        self.view.addSubview(loginWithWeChat)
        
        loginWithPhone = CustomButton.init(frame: CGRect.init(x: 30, y: 190, width: SCREENWIDTH - 60, height: 40), title: "手机登录", tag: 0, titleFont: App_Theme_PinFan_R_15_Font!, type: CustomButtonType.withBackBoarder, pressClouse: { (tag) in
            NavigationPushView(self, toConroller: LoginViewController())
        })
        self.view.addSubview(loginWithPhone)
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
