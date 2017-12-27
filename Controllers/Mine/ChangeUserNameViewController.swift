//
//  ChangeUserNameViewController.swift
//  CatchMe
//
//  Created by Zhang on 16/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias ChangeUserNameViewControllerClouse = () -> Void
class ChangeUserNameViewController: BaseViewController {

    var changeUserNameViewControllerClouse:ChangeUserNameViewControllerClouse!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "修改用户名"
        self.bindViewModel(viewModel: ChangeUserNameViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [UserNameChangeTableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func backBtnPress(_ sender: UIButton) {
        if UserInfoModel.shareInstance().userName == "" {
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "主人，昵称为空就不美腻了~", autoHidder: true)
        }else{
            self.navigationController?.popViewController({
                
                if self.changeUserNameViewControllerClouse != nil {
                    self.changeUserNameViewControllerClouse()
                }
            })
        }
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
