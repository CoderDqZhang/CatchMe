//
//  MyJoysViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyJoysViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: MyJoysViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [MyJoyTableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "抓到的娃娃"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "申请发货", style: .plain, target: self, action: #selector(self.rightBarButtonPress))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func rightBarButtonPress(){
        let toControllerVC = SenderJoysViewController()
        toControllerVC.models = (self.viewModel as! MyJoysViewModel).model
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
