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
    var url:String = ""
    var bannerModel:BannerModel!
    var model:SessionShareModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getShareCodeInfo()
        
        if bannerModel != nil {
            let urls = self.bannerModel.linkAddress.components(separatedBy: "url=")
            self.url = urls[1].removingPercentEncoding! as String
        }
        
        webView = WKWebView(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - 64))
        webView.load(URLRequest.init(url: URL.init(string:url)!))
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func backBtnPress(_ sender: UIButton) {
        if isFormHomeVC {
            self.dismiss(animated: false, completion: {
                
            })
        }else{
            self.navigationController?.popViewController()
        }
    }
    
    override func setUpViewNavigationItem() {
//        self.navigationItem.title = bannerModel != nil ? bannerModel.title : "炫耀一下"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "分享", style: .plain, target: self, action: #selector(self.rightBarItemPress))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rightBarItemPress(){
        if self.model != nil {
            KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, title: "每邀请一个好朋友，最高奖200娃娃币", clickClouse: { (type) in
                
                switch type {
                case .QQChat:
                    ShareTools.shareInstance.shareQQSessionWebUrl(self.model.title, webTitle: self.model.descriptionField, imageUrl: self.model.thumbnailAddress, webDescription: "", webUrl: self.model.url)
                case .weChatChat:
                    ShareTools.shareInstance.shareWeChatSession(self.model.title, description: self.model.descriptionField, image: UIImage.getFromURL(self.model.thumbnailAddress), url: self.model.url)
                case .weChatSession:
                    ShareTools.shareInstance.shareWeChatTimeLine(self.model.title, description: self.model.descriptionField, image: UIImage.getFromURL(self.model.thumbnailAddress), url: self.model.url)
                default:
                    break
                }
            }))
        }
    }
    
    
    func getShareCodeInfo(){
        let parameters = ["type":"0"]
        BaseNetWorke.sharedInstance.getUrlWithString(Socialsharecard, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = SessionShareModel.init(fromDictionary: resultDic.value as! NSDictionary)
            }
        }
    }
}

extension BaseWebViewController : WKNavigationDelegate {
   
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
    }
    
    
    /*! @abstract Decides whether to allow or cancel a navigation after its
     response is known.
     @param webView The web view invoking the delegate method.
     @param navigationResponse Descriptive information about the navigation
     response.
     @param decisionHandler The decision handler to call to allow or cancel the
     navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
     @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        
    }
    
    
    /*! @abstract Invoked when a main frame navigation starts.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    
    /*! @abstract Invoked when a server redirect is received for the main
     frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    
    /*! @abstract Invoked when an error occurs while starting to load data for
     the main frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     @param error The error that occurred.
     */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    
    /*! @abstract Invoked when content starts arriving for the main frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    
    /*! @abstract Invoked when a main frame navigation completes.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        
    }
    
    
    /*! @abstract Invoked when an error occurs during a committed main frame
     navigation.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     @param error The error that occurred.
     */
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    
    /*! @abstract Invoked when the web view needs to respond to an authentication challenge.
     @param webView The web view that received the authentication challenge.
     @param challenge The authentication challenge.
     @param completionHandler The completion handler you must invoke to respond to the challenge. The
     disposition argument is one of the constants of the enumerated type
     NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
     the credential argument is the credential to use, or nil to indicate continuing without a
     credential.
     @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
     */
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        
    }
    
    
    /*! @abstract Invoked when the web view's web content process is terminated.
     @param webView The web view whose underlying web content process was terminated.
     */
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

//extension BaseWebViewController : WKUIDelegate {
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//
//    }
//}

