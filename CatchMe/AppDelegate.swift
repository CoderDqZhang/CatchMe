//
//  AppDelegate.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import NIMSDK
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {

    var window: UIWindow?
    var manager: NeteaseManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        PgyManager.shared().start(withAppId: PGYAPPKEY)
        UMengManager.shareInstance.setUpUMengManger(application, didFinishLaunchingWithOptions: launchOptions)
        PlusButtonSubclass.register()
        AppleThemeTool.setUpToolBarColor()
        AppleThemeTool.setUpKeyBoardManager()
        //分享控制器
        _ = ShareManager.init()
        if UserDefaultsGetSynchronize(MUISCCOGIF) as! String == "nil" {
            UserDefaultsSetSynchronize("true" as AnyObject, key: MUISCCOGIF)
        }
        //网易云控制器
        manager = NeteaseManager.init()
        self.setUpMainViewContr()
        self.window?.makeKeyAndVisible()
        self.window?.addSubview(SpalshView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)))
        // Override point for customization after application launch.
        return true
    }
    
    func setUpMainViewContr(){
        if UserInfoModel.isLoggedIn() {
            manager.setAutoLogin()
            self.window?.rootViewController = MainTabBarViewController()
        }else{
            self.setUpLoginViewController()
        }
    }
    
    func setUpLoginViewController(){
        let loginVC = UINavigationController.init(rootViewController: LoginTypeViewController())
        self.window?.rootViewController = loginVC
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if url.host == "response_from_qq" {
            Notification(NotificationPlayMusic, value: "分享回调音乐播放")
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "pay" {
            return WXApi.handleOpen(url, delegate: self)
        }
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        
        if url.host == "response_from_qq" {
            Notification(NotificationPlayMusic, value: "分享回调音乐播放")
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "oauth" {
            return WXApi.handleOpen(url, delegate: self)
        }
        
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
       
        if url.host == "response_from_qq" {
            Notification(NotificationPlayMusic, value: "分享回调音乐播放")
            return TencentOAuth.handleOpen(url)
        }
        if url.host == "platformId=wechat" || url.host == "oauth" {
            return WXApi.handleOpen(url, delegate: self)
        }
        return WeiboSDK.handleOpen(url, delegate: self)
    }
    //MARK: 微博SDKDelegate
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if response is WBShareMessageToContactResponse {
            print(response.statusCode)
        }
    }
}

extension AppDelegate : WXApiDelegate {
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        if resp is SendMessageToWXResp {
            Notification(NotificationPlayMusic, value: "分享回调音乐播放")
            switch resp.errCode {
            case -2:
                MainThreadAlertShow("取消分享", view: KWINDOWDS())
            default:
                break;
            }
        }else if resp is SendAuthResp {
            switch resp.errCode {
                case 0 :
                    Notification(WeiXinCode, value: (resp! as! SendAuthResp).code!)
                case -2:
                    MainThreadAlertShow("取消登录", view: KWINDOWDS())
                case -4:
                    MainThreadAlertShow("拒绝授权", view: KWINDOWDS())
            default:
                break;
            }
        }
    }
}

