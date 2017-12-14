//
//  SenderJoysViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SenderJoysViewController: BaseViewController {

    var bottomView:UIView!
    var models:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: SenderJoysViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [SenderMuchTableViewCell.self,SendJoyInfoTableViewCell.self,SendAddressTableViewCell.self], controller: self)
        self.bindLogicViewModel()
        self.setUpBottomView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpBottomView() {
        bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        self.view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(0)
            make.size.equalTo(CGSize.init(width: SCREENWIDTH, height: 80))
            make.centerX.equalTo(self.view.snp.centerX).offset(0)
        }
        
        let button = CustomTouchButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200)/2, y: 0, width: 200, height: 48), title: "支付并发货", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder) { (tag) in
            (self.viewModel as! SenderJoysViewModel).senderJoys()
        }
        bottomView.addSubview(button)
    }
    
    func bindLogicViewModel(){
        (self.viewModel as! SenderJoysViewModel).models = self.models
        (self.viewModel as! SenderJoysViewModel).changeModels()
    }
    
    
    

    override func setUpViewNavigationItem() {
        self.navigationItem.title = "申请发货"
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
