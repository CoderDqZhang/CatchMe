//
//  HomeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class HomeViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpView()
        // Do any additional setup after loading the view.
    }

    override func setUpView(){
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 40)
        button.backgroundColor = UIColor.red
        button.setTitle("播放", for: .normal)
        button.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.testNetWork()
//            NavigationPushView(self, toConroller: CacheMeViewController())
        }
        self.view.addSubview(button)
    }
    
    func testNetWork(){
        let url = "\(TickeHot)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
