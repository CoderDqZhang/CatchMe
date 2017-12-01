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

let SafeAreaBottomHeight = SCREENHEIGHT == 812.0 ? 34 : 0


class MainTabBarViewController: CYLTabBarController {

    var homeViewController = HomeViewController()
    var topViewController = TopViewController()
    var mineViewController = MineViewController()
    var currentViewController:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    
        self.tabBarItemsAttributes = [
            [CYLTabBarItemTitle:"首页",CYLTabBarItemImage : "home_gray",CYLTabBarItemSelectedImage : "home_red"],
            [CYLTabBarItemTitle:"我的",CYLTabBarItemImage : "me_gray",CYLTabBarItemSelectedImage : "me_red"]]
        
        let controllers = [createNavigationController(controller: homeViewController),createNavigationController(controller: mineViewController)]
        currentViewController = homeViewController
        self.tabBarController?.tabBar.barStyle = .black
        self.tabBar.shadowImage =  UIImage.createImage(with: UIColor.clear)
        self.tabBar.backgroundImage = UIImage.createImage(with: UIColor.clear)
        self.viewControllers = controllers
        
        if #available(iOS 11.0, *) {
            self.tabBarController?.tabBar.height  =  (self.tabBarController?.tabBar.height)! + 34
            self.viewSafeAreaInsetsDidChange()
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
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

extension MainTabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.tabBarItem.badgeValue = nil
        currentViewController = viewController.childViewControllers[0]
    }
}

class PlusButtonSubclass : CYLPlusButton,CYLPlusButtonSubclassing {
    class func plusButton() -> Any! {
        let button:PlusButtonSubclass =  PlusButtonSubclass()
        button.setImage(UIImage(named: "tabar"), for: UIControlState.normal)
        button.setTitle("快速开始", for: UIControlState.normal)
        button.setTitleColor(UIColor.init(hexString: App_Theme_FC4652_Color), for: UIControlState.normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9.5)
        button.titleLabel!.textAlignment = .center;
        button.adjustsImageWhenHighlighted = false;
        // if you use `+plusChildViewController` , do not addTarget to plusButton.
        button.addTarget(button, action: #selector(self.buttonClicked(sender:)), for: .touchUpInside)
        
        // set button frame
        button.frame.size.width = 70
        button.frame.size.height = 70
        button.verticalImageAndTitle(spacing: 2)
//        button.sizeToFit()
        return button
    }
    
    // button click action
    
      @objc func buttonClicked(sender:CYLPlusButton) {
        let controllerVC = CacheMeViewController()
        controllerVC.isQuickEnter = true
        NavigationPushView((KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController, toConroller: controllerVC)
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        // tabbar UI layout setup
//        let imageViewEdgeWidth   = self.bounds.size.width * 0.7
//        let imageViewEdgeHeight = imageViewEdgeWidth * 0.9
//
//        let centerOfView    = self.bounds.size.width * 0.5
//        let labelLineHeight = self.titleLabel!.font.lineHeight
//        let verticalMargin = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight ) * 0.5
//
//        let centerOfImageView = verticalMargin + imageViewEdgeHeight * 0.5
//        let centerOfTitleLabel = imageViewEdgeHeight + verticalMargin * 2  + labelLineHeight * 0.5 + 5
//
//        //imageView position layout
//        self.imageView!.bounds = CGRect.init(x: 0, y: 0, width: imageViewEdgeWidth, height: imageViewEdgeHeight)
//        self.imageView!.center = CGPoint.init(x: centerOfView, y: centerOfImageView)
//
//        //title position layout
//        self.titleLabel!.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: labelLineHeight)
//        self.titleLabel!.center = CGPoint.init(x: centerOfView, y: centerOfTitleLabel - 5)
    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 1
    }
    
    static func multiplierOfTabBarHeight(tabBarHeight: CGFloat) -> CGFloat {
        return 0.5
    }
    
    //    static func constantOfPlusButtonCenterYOffsetForTabBarHeight(tabBarHeight: CGFloat) -> CGFloat {
    //        return -10
    //    }
}
