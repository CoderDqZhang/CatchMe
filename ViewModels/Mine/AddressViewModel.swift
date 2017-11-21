//
//  AddressViewModel.swift
//  CatchMe
//
//  Created by Zhang on 21/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit


class AddressViewModel: BaseViewModel {

    var titleStr = ["收货人:","联系方式:","所在城市:","详细地址:"]
    var model = AddressModel.init()
    override init() {
        super.init()
    }
    
    func saveAddress(){
        var str = ""
        if model.userName == "" || model.userName == nil{
            str = "请输入收货人"
        }else if model.phone == "" || model.phone == nil  {
            str = "请输入联系方式"
        }else if model.city == "" || model.city == nil{
            str = "请输入所在城市"
        }else if model.address == "" || model.address == nil{
            str = "请输入详细地址"
        }
        if str != "" {
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: str, autoHidder: true)
            return
        }
        if (self.controller as! AddressViewController).addressSaveSuccessClouse != nil {
            (self.controller as! AddressViewController).addressSaveSuccessClouse(model)
        }
        model.save()
        self.controller?.navigationController?.popViewController({
            
        })
    }
    
    //MARK: UItableViewCellSetData
    func tableViewGloableTitleLabelTextFieldCellSetData(_ indexPath:IndexPath, cell:GloableTitleLabelTextFieldCell) {
        cell.cellSetData(title: titleStr[indexPath.row], placeholderStr: nil, textFieldStr: indexPath.row == 0 ? self.model.userName : self.model.phone)
        switch indexPath.row {
        case 0:
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.model.userName = str!
            })
        default:
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.model.phone = str!
            })
        }
    }
    
    func tableViewGloableTitleLabelTitleDescCellSetData(_ indexPath:IndexPath, cell:GloableTitleLabelTitleDescCell) {
        cell.cellSetData(title: titleStr[indexPath.row], titleDescStr: self.model.city)
    }
    
    func tableViewGloableMaxTitleLabelTextFieldCellSetData(_ indexPath:IndexPath, cell:GloableMaxTitleLabelTextFieldCell) {
        cell.cellSetData(title: titleStr[indexPath.row], placeholderStr: "街道、楼牌号", textFieldStr: self.model.address)
        cell.textView.reactive.continuousTextValues.observeValues({ (str) in
            self.model.address = str!
        })
    }
    
    func tableViewSetNormalTableViewCellSetData(_ indexPath:IndexPath, cell:SetNormalTableViewCell) {
//        cell.
    }
    
    func updateCellString(_ tableView:UITableView, str:String, tag:Int) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! GloableTitleLabelTitleDescCell
        cell.titleDesc.text = str
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, tableView:UITableView) {
        if indexPath.row == 2 {
            (self.controller as! AddressViewController).showCityPickerView()
        }
    }
}

extension AddressViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(indexPath,tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 20))
        headerView.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2,4:
            return 50
        default:
            return 80
        }
    }
}

extension AddressViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloableTitleLabelTextFieldCell.description(), for: indexPath)
            self.tableViewGloableTitleLabelTextFieldCellSetData(indexPath, cell: cell as! GloableTitleLabelTextFieldCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloableTitleLabelTitleDescCell.description(), for: indexPath)
            self.tableViewGloableTitleLabelTitleDescCellSetData(indexPath, cell: cell as! GloableTitleLabelTitleDescCell)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloableMaxTitleLabelTextFieldCell.description(), for: indexPath)
            self.tableViewGloableMaxTitleLabelTextFieldCellSetData(indexPath, cell: cell as! GloableMaxTitleLabelTextFieldCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SetNormalTableViewCell.description(), for: indexPath)
            self.tableViewSetNormalTableViewCellSetData(indexPath, cell: cell as! SetNormalTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        
    }
}
