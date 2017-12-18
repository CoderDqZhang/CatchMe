//
//  SettingViewController.swift
//  CatchMe
//
//  Created by Zhang on 22/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import NIMSDK

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "设置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "退出登录", style: .plain, target: self, action: #selector(SettingViewController.rightBarButtonPress))
    }
    
    @objc func rightBarButtonPress(){
        if UserInfoModel.logout() {
            Notification(LoginStatuesChange, value: nil)
            NIMSDK.shared().loginManager.logout({ (error) in
                if error == nil {
                    _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "注销成功", autoHidder: true)
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
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
