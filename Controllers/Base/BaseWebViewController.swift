//
//  BaseWebViewController.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: BaseViewController {

    var webView:WKWebView!
    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
        webView.load(URLRequest.init(url: URL.init(string: url)!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "炫耀一下"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: .plain, target: self, action: #selector(self.rightBarItemPress))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rightBarItemPress(){
        KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, clickClouse: { (type) in
            switch type {
            case .QQChat:
                ShareTools.shareInstance.shareQQSessionWebUrl("", webTitle: "", imageUrl: self.url, webDescription: "", webUrl: "")
            case .weChatChat:
                ShareTools.shareInstance.shareWeChatSession("", description: "", image: UIImage.init(named: "pic_about")!, url: self.url)
            case .weChatSession:
                ShareTools.shareInstance.shareWeChatTimeLine("", description: "", image: UIImage.init(named: "pic_about")!, url: self.url)
            default:
                break
            }
        }))
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
