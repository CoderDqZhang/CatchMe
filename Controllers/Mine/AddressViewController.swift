//
//  AddressViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

typealias AddressSaveSuccessClouse = (_ model:AddressModel) -> Void

class AddressViewController: BaseViewController {

    var addressSaveSuccessClouse:AddressSaveSuccessClouse!
    var model:AddressModel!
    
    var picker:UIPickerView!
    var pickerToolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: AddressViewModel(), controller: self)
        self.setUpTableView(style: .plain, cells: [GloableTitleLabelTextFieldCell.self, GloableTitleLabelTitleDescCell.self, GloableMaxTitleLabelTextFieldCell.self,SetNormalTableViewCell.self], controller: self)
        self.bindLoginViewModel()
        // Do any additional setup after loading the view.
    }

    func bindLoginViewModel(){
        if self.model != nil {
            (self.viewModel as! AddressViewModel).model = self.model
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "新建收货人"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(self.rightBarButtonPress))
    }
    
    @objc func rightBarButtonPress(){
        (viewModel as! AddressViewModel).saveAddress()
    }

    func showCityPickerView(){
        picker = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 220, width: SCREENWIDTH, height: 220))
        picker.dataSource = self.viewModel as? UIPickerViewDataSource
        picker.delegate = self.viewModel as? UIPickerViewDelegate
        self.view.addSubview(self.showToolBar())
        self.view.addSubview(picker)
    }
    
    func showToolBar() -> UIToolbar{
        pickerToolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 264, width: SCREENWIDTH, height: 44))
        pickerToolBar.barTintColor = UIColor.init(hexString: App_Theme_FC4652_Color)
        pickerToolBar.backgroundColor =  UIColor.init(hexString: App_Theme_FC4652_Color)
        let barItems = NSMutableArray.init()
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.cancelSelect))
        barItems.add(cancel)
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        flexSpace.width = SCREENWIDTH - 60
        barItems.add(flexSpace)
        let done = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.doneSelect))
        barItems.add(done)
        pickerToolBar.items = barItems as? [UIBarButtonItem]
        return pickerToolBar
    }
    
    @objc func cancelSelect(){
        picker.isHidden = true
        pickerToolBar.isHidden = true
    }
    
    @objc func doneSelect(){
        picker.isHidden = true
        pickerToolBar.isHidden = true
        (self.viewModel as! AddressViewModel).getAddress()
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

