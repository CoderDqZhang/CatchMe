
//
//  MyInvitationCodeViewController.swift
//  CatchMe
//
//  Created by Zhang on 24/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyInvitationCodeViewController: BaseViewController {

    var textField:UITextField!
    var lineLabel:GloabLineView!
    
    var conversionBtn:UIButton!
    
    var myInvitation:UILabel!
    var invitationLabel:UILabel!
    var sharBtn:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "邀请码"
    }
    
    override func setUpView() {
        textField = UITextField.init()
        textField.placeholder = "请输入邀请码，每人限兑换一次"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.font = App_Theme_PinFan_R_14_Font
        textField.reactive.continuousTextValues.observeValues { (str) in
            
        }
        textField.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.top.equalTo(self.view.snp.top).offset(94)
        }
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 54, y: 120, width: SCREENWIDTH - 108, height: 1))
        self.view.addSubview(lineLabel)
        
        conversionBtn = UIButton.init(type: .custom)
        conversionBtn.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        conversionBtn.setTitle("兑换邀请码", for: .normal)
        conversionBtn.layer.cornerRadius = 25
        conversionBtn.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        conversionBtn.titleLabel?.font = App_Theme_PinFan_M_17_Font
        conversionBtn.reactive.controlEvents(.touchUpInside).observe { (active) in
        }
        self.view.addSubview(conversionBtn)
        conversionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineLabel.snp.bottom).offset(30)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 200, height: 46))
        }
        
        myInvitation = UILabel.init()
        myInvitation.text = "我的邀请码：\(UserInfoModel.shareInstance().shareCode!)"
        myInvitation.font = App_Theme_PinFan_M_16_Font
        myInvitation.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.view.addSubview(myInvitation)
        
        myInvitation.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.conversionBtn.snp.bottom).offset(96)
        }
        
        invitationLabel = UILabel.init()
        invitationLabel.text = "通过我的邀请下载并登录的新用户，在上面的邀码\n输入框内输入我的邀请码并点击兑换，我即\n可得到60个娃娃币的奖励，上不封顶。"
        invitationLabel.textAlignment = .center
        invitationLabel.font = App_Theme_PinFan_R_13_Font
        invitationLabel.numberOfLines = 0
        invitationLabel.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        self.view.addSubview(invitationLabel)
        
        invitationLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(40)
            make.right.equalTo(self.view.snp.right).offset(-40)
            make.top.equalTo(self.myInvitation.snp.bottom).offset(9)
        }
        
        sharBtn = UIButton.init(type: .custom)
        sharBtn.setBackgroundImage(UIImage.init(named: "pic_invite"), for: .normal)
        sharBtn.reactive.controlEvents(.touchUpInside).observe { (active) in
            KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, clickClouse: { (type) in
                switch type {
                case .QQChat:
                    ShareTools.shareInstance.shareQQSessionWebUrl("测试", webTitle: "", imageUrl: "", webDescription: "", webUrl: "")
                case .weChatChat:
                    ShareTools.shareInstance.shareWeChatSession("", description: "", image: UIImage.init(named: "pic_about")!, url: nil)
                case .weChatSession:
                    ShareTools.shareInstance.shareWeChatTimeLine("", description: "", image: UIImage.init(named: "pic_about")!, url: nil)
                default:
                    break
                }
            }))
        }
        
        self.view.addSubview(sharBtn)
        sharBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.invitationLabel.snp.bottom).offset(3)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
