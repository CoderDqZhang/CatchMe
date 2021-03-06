//
//  LoginPhoneCodeViewController.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class LoginPhoneCodeViewController: BaseViewController {

    var backGroupButton:UIButton!
    var phoneLabel:UILabel!
    var loginButton:CustomTouchButton!
    var senderCode:UIButton!
    var inputCode:UITextField!
    
    var timeDownLabel:CountDown!
    
    var lingLabel1:GloabLineView!
    var lingLabel2:GloabLineView!
    var lingLabel3:GloabLineView!
    var lingLabel4:GloabLineView!
    
    var codeLabel1:UILabel!
    var codeLabel2:UILabel!
    var codeLabel3:UILabel!
    var codeLabel4:UILabel!
    
    var comfigLabel:UILabel!
    
    var loginViewModel = LoginViewModel.shareInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "验证码页面"
        self.setupForDismissKeyboard()
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
            make.top.equalTo(self.view.snp.top).offset(20 + IPHONEXFRAMEHEIGHT)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    func setUpLoginForm(){
        phoneLabel = UILabel.init()
        phoneLabel.text = "验证码已发送"
        phoneLabel.font = App_Theme_PinFan_M_34_Font
        phoneLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(phoneLabel)
        
        phoneLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(76 + IPHONEXFRAMEHEIGHT)
        }
        
        inputCode = UITextField.init()
        inputCode.textAlignment = .center
        inputCode.keyboardType = .numberPad
        inputCode.becomeFirstResponder()
        inputCode.font = App_Theme_PinFan_R_24_Font
        inputCode.reactive.continuousTextValues.observeValues { (str) in
            self.loginViewModel.form.code = str!
            if str?.length == 4 {
                self.loginButton.setButtonIsEnabled(isEnabled: true)
            }else{
                self.loginButton.setButtonIsEnabled(isEnabled: false)
            }
            let count = (str?.charactersArray.count)!
            switch count {
            case 0:
                self.codeLabel1.text = ""
                self.codeLabel2.text = ""
                self.codeLabel3.text = ""
                self.codeLabel4.text = ""
            case 1:
                self.codeLabel1.text = (str?.charactersArray[0].string)!
                self.codeLabel2.text = ""
                self.codeLabel3.text = ""
                self.codeLabel4.text = ""
            case 2:
                self.codeLabel1.text = (str?.charactersArray[0].string)!
                self.codeLabel2.text = (str?.charactersArray[1].string)!
                self.codeLabel3.text = ""
                self.codeLabel4.text = ""
            case 3:
                self.codeLabel1.text = (str?.charactersArray[0].string)!
                self.codeLabel2.text = (str?.charactersArray[1].string)!
                self.codeLabel3.text = (str?.charactersArray[2].string)!
                self.codeLabel4.text = ""
            case 4:
                self.codeLabel1.text = (str?.charactersArray[0].string)!
                self.codeLabel2.text = (str?.charactersArray[1].string)!
                self.codeLabel3.text = (str?.charactersArray[2].string)!
                self.codeLabel4.text = (str?.charactersArray[3].string)!
            default:
                break
            }
        }
        inputCode.delegate = self
        inputCode.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(inputCode)
        inputCode.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-30)
            make.bottom.equalTo(self.view.snp.bottom).offset(30)
        }
        
        self.setUpForLableAndLine()
        loginButton = CustomTouchButton.init(frame:  CGRect.init(x: (SCREENWIDTH - 220)/2, y: 268 + IPHONEXFRAMEHEIGHT, width: 220, height: 48), title: "登录", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: .withBackBoarder, pressClouse: { (tag) in
            self.loginViewModel.requestLogin(self.loginViewModel.form)
        })
        self.view.addSubview(loginButton)
        
        senderCode = UIButton.init(type: .custom)
        senderCode.setTitle("60秒后重发", for: .normal)
        senderCode.setTitleColor(UIColor.init(hexString: App_Theme_AAAAAA_Color), for: .normal)
        senderCode.titleLabel?.font = App_Theme_PinFan_R_14_Font
        senderCode.reactive.controlEvents(.touchUpInside).observe { (active) in
            self.loginViewModel.requestLoginCode(self.loginViewModel.form.phone)
        }
        self.loginViewModel.senderCodeSuccessClouse = {
            self.setUpCountDown()
        }
        self.view.addSubview(senderCode)
        self.setUpCountDown()
        senderCode.snp.makeConstraints { (make) in
            make.top.equalTo(self.loginButton.snp.bottom).offset(8)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
    }
    
    override func setupBaseViewForDismissKeyboard() {
        
    }
    
    func setUpForLableAndLine(){
        lingLabel1 = GloabLineView.init(frame: CGRect.init(x: (SCREENWIDTH - 220)/2, y: 227 + IPHONEXFRAMEHEIGHT, width: 40, height: 2))
        self.view.addSubview(lingLabel1)
        lingLabel1.setLineColor(UIColor.init(hexString: App_Theme_DDDDDD_Color))
        lingLabel2 = GloabLineView.init(frame: CGRect.init(x: lingLabel1.frame.maxX + 20, y: 227 + IPHONEXFRAMEHEIGHT, width: 40, height: 2))
        self.view.addSubview(lingLabel2)
        lingLabel2.setLineColor(UIColor.init(hexString: App_Theme_DDDDDD_Color))
        lingLabel3 = GloabLineView.init(frame: CGRect.init(x: lingLabel2.frame.maxX + 20, y: 227 + IPHONEXFRAMEHEIGHT, width: 40, height: 2))
        self.view.addSubview(lingLabel3)
        lingLabel3.setLineColor(UIColor.init(hexString: App_Theme_DDDDDD_Color))
        lingLabel4 = GloabLineView.init(frame: CGRect.init(x: lingLabel3.frame.maxX + 20, y: 227 + IPHONEXFRAMEHEIGHT, width: 40, height: 2))
        lingLabel4.setLineColor(UIColor.init(hexString: App_Theme_DDDDDD_Color))
        self.view.addSubview(lingLabel4)
        
        codeLabel1 = self.setUpLable()
        codeLabel1.frame = CGRect.init(x: (SCREENWIDTH - 220)/2, y: 184 + IPHONEXFRAMEHEIGHT, width: 40, height: 28)
        self.view.addSubview(codeLabel1)
        
        codeLabel2 = self.setUpLable()
        codeLabel2.frame = CGRect.init(x: codeLabel1.frame.maxX + 20, y: 184 + IPHONEXFRAMEHEIGHT, width: 40, height: 28)
        self.view.addSubview(codeLabel2)
        
        codeLabel3 = self.setUpLable()
        codeLabel3.frame = CGRect.init(x: codeLabel2.frame.maxX + 20, y: 184 + IPHONEXFRAMEHEIGHT, width: 40, height: 28)
        self.view.addSubview(codeLabel3)
        
        codeLabel4 = self.setUpLable()
        codeLabel4.frame = CGRect.init(x: codeLabel3.frame.maxX + 20, y: 184 + IPHONEXFRAMEHEIGHT, width: 40, height: 28)
        self.view.addSubview(codeLabel4)
    }
    
    func setUpCountDown(){
        if timeDownLabel == nil {
            timeDownLabel = CountDown()
        }
        let aMinutes:TimeInterval = 60
        self.startWithStartDate(NSDate() as Date, finishDate: NSDate.init(timeIntervalSinceNow: aMinutes) as Date)
    }
    
    func startWithStartDate(_ date:Date, finishDate:Date){
        UserDefaultsSetSynchronize("true" as AnyObject, key: "isLoginTime")
        UserDefaultsSetSynchronize("nil" as AnyObject, key: "isLoginEnterBack")
        UserDefaultsSetSynchronize(0 as AnyObject, key: "backGroundTime")
        timeDownLabel.countDown(withStratDate: date, finish: finishDate) { (day, hours, minutes, seconds) in
            var totoalSecod = day*24*60*60+hours*60*60+minutes*60+seconds
            if UserDefaultsGetSynchronize("isLoginEnterBack") as! String != "nil"{
                totoalSecod = totoalSecod - (UserDefaultsGetSynchronize("backGroundTime") as! Int)
            }
            if totoalSecod == 0 {
                UserDefaultsSetSynchronize(0 as AnyObject, key: "backGroundTime")
                self.senderCode.isEnabled = true
                self.senderCode.setTitle("重新发送", for: .normal)
            }else{
                self.senderCode.isEnabled = false
                self.senderCode.setTitle("\(totoalSecod)秒后重发", for: .normal)
            }
        }
    }
    
    func setUpLable() ->UILabel{
        let label = UILabel.init()
        label.text = ""
        label.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        label.font = App_Theme_PinFan_M_24_Font
        label.textAlignment = .center
        return label
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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

extension LoginPhoneCodeViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == self.inputCode) {
            if (self.loginViewModel.form.code.length >= 4) {
                if string == "" {
                    return true
                }
                return false
            }
        }
        return true
    }
}
