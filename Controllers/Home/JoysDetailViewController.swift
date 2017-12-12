//
//  JoysDetailViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import WebKit

class JoysDetailViewController: BaseViewController {

    var url:String = ""
    var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
        webView.load(URLRequest.init(url: URL.init(string: url)!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "娃娃详情"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: .plain, target: self, action: #selector(JoysDetailViewController.rightBarItemPress))
    }
    
    @objc func rightBarItemPress(){
        KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, title: "每邀请一个好朋友，最高奖200娃娃币", clickClouse: { (type) in
            switch type {
            case .QQChat:
                ShareTools.shareInstance.shareQQSessionWebUrl("抓我 – 朋友一起抓，娃娃带回家", webTitle: "手机抓娃娃，快递送到家。注册最高奖200娃娃币，可以抓十次！", imageUrl: "", webDescription: "", webUrl: self.url)
            case .weChatChat:
                ShareTools.shareInstance.shareWeChatSession("抓我 – 朋友一起抓，娃娃带回家", description: "手机抓娃娃，快递送到家。注册最高奖200娃娃币，可以抓十次！", image: UIImage.init(named: "pic_about")!, url: self.url)
            case .weChatSession:
                ShareTools.shareInstance.shareWeChatTimeLine("抓我 – 朋友一起抓，娃娃带回家", description: "手机抓娃娃，快递送到家。注册最高奖200娃娃币，可以抓十次！", image: UIImage.init(named: "pic_about")!, url: self.url)
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
