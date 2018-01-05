//
//  FilterViewController.swift
//  CatchMe
//
//  Created by Zhang on 05/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: FilterViewModel(), controller: self)
        self.setUpTableView(style: .plain, cells: [FilterSexTableViewCell.self, FilterAgeTableViewCell.self, FilterStatusTableViewCell.self, FilterLocationTableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "筛选"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.rightBarItemClick))
    }
    
    @objc func rightBarItemClick(){
        self.navigationController?.popViewController()
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
