//
//  TopUpViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopUpViewController: BaseViewController {

    var balance:UILabel!
    var topUpView:UIView!
    var iconDesc:UILabel!
    var otherBalance:UILabel!
    var line:GloabLineView!
    var topUpMuchView:TopUpMuchView!
    var topUpWeekView:TopUpWeekView!
    
    var scllocView:UIScrollView!
    
    var isPlayGameView:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: TopUpViewModel(), controller: self)
        self.setUpPayButton()
        self.setUpBindLogic()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBindLogic(){
        (self.viewModel as! TopUpViewModel).requestTopUp()
    }
    
    override func setUpView() {
        scllocView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        scllocView.contentSize = CGSize.init(width: SCREENWIDTH, height: 667)
        self.view.addSubview(scllocView)
        
        balance = UILabel.init()
        let str = UserInfoModel.shareInstance().coinAmount != nil ? UserInfoModel.shareInstance().coinAmount : "0"
        self.setBalanceText(str:str!)
        scllocView.addSubview(balance)
        GLoabelViewLabel.addLabel(label: balance, view: self.view, isWithNumber: true)
        balance.snp.makeConstraints { (make) in
            make.centerX.equalTo(scllocView.snp.centerX).offset(0)
            make.top.equalTo(scllocView.snp.top).offset(23)
        }
        LoginViewModel.shareInstance.getUserInfoCoins { (userInfo) in
            self.setBalanceText(str: userInfo.coinAmount)
        }
    }
    
    func setBalanceText(str:String){
        balance.text = "账户余额 \(str) 币"
        let strArray = balance.text?.components(separatedBy: " ")
        let attributedString = NSMutableAttributedString.init(string: balance.text!)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: 0, length: strArray![0].count))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: (balance.text?.length)! - 1, length: 1))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: strArray![0].count + 1, length: strArray![1].count))
        balance.attributedText = attributedString
    }
    
    func setUpPayButton(){
        let payView = UIView.init(frame: CGRect.init(x: 0, y: 448, width: SCREENWIDTH, height: SCREENHEIGHT - 382))
        scllocView.addSubview(payView)
        if WXApi.isWXAppInstalled() {
            let weChatPayView = AnimationTouchView.init(frame: CGRect.zero) {
                (self.viewModel as! TopUpViewModel).wxPay()
            }
            payView.addSubview(weChatPayView)
            let weixinPay = UIButton.init(type: .custom)
            
            weixinPay.setImage(UIImage.init(named: "wechat_pay"), for: .normal)
            weixinPay.backgroundColor = UIColor.init(hexString: App_Theme_41B035_Color)
            weixinPay.setTitle(" 微信支付", for: .normal)
            weixinPay.layer.cornerRadius = 23
            weixinPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
            weixinPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
            
            let backImage = UIImageView.init()
            backImage.backgroundColor = UIColor.init(hexString: App_Theme_D0F2CC_Color)
            backImage.layer.cornerRadius = 23
            backImage.layer.masksToBounds = true
            weChatPayView.addSubview(backImage)
            weChatPayView.addSubview(weixinPay)
            backImage.snp.makeConstraints { (make) in
                make.top.equalTo(weChatPayView.snp.top).offset(2)
                make.left.equalTo(weChatPayView.snp.left).offset(0)
                make.size.equalTo(CGSize.init(width: 220, height: 46))
            }
            weixinPay.snp.makeConstraints { (make) in
                make.top.equalTo(weChatPayView.snp.top).offset(0)
                make.left.equalTo(weChatPayView.snp.left).offset(0)
                make.size.equalTo(CGSize.init(width: 220, height: 46))
            }
            
            weChatPayView.snp.makeConstraints { (make) in
                make.top.equalTo(payView.snp.top).offset(0)
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 220, height: 48))
            }
        }
        
        let aliPayView = AnimationTouchView.init(frame: CGRect.zero) {
            (self.viewModel as! TopUpViewModel).aliPay()
        }
        payView.addSubview(aliPayView)
        
        let backImage = AnimationButton.init(type: .custom)
        backImage.backgroundColor = UIColor.init(hexString: App_Theme_CDEFFF_Color)
        backImage.layer.cornerRadius = 23
        backImage.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        backImage.titleLabel?.font = App_Theme_PinFan_M_17_Font
        aliPayView.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.equalTo(aliPayView.snp.top).offset(2)
            make.left.equalTo(aliPayView.snp.left).offset(0)
            make.size.equalTo(CGSize.init(width: 220, height: 46))
        }
        
        let aliPay = UIButton.init(type: .custom)
        aliPay.setImage(UIImage.init(named: "ali_pay"), for: .normal)
        aliPay.backgroundColor = UIColor.init(hexString: App_Theme_009FE8_Color)
        aliPay.setTitle(" 支付宝支付", for: .normal)
        aliPay.layer.cornerRadius = 23
        aliPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        aliPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
        aliPayView.addSubview(aliPay)
        aliPay.snp.makeConstraints { (make) in
            make.top.equalTo(aliPayView.snp.top).offset(0)
            make.left.equalTo(aliPayView.snp.left).offset(0)
            make.size.equalTo(CGSize.init(width: 220, height: 46))
        }
        
        aliPayView.snp.makeConstraints { (make) in
            make.top.equalTo(payView.snp.top).offset(66)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 220, height: 48))
        }
    }
    
    func setUpTopView(){
        topUpMuchView = TopUpMuchView.init(frame: CGRect.init(x: 0, y: 184, width: SCREENWIDTH, height: 220), models: nil, model: (self.viewModel as! TopUpViewModel).models.rechargeRateRuleDTOList)
        topUpMuchView.topUpMuchViewClouse = { tag in
            (self.viewModel as! TopUpViewModel).topUpMuch = tag
            self.topUpWeekView.changeWeekViewType()
        }
        scllocView.addSubview(topUpMuchView)
    }
    
    func setUpWeekView(){
        topUpWeekView = TopUpWeekView.init(frame: CGRect.init(x: 20, y: 87, width: SCREENWIDTH - 40, height: 72))
        topUpWeekView.setData(model: (self.viewModel as! TopUpViewModel).models.weeklyRechargeRateRuleDTO)
        topUpWeekView.topUpMuchViewClouse = { tag in
            (self.viewModel as! TopUpViewModel).topUpMuch = tag
            self.topUpMuchView.changeAllTag()
        }
        scllocView.addSubview(topUpWeekView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "娃娃币充值"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "消费明细", style: .plain, target: self, action: #selector(self.rightBarItem))
    }
    
    @objc func rightBarItem(){
        let controllerVC = BaseWebViewController()
        controllerVC.url = "\(ConsumptionUrl)?uid=\(UserInfoModel.shareInstance().idField!)&token=\(UserInfoModel.shareInstance().token!)"
        NavigationPushView(self, toConroller: controllerVC)
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
