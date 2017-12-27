//
//  MainTabBarViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import CYLTabBarController
import SwifterSwift
import MapKit

let SafeAreaBottomHeight = SCREENHEIGHT == 812.0 ? 34 : 0


class MainTabBarViewController: CYLTabBarController {

    var homeViewController = HomeViewController()
    var topViewController = TopViewController()
    var mineViewController = MineViewController()
    var currentViewController:UIViewController!
    
    var quictEnterLocalPreView:QuictEnterLocalPreView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    
        self.tabBarItemsAttributes = [
            [CYLTabBarItemTitle:"首页",CYLTabBarItemImage : "home_gray",CYLTabBarItemSelectedImage : "home_red"],
            [CYLTabBarItemTitle:"我的",CYLTabBarItemImage : "me_gray",CYLTabBarItemSelectedImage : "me_red"]]
        
        let controllers = [createNavigationController(controller: homeViewController),createNavigationController(controller: mineViewController)]
        
        currentViewController = homeViewController
        
        if IPHONEX {
            self.tabBar.frame = CGRect.init(x: 0, y: SCREENHEIGHT, width: SCREENWIDTH, height: 43)
        }
        
        self.tabBar.barStyle = .default
        self.tabBar.shadowImage = UIImage.init()
        self.tabBar.backgroundImage = UIImage.init()
        self.tabBar.layer.shadowColor = UIColor.init(hexString: App_Theme_000000_Color, andAlpha: 0.1).cgColor
        self.tabBar.layer.shadowOffset = .zero
        self.tabBar.layer.shadowRadius = 1
        self.tabBar.layer.shadowOpacity = 0.5
        
        if !IPHONE_VERSION_MINE11 {
            
            let image = UIImage.init(byApplyingAlpha: 0.7, image: UIImage.init(named: "menu"))
            let imageHeight = SCREENWIDTH * (image?.size.height)! / (image?.size.width)!
            let imageView:UIImageView?
            imageView = UIImageView.init(frame: CGRect.init(x: 0, y: -(imageHeight - 49), width: SCREENWIDTH, height: imageHeight))
            let blurEffect = UIBlurEffect(style: .light)
            //接着创建一个承载模糊效果的视图
            let blurView = UIVisualEffectView(effect: blurEffect)
            //设置模糊视图的大小（全屏）
            blurView.frame = CGRect.init(x: 0, y: imageHeight - 49, width: SCREENWIDTH, height: 48)
            //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
            
            imageView?.addSubview(blurView)
            imageView?.image = image
            
            self.tabBar.addSubview(imageView!)
            
        }else{
            let image = UIImage.init(byApplyingAlpha: 0.7, image: UIImage.init(named: "menu"))
            let imageHeight = image?.size.height
            let imageView:UIImageView?
            imageView = UIImageView.init(frame: CGRect.init(x: 0, y: -(imageHeight! - 49) - 2, width: SCREENWIDTH, height: imageHeight!))
            let blurEffect = UIBlurEffect(style: .light)
            //接着创建一个承载模糊效果的视图
            let blurView = UIVisualEffectView(effect: blurEffect)
            //设置模糊视图的大小（全屏）
            blurView.frame = CGRect.init(x: 0, y: imageHeight! - 49, width: SCREENWIDTH, height: 49)
            //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
            
            imageView?.addSubview(blurView)
            imageView?.image = image
            
            self.tabBar.addSubview(imageView!)
        }
        
        self.tabBar.isTranslucent = true
        self.viewControllers = controllers
        
        AuthorityManager.setUpAuthorityManager(controller: homeViewController)

    }
    
    func setNavigationControllerTitleAndImage(image:UIImage, title:String, selectImage:UIImage?, controller:UIViewController?) {
        
        controller?.tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        controller?.tabBarItem.title = title
        controller?.navigationItem.title = title
        controller?.tabBarItem.selectedImage = selectImage?.withRenderingMode(.alwaysOriginal)
    }
    
    func createNavigationController(controller:UIViewController?) -> UINavigationController {
        return UINavigationController.init(rootViewController: controller!)
    }
    
    //快速进入房间
    func setUpQuitEntRoom(){
        quictEnterLocalPreView = QuictEnterLocalPreView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), image: self.screenSnapshot(save: false)!)
        KWINDOWDS().addSubview(quictEnterLocalPreView)
    }
    
    func addEfct() ->UIBlurEffect{
        let blueffect = UIBlurEffect.init(style: .light)
        return blueffect
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sigTapGest() {
        let controllerVC = CacheMeViewController()
        controllerVC.isQuickEnter = true
        let transition = CATransition.init()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
        (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController.navigationController?.pushViewController(controllerVC)
        NavigaiontPresentView((KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController, toController: UINavigationController.init(rootViewController:controllerVC ))
//        NavigationPushView((KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController, toConroller: controllerVC)
    }
    
    func screenSnapshot(save: Bool) -> UIImage? {
        // 用下面这行而不是UIGraphicsBeginImageContext()，因为前者支持Retina
        UIGraphicsBeginImageContextWithOptions(KWINDOWDS().bounds.size, false, 0.0)
        KWINDOWDS().layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if save { UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil) }
        return image
    }
    
    
//    func checkLocationStatus(){
//        // 1
//        // 2
//        let locationMgr = CLLocationManager.init()
//        locationMgr.delegate = self
//        let status  = CLLocationManager.authorizationStatus()
//        locationMgr.startUpdatingLocation()
//        if status == .notDetermined {
//            locationMgr.requestWhenInUseAuthorization()
//            return
//        }
//        if status == .denied || status == .restricted {
//            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(okAction)
//            
//            present(alert, animated: true, completion: nil)
//            return
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.tabBarItem.badgeValue = nil
        currentViewController = viewController.childViewControllers[0]
    }
}

extension MainTabBarViewController : CLLocationManagerDelegate{
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        //权限问题
//        switch status {
//        case .denied:
//            break;
//        case .notDetermined:
//            manager.requestWhenInUseAuthorization()
//            //            UIAlertController.shwoAlertControl(KWINDOWDS()!.root, style: .alert, title: "获取地理位置", message: "游戏需要麦克风权限", cancel: "取消", doneTitle: "确定", cancelAction: {
//            //
//            //            }, doneAction: {
//            //                SHARE_APPLICATION.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
//        //            })
//        default:
//            break;
//        }
//    }
//
//    // 1
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let currentLocation = locations.last!
//        print("Current location: \(currentLocation)")
//    }
//
//    // 2
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error \(error)")
//    }
}

class PlusButtonSubclass : CYLPlusButton,CYLPlusButtonSubclassing {
    class func plusButton() -> Any! {
        let view = UIView.init()
        let button:PlusButtonSubclass =  PlusButtonSubclass()
        button.setImage(UIImage(named: "tabar"), for: UIControlState.normal)
        button.setTitle("快抓我呀", for: UIControlState.normal)
        button.setTitleColor(UIColor.init(hexString: App_Theme_333333_Color), for: UIControlState.normal)
        
        button.titleLabel?.font = App_Theme_PinFan_M_10_Font
        button.titleLabel!.textAlignment = .center;
        button.adjustsImageWhenHighlighted = false;
        // if you use `+plusChildViewController` , do not addTarget to plusButton.
        let singTap = UITapGestureRecognizer.init(target: MainTabBarViewController(), action: #selector(MainTabBarViewController.sigTapGest))
        singTap.numberOfTapsRequired = 1
        singTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singTap)
        
        button.addTarget(button, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        button.frame.origin.y = 1
        // set button frame
        button.frame.size.width = 70
        button.frame.size.height = 70
        button.verticalImageAndTitle(spacing: 4)
        let blurEffect = UIBlurEffect(style: .light)
        //接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.cornerRadius = 35
        blurView.layer.masksToBounds = true
        //设置模糊视图的大小（全屏）
        blurView.isUserInteractionEnabled = true
        blurView.frame = CGRect.init(x: 0, y: -3, width: 70, height: 70)
        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
        button.addSubview(blurView)
        button.sendSubview(toBack: blurView)
        return button
    }
    
    // button click action
    
      @objc func buttonClicked(sender:CYLPlusButton) {
        let controllerVC = CacheMeViewController()
        controllerVC.modalPresentationStyle = .currentContext
        controllerVC.isQuickEnter = true
//        let transition = CATransition.init()
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromTop
//        (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController.navigationController?.view.layer.add(transition, forKey: kCATransition)
//        (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController.navigationController?.pushViewController(controllerVC)
        (KWINDOWDS().rootViewController as! MainTabBarViewController).setUpQuitEntRoom()
        _ = Timer.after(0.3, {
            let naviController = UINavigationController.init(rootViewController:controllerVC )
            controllerVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            controllerVC.transitioningDelegate = self
            (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController.present(naviController, animated: true, completion: {
                
            })
        })
//        NavigationPushView((KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController, toConroller: controllerVC)
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 1
    }
    
    static func multiplierOfTabBarHeight(tabBarHeight: CGFloat) -> CGFloat {
        return 0.1
    }
}

extension PlusButtonSubclass : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
