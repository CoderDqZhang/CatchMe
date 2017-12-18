//
//  QuestionViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class QuestionViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "问题反馈页面"
        self.bindViewModel(viewModel: QuestionViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [QuestionDetailTableViewCell.self, QuestionPhoneTableViewCell.self, UITableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpView() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func setUpViewNavigationItem() {
        self.navigationItem.title = "问题反馈"
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
