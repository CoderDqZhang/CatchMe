
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
    var loginButton:CustomTouchButton!
    
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
        backGroupButton = AnimationButton.init()
        backGroupButton.setImage(UIImage.init(named: "back_bar_black"), for: .normal)
        backGroupButton.reactive.controlEvents(.touchUpInside).observe { (actic) in
            self.navigationController?.popViewController()
        }
        self.view.addSubview(backGroupButton)
        backGroupButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(6)
            make.top.equalTo(self.view.snp.top).offset(20)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func setUpLoginForm(){
        phoneLabel = UILabel.init()
        phoneLabel.text = "使用手机号登录"
        phoneLabel.font = App_Theme_PinFan_M_34_Font
        phoneLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(phoneLabel)
        
        phoneLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(76)
        }
        
        inputPhone = UITextField.init()
        inputPhone.placeholder = "请输入手机号码"
        inputPhone.textAlignment = .center
        inputPhone.keyboardType = .numberPad
        inputPhone.becomeFirstResponder()
        inputPhone.font = App_Theme_PinFan_M_24_Font
        inputPhone.reactive.continuousTextValues.observeValues { (str) in
            self.loginViewModel.form.phone = str!
            if str?.length == 11 {
                self.loginButton.setButtonIsEnabled(isEnabled: true)
            }else{
                self.loginButton.setButtonIsEnabled(isEnabled: false)
            }
        }
        inputPhone.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(inputPhone)
        
        inputPhone.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-30)
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(74)
        }
        
        lingLabel = GloabLineView.init(frame: CGRect.init(x: 53, y: 230, width: SCREENWIDTH - 106, height: 1))
        lingLabel.setLineColor(UIColor.init(hexString: App_Theme_DDDDDD_Color))
        self.view.addSubview(lingLabel)
        
        loginButton = CustomTouchButton.init(frame:  CGRect.init(x: (SCREENWIDTH - 220)/2, y: 268, width: 220, height: 48), title: "获取验证码", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: .withBackBoarder, pressClouse: { (tag) in
            self.loginViewModel.requestLoginCode(self.loginViewModel.form.phone)
        })
        self.loginViewModel.senderCodeSuccessClouse = {
            NavigationPushView(self, toConroller: LoginPhoneCodeViewController())
        }
        self.view.addSubview(loginButton)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func setupBaseViewForDismissKeyboard() {
        
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
