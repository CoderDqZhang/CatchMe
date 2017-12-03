//
//  InPurchaseViewController.swift
//  CatchMe
//
//  Created by Zhang on 29/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import StoreKit
import MBProgressHUD

class InPurchaseViewController: BaseViewController {

    var balance:UILabel!
    var topUpView:UIView!
    var iconDesc:UILabel!
    var otherBalance:UILabel!
    var line:GloabLineView!
    var topUpMuchView:TopUpMuchView!
    var productI:Int = 1
    var coinAmount:Int = 0
    var loadingView:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        SKPaymentQueue.default().add(self)
        
        self.setUpTopView()
        self.setUpPayButton()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    override func setUpView() {
        balance = UILabel.init()
        let str = UserInfoModel.shareInstance().coinAmount != nil ? UserInfoModel.shareInstance().coinAmount : "0"
        self.coinAmount = (str! as NSString).integerValue
        balance.text = "账户余额 \(str!) 币"
        self.updateBalance(text: balance.text!)
        self.view.addSubview(balance)
        GLoabelViewLabel.addLabel(label: balance, view: self.view)
        balance.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.top.equalTo(self.view.snp.top).offset(30)
        }
    }
    
    func updateBalance(text:String){
        let strArray = balance.text?.components(separatedBy: " ")
        let attributedString = NSMutableAttributedString.init(string: balance.text!)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_20_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: 0, length: strArray![0].count))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_20_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_333333_Color)!], range: NSRange.init(location: (balance.text?.length)! - 1, length: 1))
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_24_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FC4652_Color)!], range: NSRange.init(location: strArray![0].count + 1, length: strArray![1].count))
        balance.attributedText = attributedString
    }
    
    func setUpTopView(){
        topUpMuchView = TopUpMuchView.init(frame: CGRect.init(x: 0, y: 96, width: SCREENWIDTH, height: 220), models:self.createTopUpModel())
        topUpMuchView.topUpMuchViewClouse = { tag in
            self.productI = tag
        }
        self.view.addSubview(topUpMuchView)
    }
    
    func createTopUpModel() ->NSMutableArray{
        let models = NSMutableArray.init()
        let coins = [100,300,3000]
        let rechargeMoney:[Float] = [6.00,12.00,98.00]
        for i in 0...2 {
            let model = TopUpModel.init()
            model.rechargeCoin = coins[i]
            model.rechargeMoney = rechargeMoney[i]
            models.add(model)
        }
        return models
    }
    
    func setUpPayButton(){
        let payView = UIView.init(frame: CGRect.init(x: 0, y: 382, width: SCREENWIDTH, height: SCREENHEIGHT - 382))
        self.view.addSubview(payView)
        let aliPay = UIButton.init(type: .custom)
        aliPay.backgroundColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        aliPay.setTitle("充值", for: .normal)
        aliPay.layer.cornerRadius = 23
        aliPay.setTitleColor(UIColor.init(hexString: App_Theme_FFFFFF_Color), for: .normal)
        aliPay.titleLabel?.font = App_Theme_PinFan_M_17_Font
        aliPay.reactive.controlEvents(.touchUpInside).observe { (active) in
            self.requestPayMent()
        }
        payView.addSubview(aliPay)
        aliPay.snp.makeConstraints { (make) in
            make.top.equalTo(payView.snp.top).offset(77)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
            make.size.equalTo(CGSize.init(width: 220, height: 46))
        }
    }
    
    func requestPayMent(){
        if SKPaymentQueue.canMakePayments() {
            loadingView = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "加载中")
            self.requestProduceData()
        }else{
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "不允许内购", autoHidder: true)
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //请求内购
    func requestProduceData() {
        let str = NSSet.init(array: ["com.zhuawo.catchdoll06","com.zhuawo.catchdoll12","com.zhuawo.catchdoll98"])
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
        if loadingView != nil {
            loadingView.hide(animated: true)
        }
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
        SKPaymentQueue.default().finishTransaction(transaction)
        
//        viewModel.rejectUrlforAppStore(jsonStr, successBlock: { (dic) in
//            print("\(dic?["success"])")
//        }, fail: { (dic) in
//            print("支付失败")
//        })
    }
    
    
    func failedTransaction(transaction:SKPaymentTransaction){
        print("失败");
        //        if (transaction.error != SKError.paymentCancelled)
        //        {
        //
        //        }
        SKPaymentQueue.default().finishTransaction(transaction)
        
    }

}

extension InPurchaseViewController : SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("--------paymentQueue")
        for trannsaction in transactions {
            switch trannsaction.transactionState {
            case .purchased:
                print("支付完成")
                let str = self.coinAmount + self.productI == 1 ? 100 : self.productI == 2 ? 300 : 3000
                self.updateBalance(text: "账户余额 \(str) 币")
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
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
        
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("回复交易")
    }

}

extension InPurchaseViewController : SKProductsRequestDelegate {
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
            if loadingView != nil {
                loadingView.hide(animated: true)
            }
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
