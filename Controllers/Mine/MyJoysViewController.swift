//
//  MyJoysViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyJoysViewController: BaseViewController {

    var userId:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "我的娃娃列表"
        self.bindViewModel(viewModel: MyJoysViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [MyJoyTableViewCell.self], controller: self)
        self.setDZNEmptyData()
        self.bindLogicViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "抓到的娃娃"
        if userId == nil {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "申请发货", style: .plain, target: self, action: #selector(self.rightBarButtonPress))
        }
    }

    override func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController()
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func bindLogicViewModel(){
        if userId == nil {
            (self.viewModel as! MyJoysViewModel).requestMyDolls(userId: UserInfoModel.shareInstance().idField)
        }else{
            (self.viewModel as! MyJoysViewModel).requestMyDolls(userId: userId)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
    }
    
    @objc func rightBarButtonPress(){
        let toControllerVC = SenderJoysViewController()
        let models = NSMutableArray.init()
        for model in (self.viewModel as! MyJoysViewModel).model {
            if (model as! NSDictionary).object(forKey: "deliveryStatus")! as! Int == 0 {
                models.add(model)
            }
        }
        toControllerVC.models = models
        
        toControllerVC.senderJoysViewControllerClouse = {
            (self.viewModel as! MyJoysViewModel).requestMyDolls(userId: UserInfoModel.shareInstance().idField)
        }
        NavigationPushView(self, toConroller: toControllerVC)
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
