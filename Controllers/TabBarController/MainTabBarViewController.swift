//
//  MainTabBarViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

let SafeAreaBottomHeight = SCREENHEIGHT == 812.0 ? 34 : 0

class MainTabBarViewController: UITabBarController {

    var homeViewController = HomeViewController()
    var topViewController = TopViewController()
    var mineViewController = MineViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.setNavigationControllerTitleAndImage(image: UIImage.init(named: "home_gray")!, title: "抓我", selectImage: nil, controller: homeViewController)
        self.setNavigationControllerTitleAndImage(image: UIImage.init(named: "v_gray")!, title: "大神榜", selectImage: nil, controller: topViewController)
        self.setNavigationControllerTitleAndImage(image:  UIImage.init(named: "v_gray")!, title: "我的", selectImage: nil, controller: mineViewController)
        
        let controllers = [createNavigationController(controller: homeViewController),createNavigationController(controller: topViewController),createNavigationController(controller: mineViewController)]
        
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
        controller?.tabBarItem.image = image
        controller?.tabBarItem.title = title
        controller?.navigationItem.title = title
        controller?.tabBarItem.selectedImage = selectImage
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
    }
}
