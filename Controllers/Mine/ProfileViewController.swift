//
//  ProfileViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    var sexPickerView:ZHPickView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel(viewModel: ProfileViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [ProfileHeaderTableViewCell.self,GloabTitleAndFieldCell.self,ProfielInfoTableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "个人信息"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSexPickerView(){
        if sexPickerView == nil {
            sexPickerView = ZHPickView(pickviewWith: ["男","女"], isHaveNavControler: false)
            sexPickerView.setPickViewColer(UIColor.white)
            sexPickerView.setTintColor(UIColor.white)
            sexPickerView.tag = 2
            sexPickerView.setToolbarTintColor(UIColor.init(hexString: App_Theme_FC4652_Color))
            sexPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_FFFFFF_Color))
            sexPickerView.delegate = self
        }
        
        sexPickerView.show()
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

extension ProfileViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        print(resultString)
        if resultString != nil {
            UserInfoModel.shareInstance().gender = resultString == "男" ? 1 : 0
            (viewModel as! ProfileViewModel).updateCellString(self.tableView, str: resultString, tag: pickView.tag)
        }
    }
}
