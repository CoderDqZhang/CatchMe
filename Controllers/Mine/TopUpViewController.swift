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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: TopUpViewModel.init(), controller: self)
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
        balance = UILabel.init()
//        balance.text = "账户余额 \(UserInfoModel.shareInstance().coinAmount!) 币"
         balance.text = "账户余额 30 币"
        let strArray = balance.text?.components(separatedBy: " ")
        let attributedString = NSMutableAttributedString.init(string: balance.text!)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_20_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: 0, length: strArray![0].count))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_20_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: (balance.text?.length)! - 1, length: 1))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: strArray![0].count + 1, length: strArray![1].count))
        balance.attributedText = attributedString
        self.view.addSubview(balance)
        GLoabelViewLabel.addLabel(label: balance, view: self.view)
        balance.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(30)
        }
    }
    
    func setUpPayButton(){
        let payView = UIView.init(frame: CGRect.init(x: 0, y: 382, width: SCREENWIDTH, height: SCREENHEIGHT - 382))
        self.view.addSubview(payView)
        if WXApi.isWXAppInstalled() {
            let weixinPay = UIButton.init(type: .custom)
            weixinPay.setImage(UIImage.init(named: "wechat_pay"), for: .normal)
            weixinPay.backgroundColor = UIColor.init(hexString: App_Theme_41B035_Color)
            weixinPay.setTitle("微信支付", for: .normal)
            weixinPay.layer.cornerRadius = 23
            weixinPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
            weixinPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
            weixinPay.reactive.controlEvents(.touchUpInside).observe { (active) in
                (self.viewModel as! TopUpViewModel).wxPay()
            }
            payView.addSubview(weixinPay)
            weixinPay.snp.makeConstraints { (make) in
                make.top.equalTo(payView.snp.top).offset(0)
                make.centerX.equalTo(self.view.snp.centerX).offset(0)
                make.size.equalTo(CGSize.init(width: 220, height: 46))
            }
        }
        let aliPay = UIButton.init(type: .custom)
        aliPay.setImage(UIImage.init(named: "ali_pay"), for: .normal)
        aliPay.backgroundColor = UIColor.init(hexString: App_Theme_009FE8_Color)
        aliPay.setTitle("支付宝支付", for: .normal)
        aliPay.layer.cornerRadius = 23
        aliPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        aliPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
        aliPay.reactive.controlEvents(.touchUpInside).observe { (active) in
            (self.viewModel as! TopUpViewModel).aliPay()
        }
        payView.addSubview(aliPay)
        aliPay.snp.makeConstraints { (make) in
            make.top.equalTo(payView.snp.top).offset(77)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 220, height: 46))
        }
    }
    
    func setUpTopView(){
        topUpMuchView = TopUpMuchView.init(frame: CGRect.init(x: 0, y: 96, width: SCREENWIDTH, height: 220), models:(self.viewModel as! TopUpViewModel).models)
        topUpMuchView.topUpMuchViewClouse = { tag in
            (self.viewModel as! TopUpViewModel).topUpMuch = tag
        }
        self.view.addSubview(topUpMuchView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "娃娃币充值"
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
