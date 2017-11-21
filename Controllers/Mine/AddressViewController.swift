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

    var cityPickerView:ZHPickView!
    var addressSaveSuccessClouse:AddressSaveSuccessClouse!
    var model:AddressModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: AddressViewModel(), controller: self)
        self.setUpTableView(style: .plain, cells: [GloableTitleLabelTextFieldCell.self, GloableTitleLabelTitleDescCell.self, GloableMaxTitleLabelTextFieldCell.self,SetNormalTableViewCell.self], controller: self)
        self.bindLoginViewModel()
        // Do any additional setup after loading the view.
    }

    func bindLoginViewModel(){
        (self.viewModel as! AddressViewModel).model = self.model
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
        self.view.endEditing(true)
        if cityPickerView == nil {
            cityPickerView = ZHPickView(pickviewWithPlistName: "city", isHaveNavControler: false)
            cityPickerView.setPickViewColer(UIColor.white)
            cityPickerView.setTintColor(UIColor.white)
            cityPickerView.tag = 2
            cityPickerView.setToolbarTintColor(UIColor.init(hexString: App_Theme_FC4652_Color))
            cityPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_FFFFFF_Color))
            cityPickerView.delegate = self
        }
        cityPickerView.show()
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

extension AddressViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        print(resultString)
        if resultString != nil {
            (viewModel as! AddressViewModel).model.city = resultString
            (viewModel as! AddressViewModel).updateCellString(self.tableView, str: resultString, tag: pickView.tag)
        }
    }
}
