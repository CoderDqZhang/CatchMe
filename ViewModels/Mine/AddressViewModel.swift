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
    var addressDic = NSMutableArray.init()
    var selectProvince:Int = 0
    var selectCity:Int = 0
    var selectRegion:Int = 0
    var parameters:[String:Any]!
    var isUpdataAddress:Bool = false
    override init() {
        super.init()
        
        addressDic = LocalJsonFile.init().fileRead(fileName: "address", type: "txt")!.object(forKey: "data") as! NSMutableArray
    }
    
    func getAddressStr() ->String{
        let dic = LocalJsonFile.init().fileRead(fileName: "AddressValueKey", type: "txt")!
        let pronvice:String = dic.object(forKey: "\(model.province)") as! String
        let city:String = dic.object(forKey: "\(model.city)") as! String
        let county:String = dic.object(forKey: "\(model.county)") as! String
        return "\(pronvice)\(city)\(county)"
    }
    
    func saveAddress(){
        var str = ""
        if model.consignee == "" || model.consignee == nil{
            str = "请输入收货人"
        }else if model.telephone == "" || model.telephone == nil  {
            str = "请输入联系方式"
        }else if model.province == 0 || model.province == nil{
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
        let parameters = ["userId":UserInfoModel.shareInstance().idField,
                          "consignee":self.model.consignee,
                          "telephone":self.model.telephone,
                          "province":self.model.province,
                          "city":self.model.city,
                          "county":self.model.county,
                          "address":self.model.address] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(isUpdataAddress ? AddressUpdate : AddressUrl, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model.save()
                self.controller?.navigationController?.popViewController({
                    
                })
            }
        }
        
        
    }
    
    //MARK: UItableViewCellSetData
    func tableViewGloableTitleLabelTextFieldCellSetData(_ indexPath:IndexPath, cell:GloableTitleLabelTextFieldCell) {
        cell.cellSetData(title: titleStr[indexPath.row], placeholderStr: nil, textFieldStr: indexPath.row == 0 ? self.model.consignee : self.model.telephone)
        switch indexPath.row {
        case 0:
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.model.consignee = str!
            })
        default:
            cell.textField.reactive.continuousTextValues.observeValues({ (str) in
                self.model.telephone = str!
            })
        }
    }
    
    func tableViewGloableTitleLabelTitleDescCellSetData(_ indexPath:IndexPath, cell:GloableTitleLabelTitleDescCell) {
        cell.cellSetData(title: titleStr[indexPath.row], titleDescStr: self.model.province == 0 ? "" : self.getAddressStr())
    }
    
    func tableViewGloableMaxTitleLabelTextFieldCellSetData(_ indexPath:IndexPath, cell:GloableMaxTitleLabelTextFieldCell) {
        cell.cellSetData(title: titleStr[indexPath.row], placeholderStr: "街道、楼牌号", textFieldStr: self.model.address)
        cell.textView.reactive.continuousTextValues.observeValues({ (str) in
            self.model.address = str!
        })
    }
    
    func tableViewSetNormalTableViewCellSetData(_ indexPath:IndexPath, cell:SetNormalTableViewCell) {
        cell.normaleImageSelect(isSelect: true)
    }
    
    func updateCellString(_ tableView:UITableView, str:String, tag:Int) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! GloableTitleLabelTitleDescCell
        cell.titleDesc.text = str
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, tableView:UITableView) {
        if indexPath.row == 2 {
            (self.controller as! AddressViewController).showCityPickerView()
        }else if indexPath.row == 4 {
            let cell = tableView.cellForRow(at: indexPath) as! SetNormalTableViewCell
            cell.normaleImageSelect(isSelect: !cell.isSelect)
        }
    }
    
    func getAddress(){
        let str = "\(String(describing: (self.addressDic[selectProvince] as! NSDictionary).object(forKey: "name")! as! String)) \(String(describing: (((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "name")! as! String)) \(String(describing: (((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray)[selectRegion] as! NSDictionary).object(forKey: "name")! as! String))"
        self.updateCellString((self.controller?.tableView)!, str: str, tag: 1)
        self.model.province = ((self.addressDic[selectProvince] as! NSDictionary).object(forKey: "code")! as! NSString).integerValue
        self.model.city = ((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "code")! as! NSString).integerValue
        self.model.county = ((((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray)[selectRegion] as! NSDictionary).object(forKey: "code")! as! NSString).integerValue
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
        return 4
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

extension AddressViewModel : UIPickerViewDelegate {
    // returns width of column and height of row for each component.
    //    @available(iOS 2.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    //
    //    @available(iOS 2.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    //    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return  (self.addressDic[row] as! NSDictionary).object(forKey: "name") as? String
        }else if component == 1 {
            return (((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[row] as! NSDictionary).object(forKey: "name") as? String
        }
        return (((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray)[row] as! NSDictionary).object(forKey: "name") as? String
    }
    
    //    @available(iOS 6.0, *)
    //    optional public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attributed title is favored if both methods are implemented
    
    //     func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectProvince = row
            selectCity = 0
            selectRegion = 0
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        }else if component == 1 {
            selectCity = row
            selectRegion = 0
            pickerView.reloadComponent(2)
        }else{
            selectRegion = row
        }
    }
}

extension AddressViewModel : UIPickerViewDataSource {
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return addressDic.count
        }else if component == 1 {
            return ((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray).count
        }else {
            return ((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "children") as! NSArray).count
        }
    }
}
