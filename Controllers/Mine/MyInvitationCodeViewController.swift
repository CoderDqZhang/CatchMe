
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
    
    var conversionBtn:CustomButton!
    
    var myInvitation:UILabel!
    var invitationLabel:UILabel!
    var sharBtn:UIButton!
    
    var myInvitationViewMode = MyInvitationCodeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindLogicViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "邀请码"
    }
    
    func bindLogicViewModel(){
        self.myInvitationViewMode.controller = self
    }
    
    override func setUpView() {
        textField = UITextField.init()
        textField.placeholder = "请输入邀请码，每人限兑换一次"
        textField.font = App_Theme_PinFan_M_30_Font
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入邀请码，每人限兑换一次", attributes: [NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_666666_Color)!])
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.reactive.continuousTextValues.observeValues { (str) in
            self.myInvitationViewMode.shareCode = str!
        }
        textField.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        self.view.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
            make.top.equalTo(self.view.snp.top).offset(75)
        }
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 52, y: 120, width: SCREENWIDTH - 104, height: 0.5))
        self.view.addSubview(lineLabel)
        
        conversionBtn = CustomButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200)/2, y: 150, width: 200, height: 46), title: "兑换邀请码", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder) { (tag) in
            self.myInvitationViewMode.requestShareCode()
        }
        self.view.addSubview(conversionBtn)
        
        myInvitation = UILabel.init()
        myInvitation.text = "我的邀请码：\(UserInfoModel.shareInstance().shareCode!)"
        myInvitation.font = App_Theme_PinFan_M_18_Font
        myInvitation.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        self.view.addSubview(myInvitation)
        GLoabelViewLabel.addLabel(label: myInvitation, view: self.view, isWithNumber: false)
        myInvitation.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.conversionBtn.snp.bottom).offset(100)
        }
        
        invitationLabel = UILabel.init()
        invitationLabel.text = "通过我的邀请下载并登录的新用户，在上面的邀码\n输入框内输入我的邀请码并点击兑换，我即\n可得到60个娃娃币的奖励，上不封顶。"
        UILabel.changeSpace(for: invitationLabel, withLineSpace: 2.5, wordSpace: 0)
        invitationLabel.textAlignment = .center
        invitationLabel.font = App_Theme_PinFan_R_14_Font
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
            if self.myInvitationViewMode.model != nil {
                KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, title: "每邀请一个好朋友，最高奖200娃娃币", clickClouse: { (type) in
                    
                    switch type {
                    case .QQChat:
                        ShareTools.shareInstance.shareQQSessionWebUrl(self.myInvitationViewMode.model.title, webTitle: self.myInvitationViewMode.model.descriptionField, imageUrl: self.myInvitationViewMode.model.thumbnailAddress, webDescription: "", webUrl: self.myInvitationViewMode.model.url)
                    case .weChatChat:
                        ShareTools.shareInstance.shareWeChatSession(self.myInvitationViewMode.model.title, description: self.myInvitationViewMode.model.descriptionField, image: UIImage.getFromURL(self.myInvitationViewMode.model.thumbnailAddress), url: self.myInvitationViewMode.model.url)
                    case .weChatSession:
                        ShareTools.shareInstance.shareWeChatTimeLine(self.myInvitationViewMode.model.title, description: self.myInvitationViewMode.model.descriptionField, image: UIImage.getFromURL(self.myInvitationViewMode.model.thumbnailAddress), url: self.myInvitationViewMode.model.url)
                    default:
                        break
                    }
                }))
            }
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
