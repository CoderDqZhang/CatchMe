//
//  MineViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: MineViewModel.init(), controller: self)
        self.setUpTableView(style: .plain, cells: [MineHeaderTableViewCell.self,MineToolsTableViewCell.self], controller: self)
        self.upDataConstraints()
        self.setUpNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    func upDataConstraints(){
        self.tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(-20)
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func setUpView(){
        
    }
    
    func setUpNavigationItem(){
        let rightButton = UIButton.init(type: .custom)
        rightButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.rightBarItemPress()
        }
        rightButton.setImage(UIImage.init(named: "settings"), for: .normal)
        self.view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.view.snp.top).offset(16)
            make.size.equalTo(CGSize.init(width: 36, height: 36))
        }
    }
    
    @objc func rightBarItemPress(){
        
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
