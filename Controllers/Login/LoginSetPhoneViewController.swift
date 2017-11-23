
//
//  LoginSetPhoneViewController.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit


class LoginSetPhoneViewController: BaseViewController {

    var backGroupButton:UIButton!
    var phoneLabel:UILabel!
    var inputPhone:UITextField!
    var lingLabel:GloabLineView!
    var loginButton:UIButton!
    
    var comfigLabel:UILabel!
    var proBtn:CustomButton!
    
    var loginViewModel = LoginViewModel.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func setUpView() {
        self.setBackBtn()
        self.setUpLoginForm()
    }
    
    func setBackBtn(){
        backGroupButton = UIButton.init()
        backGroupButton.setImage(UIImage.init(named: "back_bar_black"), for: .normal)
        backGroupButton.reactive.controlEvents(.touchUpInside).observe { (actic) in
            self.navigationController?.popViewController()
        }
        self.view.addSubview(backGroupButton)
        backGroupButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(30)
            make.top.equalTo(self.view.snp.top).offset(30)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func setUpLoginForm(){
        phoneLabel = UILabel.init()
        phoneLabel.text = "使用手机号码登录"
        phoneLabel.font = App_Theme_PinFan_M_34_Font
        phoneLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(phoneLabel)
        
        phoneLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(72)
        }
        
        inputPhone = UITextField.init()
        inputPhone.placeholder = "请输入手机号码"
        inputPhone.textAlignment = .center
        inputPhone.keyboardType = .numberPad
        inputPhone.becomeFirstResponder()
        inputPhone.font = App_Theme_PinFan_R_24_Font
        inputPhone.reactive.continuousTextValues.observeValues { (str) in
            self.loginViewModel.form.phone = str!
            if str?.length == 11 {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color, andAlpha: 1)
            }else{
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color, andAlpha: 0.7)
            }
        }
        inputPhone.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(inputPhone)
        
        inputPhone.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-30)
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(67)
        }
        
        lingLabel = GloabLineView.init(frame: CGRect.init(x: 53, y: 230, width: SCREENWIDTH - 106, height: 1))
        self.view.addSubview(lingLabel)
        
        loginButton = UIButton.init(type: .custom)
        loginButton.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color, andAlpha: 0.7)
        loginButton.setTitle("获取验证码", for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        loginButton.titleLabel?.font = App_Theme_PinFan_M_17_Font
        loginButton.reactive.controlEvents(.touchUpInside).observe { (active) in
//            NavigationPushView(self, toConroller: LoginPhoneCodeViewController())
            self.loginViewModel.requestLoginCode(self.loginViewModel.form.phone)
        }
        self.loginViewModel.senderCodeSuccessClouse = {
            NavigationPushView(self, toConroller: LoginPhoneCodeViewController())
        }
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.lingLabel.snp.bottom).offset(40)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 200, height: 50))
        }
        
        comfigLabel = UILabel()
        comfigLabel.text = "登录表示同意"
        comfigLabel.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        comfigLabel.font = App_Theme_PinFan_R_13_Font
        self.view.addSubview(comfigLabel)
        
        proBtn = CustomButton.init(frame: CGRect.zero, title: "用户注册协议与隐私条款", tag: 1, titleFont: App_Theme_PinFan_R_13_Font!, type: .withNoBoarder, pressClouse: { (tag) in
            NavigationPushView(self, toConroller: UserProtocolViewController())
        })
        self.view.addSubview(proBtn)
        
        comfigLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-240)
            make.centerX.equalTo(self.view.snp.centerX).offset(-65)
        }
        
        proBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-234)
            make.centerX.equalTo(self.view.snp.centerX).offset(49)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
