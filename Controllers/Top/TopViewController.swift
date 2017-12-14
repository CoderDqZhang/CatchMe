//
//  TopViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopViewController: BaseViewController {

    var gLoabelNavigaitonBar:GLoabelNavigaitonBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: TopViewModel(), controller: self)
        self.setUpTableView(style: .plain, cells: [TopUserInfoTableViewCell.self,TopDescTableViewCell.self,TopAvatarTableViewCell.self], controller: self)
        self.navigationController?.fd_fullscreenPopGestureRecognizer.isEnabled = false
        self.setUpNavigationView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpNavigationView() {
        self.navigationItem.title = "大神榜"
        gLoabelNavigaitonBar = GLoabelNavigaitonBar.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 64), click: {
            self.navigationController?.popViewController()
        })
        self.view.addSubview(gLoabelNavigaitonBar)
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
