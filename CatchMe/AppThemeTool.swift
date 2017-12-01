//
//  AppThemeTool.swift
//  LiangPiao
//
//  Created by Zhang on 31/10/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class AppleThemeTool {
    class func setUpToolBarColor() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_A0A0A0_Color) ?? ""], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_F94856_Color) ?? ""], for: .selected)
        UITabBar.appearance().tintColor = UIColor.init(hexString: App_Theme_F94856_Color)
        UITabBar.appearance().backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: App_Theme_F94856_Color)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font:App_Theme_PinFan_R_17_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color) ?? ""]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:App_Theme_PinFan_R_15_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_FFFFFF_Color) ?? ""], for: UIControlState())
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        UINavigationBar.appearance().setBackgroundImage(UIImage.init(color: UIColor.init(hexString: App_Theme_F94856_Color), size: CGSize(width: SCREENWIDTH, height: 64)), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage.init()
        UINavigationBar.appearance().isTranslucent = false
        
    }
    
    class func setUpKeyBoardManager() {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false

    }
}
