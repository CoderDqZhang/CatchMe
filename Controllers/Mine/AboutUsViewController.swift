//
//  AboutUsViewController.swift
//  CatchMe
//
//  Created by Zhang on 23/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    var logoImage:UIImageView!
    var aboutLabel:UILabel!
    var bottomImage:UIImageView!
    var proLabel:UILabel!
    var versionLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpView() {
        logoImage = UIImageView.init()
        logoImage.layer.cornerRadius = 10
        logoImage.layer.masksToBounds = true
        logoImage.image = UIImage.init(named: "logo+text")
        self.view.addSubview(logoImage)
        
        aboutLabel = UILabel.init()
        aboutLabel.font = App_Theme_PinFan_M_15_Font
        aboutLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        aboutLabel.text = "主人，带我回家吧"
        self.view.addSubview(aboutLabel)
        GLoabelViewLabel.addLabel(label: aboutLabel, view: self.view, isWithNumber: false)

        
        bottomImage = UIImageView.init()
        bottomImage.image = UIImage.init(named: "pic_about")
        self.view.addSubview(bottomImage)
        
        proLabel = UILabel.init()
        proLabel.font = App_Theme_PinFan_R_13_Font
        proLabel.numberOfLines = 0
        proLabel.textColor = UIColor.init(hexString: App_Theme_CCCCCC_Color)
        proLabel.text = "Copyright © 2017 All Rights Reserved\n湖南赤子精和信息科技有限公司 "
        UILabel.changeLineSpace(for: proLabel, withSpace: 4.0)
        proLabel.textAlignment = .center
        self.view.addSubview(proLabel)
        
        versionLabel = UILabel.init()
        versionLabel.font = App_Theme_PinFan_R_15_Font
        versionLabel.textColor = UIColor.init(hexString: App_Theme_333333_Color)
        versionLabel.text = "V\(APPVERSION)"
        self.view.addSubview(versionLabel)
        
        self.makeConstraints()
    
    }
    
    func makeConstraints(){
        logoImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(84)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImage.snp.bottom).offset(16)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }

        
        bottomImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
        proLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-154)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        versionLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(proLabel.snp.top).offset(-7)
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "关于我们"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "联系我们", style: .plain, target: self, action: #selector(self.rightBarButtonPress))
    }

    @objc func rightBarButtonPress(){
        if KWINDOWDS().viewWithTag(GloabelShareAndConnectUsTag) == nil {
            KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: .connectUs, title: "联系我们", clickClouse: { (type) in
                switch type {
                case .weChatService:
                    UIPasteboard.general.string = "111"
                    _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "已帮您复制微信号，请打开微信联系微信客服", autoHidder: true)
                    break;
                case .phoneCall:
                    AppCallViewShow(self.view, phone: "4006005355")
                case .QQService:
                    self.openQQChat(str: "769839948")
                    break;
                default:
                    break;
                }
            }))
        }
    }
    
    func openQQChat(str:String){
        let webView = UIWebView.init(frame: CGRect.zero)
        let url = URL.init(string: "mqq://im/chat?chat_type=wpa&uin=\(str)&version=1&src_type=web")
        let request = NSURLRequest.init(url: url!)
        webView.delegate = self
        webView.loadRequest(request as URLRequest)
        self.view.addSubview(webView)
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

extension AboutUsViewController : UIWebViewDelegate {
    
}
