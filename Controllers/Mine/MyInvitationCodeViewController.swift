
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
    
    var conversionBtn:CustomTouchButton!
    
    var myInvitation:UILabel!
    var invitationLabel:UILabel!
    var myInvitationCode:UILabel!
    var sharBtn:UIButton!
    
    var myInvitationViewMode = MyInvitationCodeViewModel()
    
    var scollerView:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "邀请兑换"
        self.bindLogicViewModel()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        // Do any additional setup after loading the view.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "邀请兑换"
    }
    
    func bindLogicViewModel(){
        self.myInvitationViewMode.controller = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
    }
    
    override func backBtnPress(_ sender: UIButton) {
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
        if isFormHomeVC {
            self.dismiss(animated: false, completion: {
                
            })
        }else{
            self.navigationController?.popViewController()
        }
    }
    
    override func setUpView() {
        scollerView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        scollerView.contentSize = CGSize.init(width: SCREENWIDTH, height: 667)
        self.view.addSubview(scollerView)
        
        textField = UITextField.init()
        textField.placeholder = "请输入朋友邀请码"
        textField.font = App_Theme_PinFan_M_30_Font
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入朋友邀请码", attributes: [NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_666666_Color)!])
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.reactive.continuousTextValues.observeValues { (str) in
            self.myInvitationViewMode.shareCode = str!
        }
        textField.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        scollerView.addSubview(textField)
        
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(scollerView.snp.centerX).offset(0)
            make.left.equalTo(scollerView.snp.left).offset(10)
            make.right.equalTo(scollerView.snp.right).offset(-10)
            make.top.equalTo(scollerView.snp.top).offset(75)
        }
        
        lineLabel = GloabLineView.init(frame: CGRect.init(x: 52, y: 120, width: SCREENWIDTH - 104, height: 0.5))
        lineLabel.setLineColor(UIColor.init(hexString: App_Theme_EEEEEE_Color))
        self.view.addSubview(lineLabel)
        
        conversionBtn = CustomTouchButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200)/2, y: 150, width: 200, height: 46), title: "兑换娃娃币", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder) { (tag) in
            self.myInvitationViewMode.requestShareCode()
        }
        scollerView.addSubview(conversionBtn)
        
        let invitationView = UIView.init()
        scollerView.addSubview(invitationView)
        
        let leftLabel = UIImageView.init()
        leftLabel.image = UIImage.init(named: "left_label")
        invitationView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(invitationView.snp.left).offset(0)
            make.centerY.equalTo(invitationView.snp.centerY).offset(0)
        }
        
        myInvitation = UILabel.init()
        myInvitation.text = "我的邀请码:"
        myInvitation.font = App_Theme_PinFan_M_18_Font
        myInvitation.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        invitationView.addSubview(myInvitation)
        myInvitation.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right).offset(4)
            make.top.equalTo(invitationView.snp.top).offset(0)
        }
        
        myInvitationCode = UILabel.init()
        myInvitationCode.text = "\(UserInfoModel.shareInstance().shareCode!)"
        myInvitationCode.font = App_Theme_PinFan_M_20_Font
        myInvitationCode.textColor = UIColor.init(hexString: App_Theme_000000_Color)
        invitationView.addSubview(myInvitationCode)
        myInvitationCode.snp.makeConstraints { (make) in
            make.left.equalTo(myInvitation.snp.right).offset(0)
            make.top.equalTo(invitationView.snp.top).offset(-1)
        }
        
        let rihgtLabel = UIImageView.init()
        rihgtLabel.image = UIImage.init(named: "left_label")
        invitationView.addSubview(rihgtLabel)

        rihgtLabel.snp.makeConstraints { (make) in
            make.left.equalTo(myInvitationCode.snp.right).offset(4)
            make.centerY.equalTo(invitationView.snp.centerY).offset(0)
        }
        
        invitationView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.conversionBtn.snp.bottom).offset(97)
            make.size.equalTo(CGSize.init(width: 200, height: 20))
        }
        
        invitationLabel = UILabel.init()
        invitationLabel.text = "邀请朋友来抓我，朋友兑换一次我的邀请码，\n立即奖励我和朋友每人最高200娃娃币"
        UILabel.changeSpace(for: invitationLabel, withLineSpace: 4.5, wordSpace: 0)
        invitationLabel.textAlignment = .center
        invitationLabel.font = App_Theme_PinFan_R_14_Font
        invitationLabel.numberOfLines = 0
        invitationLabel.textColor = UIColor.init(hexString: App_Theme_888888_Color)
        scollerView.addSubview(invitationLabel)
        
        invitationLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.left.equalTo(self.view.snp.left).offset(40)
            make.right.equalTo(self.view.snp.right).offset(-40)
            make.top.equalTo(self.myInvitation.snp.bottom).offset(13)
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
        
        scollerView.addSubview(sharBtn)
        sharBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.invitationLabel.snp.bottom).offset(13)
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
