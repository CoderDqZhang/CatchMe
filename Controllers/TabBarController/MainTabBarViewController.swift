//
//  MainTabBarViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import ESTabBarController_swift

let SafeAreaBottomHeight = SCREENHEIGHT == 812.0 ? 34 : 0


class CustomContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor.init(hexString: App_Theme_BBBBBB_Color)
        highlightTextColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        iconColor = UIColor.init(hexString: App_Theme_BBBBBB_Color)
        highlightIconColor = UIColor.init(hexString: App_Theme_FC4652_Color)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ExampleIrregularityContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        self.imageView.layer.cornerRadius = 35
        self.insets = UIEdgeInsetsMake(-32, 0, 0, 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubview(toFront: self)
        
        textColor = UIColor.init(hexString: App_Theme_BBBBBB_Color)
        highlightTextColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        iconColor = UIColor.init(hexString: App_Theme_BBBBBB_Color)
        highlightIconColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    public override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
        view.layer.cornerRadius = 1.0
        view.layer.opacity = 0.5
        view.backgroundColor = UIColor.init(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        self.addSubview(view)
//        playMaskAnimation(animateView: view, target: self.imageView, completion: {
//            [weak view] in
//            view?.removeFromSuperview()
//            completion?()
//        })
    }
    
//    public override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
//        completion?()
//    }
//
//    public override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
//        completion?()
//    }
//
//    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("small", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
//        self.imageView.transform = transform
//        UIView.commitAnimations()
//        completion?()
//    }
//
//    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
//        UIView.beginAnimations("big", context: nil)
//        UIView.setAnimationDuration(0.2)
//        let transform = CGAffineTransform.identity
//        self.imageView.transform = transform
//        UIView.commitAnimations()
//        completion?()
//    }
//
//    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> ())?) {
//        view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
//
//        let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
//        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
//        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
//        scale?.beginTime = CACurrentMediaTime()
//        scale?.duration = 0.3
//        scale?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
//        scale?.removedOnCompletion = true
//
//        let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
//        alpha?.fromValue = 0.6
//        alpha?.toValue = 0.6
//        alpha?.beginTime = CACurrentMediaTime()
//        alpha?.duration = 0.25
//        alpha?.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
//        alpha?.removedOnCompletion = true
//
//        view.layer.pop_add(scale, forKey: "scale")
//        view.layer.pop_add(alpha, forKey: "alpha")
//
//        scale?.completionBlock = ({ animation, finished in
//            completion?()
//        })
//    }
    
}


class MainTabBarViewController: ESTabBarController {

    var homeViewController = HomeViewController()
    var topViewController = TopViewController()
    var mineViewController = MineViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.delegate = delegate
        
//        self.shouldHijackHandler = {
//            tabbarController, viewController, index in
//            if index == 1 {
//                return true
//            }
//            return false
//        }
//        self.didHijackHandler = {
//            [weak tabBarController] tabbarController, viewController, index in
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
//                alertController.addAction(takePhotoAction)
//                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
//                alertController.addAction(selectFromAlbumAction)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
////                self.present(alertController, animated: true, completion: nil)
//            }
//        }
        
//        homeViewController.tabBarItem = ESTabBarItem.init(CustomContentView(), title: "首页", image: UIImage.init(named: "home_gray")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "home_red")!.withRenderingMode(.alwaysOriginal), tag: 0)
//        topViewController.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: "快速开始", image: UIImage.init(named: "photo_verybig_1")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "photo_verybig_1")!.withRenderingMode(.alwaysOriginal), tag: 1)
//        mineViewController.tabBarItem = ESTabBarItem.init(CustomContentView(), title: "我的", image: UIImage.init(named: "me_gray")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: "me_red")!.withRenderingMode(.alwaysOriginal), tag: 2)
        
        self.setNavigationControllerTitleAndImage(image: UIImage.init(named: "home_gray")!, title: "抓我", selectImage: UIImage.init(named: "home_red")!, controller: homeViewController)
        self.setNavigationControllerTitleAndImage(image: UIImage.init(named: "v_gray")!, title: "大神榜", selectImage: UIImage.init(named: "v_red")!, controller: topViewController)
        self.setNavigationControllerTitleAndImage(image:  UIImage.init(named: "me_gray")!, title: "我的", selectImage: UIImage.init(named: "me_red")!,  controller: mineViewController)
        
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
    }
}
