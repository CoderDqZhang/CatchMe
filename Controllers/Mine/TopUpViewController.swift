//
//  TopUpViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import StoreKit
import MBProgressHUD

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
    
    var loadingView:MBProgressHUD!
    
    var pruductID = NSMutableArray.init()
    
    var productI:Int = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "娃娃币充值页面"
        self.bindViewModel(viewModel: TopUpViewModel(), controller: self)
        self.setUpPayButton()
        self.setUpBindLogic()
        SKPaymentQueue.default().add(self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    func setUpBindLogic(){
        (self.viewModel as! TopUpViewModel).requestTopUp()
    }
    
    override func backBtnPress(_ sender: UIButton) {
        if isFormHomeVC {
            self.dismiss(animated: false, completion: {
                
            })
        }else{
            self.navigationController?.popViewController()
        }
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
        let strs = "账户余额 \(str) 币"
        let strArray = strs.components(separatedBy: " ")
        let attributedString = NSMutableAttributedString.init(string: strs)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: 0, length: strArray[0].count))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_14_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: (strs.length) - 1, length: 1))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: strArray[0].count + 1, length: strArray[1].count))
        balance.attributedText = attributedString
        self.view.updateConstraintsIfNeeded()
    }
    
    func setUpPayButton(){
        let payView = UIView.init(frame: CGRect.init(x: 0, y: 448, width: SCREENWIDTH, height: SCREENHEIGHT - 382))
        scllocView.addSubview(payView)
        if WXApi.isWXAppInstalled() {
            let weChatPayView = AnimationTouchView.init(frame: CGRect.zero) {
                (self.viewModel as! TopUpViewModel).getOrderInPurchase()
            }
            payView.addSubview(weChatPayView)
            let weixinPay = UIButton.init(type: .custom)
            
                weixinPay.setImage(UIImage.init(named: "wechat_pay"), for: .normal)
            weixinPay.backgroundColor = UIColor.init(hexString: App_Theme_41B035_Color)
    //        weixinPay.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
            weixinPay.setTitle(" 微信支付", for: .normal)
            weixinPay.layer.cornerRadius = 23
            weixinPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
            weixinPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
            
            let backImage = UIImageView.init()
            backImage.backgroundColor = UIColor.init(hexString: App_Theme_D0F2CC_Color)
            backImage.backgroundColor = UIColor.init(hexString: App_Theme_FEE3E5_Color)
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
            self.productI = tag
            (self.viewModel as! TopUpViewModel).topUpMuch = tag
            self.topUpWeekView.changeWeekViewType()
        }
        scllocView.addSubview(topUpMuchView)
    }
    
    func setUpWeekView(){
        topUpWeekView = TopUpWeekView.init(frame: CGRect.init(x: 20, y: 87, width: SCREENWIDTH - 40, height: 72))
        topUpWeekView.setData(model: (self.viewModel as! TopUpViewModel).models.weeklyRechargeRateRuleDTO)
        topUpWeekView.topUpMuchViewClouse = { tag in
            self.productI = tag
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "消费记录", style: .plain, target: self, action: #selector(self.rightBarItem))
    }
    
    @objc func rightBarItem(){
        let controllerVC = BaseWebViewController()
        controllerVC.navigationItem.title = "消费记录"
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
    
    //请求内购
    func requestProduceData(model:TopUpModel) {
        loadingView = Tools.shareInstance.showLoading(KWINDOWDS(), msg: nil)
        for product in model.rechargeRateRuleDTOList {
            pruductID.add("\(product.id!)")
        }
        pruductID.add("\(model.weeklyRechargeRateRuleDTO.id!)")
        let str = NSSet.init(array: pruductID as! [Any])
        let request = SKProductsRequest(productIdentifiers: str as! Set<String>)
        request.delegate = self
        request.start()
    }
    
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("------弹出错误信息--------")
        UIAlertController.shwoAlertControl(self, style: .alert, title: "请退出APP Store账号测试", message: nil, cancel: nil, doneTitle: "确定", cancelAction: {
            
        }) {
            
        }
        if loadingView != nil {
            loadingView.hide(animated: true)
        }
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("----------反馈信息结束--------------")
    }
    
    func purchasedTransaction(transaction:SKPaymentTransaction) {
        print("-----PurchasedTransaction----")
        let transactions = NSArray(object: transaction)
        self.paymentQueue(SKPaymentQueue.default(), updatedTransactions: transactions as! [SKPaymentTransaction])
    }
    
    
    func completeTransaction(transaction:SKPaymentTransaction) {
        print("-----completeTransaction--------");
        // Your application should implement these two methods.
//        let jsonObjectString = transaction.original.
//         NSString* jsonObjectString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
        let rejectUrl = NSData.init(contentsOf:Bundle.main.appStoreReceiptURL!)
        let jsonStr = rejectUrl?.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        print(jsonStr ?? "")
        if loadingView != nil {
            loadingView.hide(animated: true)
        }
        SKPaymentQueue.default().finishTransaction(transaction)
        (self.viewModel as! TopUpViewModel).rechargeAppPay(rejectStr: jsonStr!)
    }
    
    
    func failedTransaction(transaction:SKPaymentTransaction){
        print("失败");
        if loadingView != nil {
            loadingView.hide(animated: true)
        }
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }

}

extension TopUpViewController : SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("--------paymentQueue")
        for trannsaction in transactions {
            switch trannsaction.transactionState {
            case .purchased:
                print("支付完成")
                self.completeTransaction(transaction: trannsaction)
            case .failed:
                print("支付失败")
                self.failedTransaction(transaction: trannsaction)
            case .restored:
                print("已经购买过此商品")
                self.completeTransaction(transaction: trannsaction)
            case .purchasing:
                print("商品添加进列表")
            default:
                break;
            }
        }
        
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("交易完成")
        if loadingView != nil {
            loadingView.hide(animated: true)
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
        
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("回复交易")
    }
    
}

extension TopUpViewController : SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("-------收到产品反馈信息----------")
        let myProduct = response.products
        print("产品Product ID:\(response.invalidProductIdentifiers)")
        print("产品付费数量:\(myProduct.count)")
        for product in myProduct {
            print("product info");
            print("SKProduct 描述信息\(product.description)");
            print("产品标题 \(product.localizedTitle)");
            print("产品描述信息: \(product.localizedDescription)");
            print("价格: \(product.price)");
            print("Product id: \(product.productIdentifier)");
        }
        
        if myProduct.count > 0 {
            print("发送购买请求")
//            if loadingView != nil {
//                loadingView.hide(animated: true)
//            }
            let payment = SKPayment.init(product: myProduct[self.productI - 1])
            SKPaymentQueue.default().add(payment)
        }else{
            if loadingView != nil {
                loadingView.hide(animated: true)
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "内购失败，产品数量为0", autoHidder: true)
            }
        }
    }
}

