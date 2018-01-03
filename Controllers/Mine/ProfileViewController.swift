//
//  ProfileViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias ProfileViewControllerClouse = () ->Void

class ProfileViewController: BaseViewController {

    var picker:UIPickerView!
    var pickerToolBar:UIToolbar!
    var picker1:UIPickerView!
    var pickerToolBar1:UIToolbar!
    var picker2:UIDatePicker!
    var pickerToolBar2:UIToolbar!
    var profileViewControllerClouse:ProfileViewControllerClouse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "个人信息"
        self.bindViewModel(viewModel: ProfileViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [ProfileHeaderTableViewCell.self,GloabTitleAndFieldCell.self,ProfielInfoTableViewCell.self, ProfileLogoutTableViewCell.self,GloabTitleAndSwitchCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "设置"
    }
    
    override func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSexPickerView(){
        if self.view.viewWithTag(100) == nil {
            picker = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 220, width: SCREENWIDTH, height: 220))
            picker.dataSource = (self.viewModel as! ProfileViewModel)
            picker.delegate = (self.viewModel as! ProfileViewModel)
            picker.tag = 100
            picker.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.view.addSubview(self.showToolBar())
            self.view.addSubview(picker)
        }else{
            picker.isHidden = false
            pickerToolBar.isHidden = false
        }
    }
    
    func showCityPickerView(){
        if self.view.viewWithTag(200) == nil {
            picker1 = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 220, width: SCREENWIDTH, height: 220))
            picker1.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            picker1.dataSource = (self.viewModel as! ProfileViewModel)
            picker1.delegate = (self.viewModel as! ProfileViewModel)
            picker1.tag = 200
            picker1.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.view.addSubview(self.showToolBar1())
            self.view.addSubview(picker1)
        }else{
            picker1.isHidden = false
            pickerToolBar1.isHidden = false
        }
    }
    
    func showAgePickerView(){
        if self.view.viewWithTag(300) == nil {
            picker2 = UIDatePicker.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 220, width: SCREENWIDTH, height: 220))                
            picker2.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            picker2.datePickerMode = .date
            picker2.tag = 300
            picker2.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
            self.view.addSubview(self.showToolBar2())
            self.view.addSubview(picker2)
        }else{
            picker2.isHidden = false
            pickerToolBar2.isHidden = false
        }
    }
    
    func showToolBar() -> UIToolbar{
        pickerToolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 264, width: SCREENWIDTH, height: 44))
        pickerToolBar.barTintColor = UIColor.init(hexString: App_Theme_FA3A47_Color)
        pickerToolBar.backgroundColor =  UIColor.clear
        let barItems = NSMutableArray.init()
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.cancelSelect))
        barItems.add(cancel)
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        flexSpace.width = IPHONE_VERSION_MINE11 ? SCREENWIDTH - 110 : SCREENWIDTH - 60
        barItems.add(flexSpace)
        let done = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.doneSelect))
        barItems.add(done)
        pickerToolBar.items = barItems as? [UIBarButtonItem]
        return pickerToolBar
    }
    
    func showToolBar1() -> UIToolbar{
        pickerToolBar1 = UIToolbar.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 264, width: SCREENWIDTH, height: 44))
        pickerToolBar1.barTintColor = UIColor.init(hexString: App_Theme_FA3A47_Color)
        pickerToolBar1.backgroundColor =  UIColor.clear
        let barItems = NSMutableArray.init()
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.cancelSelectCity))
        barItems.add(cancel)
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        flexSpace.width = IPHONE_VERSION_MINE11 ? SCREENWIDTH - 110 : SCREENWIDTH - 60
        barItems.add(flexSpace)
        let done = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.doneSelectCity))
        barItems.add(done)
        pickerToolBar1.items = barItems as? [UIBarButtonItem]
        return pickerToolBar1
    }
    
    func showToolBar2() -> UIToolbar{
        pickerToolBar2 = UIToolbar.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 264, width: SCREENWIDTH, height: 44))
        pickerToolBar2.barTintColor = UIColor.init(hexString: App_Theme_FA3A47_Color)
        pickerToolBar2.backgroundColor =  UIColor.clear
        let barItems = NSMutableArray.init()
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.cancelSelectAge))
        barItems.add(cancel)
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        flexSpace.width = IPHONE_VERSION_MINE11 ? SCREENWIDTH - 110 : SCREENWIDTH - 60
        barItems.add(flexSpace)
        let done = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.doneSelectAge))
        barItems.add(done)
        pickerToolBar2.items = barItems as? [UIBarButtonItem]
        return pickerToolBar2
    }
    
    @objc func cancelSelect(){
        if picker != nil {
            picker.isHidden = true
            pickerToolBar.isHidden = true
        }
        
    }
    
    @objc func doneSelect(){
        picker.isHidden = true
        pickerToolBar.isHidden = true
        (self.viewModel as! ProfileViewModel).getSexText()
        (self.viewModel as! ProfileViewModel).changeUserInfo()
    }
    
    @objc func cancelSelectCity(){
        if picker1 != nil {
            picker1.isHidden = true
            pickerToolBar1.isHidden = true
        }
        
    }
    
    @objc func doneSelectCity(){
        picker1.isHidden = true
        pickerToolBar1.isHidden = true
        (self.viewModel as! ProfileViewModel).getAddress()
    }
    
    @objc func cancelSelectAge(){
        if picker2 != nil {
            picker2.isHidden = true
            pickerToolBar2.isHidden = true
        }
        
    }
    
    @objc func doneSelectAge(){
        let str = Date.init().timeIntervalSince(picker2.date)
        if Int(str) < 0 {
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "这个日期的人还没出生呢", autoHidder: true)
        }else{
            picker2.isHidden = true
            pickerToolBar2.isHidden = true
            (self.viewModel as! ProfileViewModel).getAge(age:(Int(str) / (365 * 24 * 60 * 60)))
        }
        
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
