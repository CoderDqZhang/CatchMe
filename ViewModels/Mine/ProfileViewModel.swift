//
//  ProfileViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewModel: BaseViewModel {

    var titleStr:[String] = ["昵称","性别","城市","生日"]
    var titleStrs:[String] = ["关于我们","问题反馈"]
    var pickerStr:[String] = ["男","女"]
    var sectionsNumber = [4,1,2,1]
    var addressDic = NSMutableArray.init()
    var detailStr = NSMutableArray.init()
    var selectProvince:Int = 0
    var selectAge:Int = 0
    var selectCity:Int = 0
    var selectRegion:Int = 0
    var selectRow:Int = 0
    
    override init() {
        super.init()
        self.getUserInfoData()
        addressDic = LocalJsonFile.init().fileRead(fileName: "address", type: "txt")!.object(forKey: "data") as! NSMutableArray
    }
    
    func getUserInfoData(){
        if UserInfoModel.isLoggedIn() {
            detailStr.add(UserInfoModel.shareInstance().userName)
            detailStr.add(UserInfoModel.shareInstance().gender != 0 ? "男" : "女")
            detailStr.add("北京市")
            detailStr.add("29")
        }
    }
    
    func getSexText(){
        UserInfoModel.shareInstance().gender = pickerStr[selectRow] == "男" ? 1 : 0
        self.updateCellString((self.controller as! ProfileViewController).tableView, str: pickerStr[selectRow], tag: 1)
    }
    
    //MARK: UITableViewCellSetData
    func tableViewProfileHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:ProfileHeaderTableViewCell) {
        cell.cellSetData(imageUrl: UserInfoModel.shareInstance().photo == nil ? "" : UserInfoModel.shareInstance().photo)
    }
    
    func tableViewGloabTitleAndFieldCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndFieldCell) {
        cell.textField.isEnabled = false
        if indexPath.row == 0 {
            cell.setData(titleStr[indexPath.row], detail: UserInfoModel.shareInstance().userName, laceholder: "请输入用户名")
        }else{
            cell.setData(titleStr[indexPath.row], detail: UserInfoModel.shareInstance().userName, laceholder: "请输入年龄")
        }
    }
    
    func tableViewGloabTitleAndSwitchCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndSwitchCell) {
        let str = UserDefaultsGetSynchronize(MUISCCOGIF) as! String
        cell.cellSetData(str: "音乐开关", isOn: str == "true" ? true : false)
    }
    
    func updateCellString(_ tableView:UITableView, str:String, tag:Int) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: tag, section: 0)) as! ProfielInfoTableViewCell
        cell.detailLabel.text = str
    }
    
    func tableViewProfielInfoTableViewCellSetData(_ indexPath:IndexPath, cell:ProfielInfoTableViewCell) {
        if indexPath.section == 0 {
            cell.cellSetData(title: titleStr[indexPath.row], desc: detailStr[indexPath.row] as? String)
        }else{
            cell.cellSetData(title: titleStrs[indexPath.row], desc: nil)
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, tableView:UITableView) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let toControllerVC = ChangeUserNameViewController()
                toControllerVC.changeUserNameViewControllerClouse = {
                    let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! GloabTitleAndFieldCell
                    cell.setTextFieldText(UserInfoModel.shareInstance().userName)
                    self.changeUserInfo()
                }
                NavigationPushView(self.controller!, toConroller: toControllerVC)
            }else if indexPath.row == 1 {
                (self.controller as! ProfileViewController).showSexPickerView()
            }else if indexPath.row == 2 {
                (self.controller as! ProfileViewController).showCityPickerView()
            }else if indexPath.row == 3 {
                (self.controller as! ProfileViewController).showAgePickerView()
            }
        }else if indexPath.section == 2{
            if indexPath.row == 0 {
                NavigationPushView(self.controller!, toConroller: AboutUsViewController())
            }else if indexPath.row == 1 {
                NavigationPushView(self.controller!, toConroller: QuestionViewController())
            }
        }
    }
    
    @objc func logout(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField]
        BaseNetWorke.sharedInstance.postUrlWithString(LogOut, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if UserInfoModel.logout() {
                    KWINDOWDS().rootViewController = UINavigationController.init(rootViewController: LoginTypeViewController())
                }
            }
        }
        
    }
    
    func getAddress(){
        let str = "\(String(describing: (self.addressDic[selectProvince] as! NSDictionary).object(forKey: "name")! as! String)) \(String(describing: (((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "name")! as! String))"
        UserInfoModel.shareInstance().provinceName = (((self.addressDic[selectProvince] as! NSDictionary).object(forKey: "code")! as! NSString) as String!)
        UserInfoModel.shareInstance().cityName = (((((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[selectCity] as! NSDictionary).object(forKey: "code")! as! NSString) as String!)
        self.updateCellString((self.controller?.tableView)!, str: str, tag: 2)
    }
    
    func getAge(age:Int){
        let str = "\(age)"
        self.updateCellString((self.controller?.tableView)!, str: str, tag: 3)
    }
    
    //MARK: RequestNet
    func changeUserInfo(){
        let parameters = ["id":UserInfoModel.shareInstance().idField,
                          "userName":UserInfoModel.shareInstance().userName,
                          "photo":UserInfoModel.shareInstance().photo == nil ? "" : UserInfoModel.shareInstance().photo ,
                          "telephone":UserInfoModel.shareInstance().telephone,
                          "gender":UserInfoModel.shareInstance().gender,
                          "provinceName":UserInfoModel.shareInstance().provinceName,
                          "cityName":UserInfoModel.shareInstance().cityName,
                          "birth":UserInfoModel.shareInstance().birth] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(ChangeUserInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                Notification(ChangeUserInfoData, value: nil)
                if (self.controller! as! ProfileViewController).profileViewControllerClouse != nil {
                    (self.controller! as! ProfileViewController).profileViewControllerClouse()
                }
            }
        }
    }
}

extension ProfileViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 4 ? 28 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsNumber[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: GloabTitleAndFieldCell.description(), for: indexPath)
                self.tableViewGloabTitleAndFieldCellSetData(indexPath, cell: cell as! GloabTitleAndFieldCell)
                if indexPath.row == 0 {
                    (cell as! GloabTitleAndFieldCell).lineLable.isHidden = true
                }
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfielInfoTableViewCell.description(), for: indexPath)
                self.tableViewProfielInfoTableViewCellSetData(indexPath, cell: cell as! ProfielInfoTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabTitleAndSwitchCell.description(), for: indexPath)
            self.tableViewGloabTitleAndSwitchCellSetData(indexPath, cell: cell as! GloabTitleAndSwitchCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfielInfoTableViewCell.description(), for: indexPath)
            self.tableViewProfielInfoTableViewCellSetData(indexPath, cell: cell as! ProfielInfoTableViewCell)
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                (cell as! ProfielInfoTableViewCell).lineLable.isHidden = true
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileLogoutTableViewCell.description(), for: indexPath) as!  ProfileLogoutTableViewCell
            cell.profileLogoutTableViewCellClouse = {
                self.logout()
            }
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension ProfileViewModel : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 100 {
            return pickerStr[row]
        }
        if component == 0 {
            return  (self.addressDic[row] as! NSDictionary).object(forKey: "name") as? String
        }
        return (((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray)[row] as! NSDictionary).object(forKey: "name") as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 100 {
            selectRow = row
        }
        if component == 0 {
            selectProvince = row
            selectCity = 0
            selectRegion = 0
            pickerView.reloadComponent(1)
        }else if component == 1 {
            selectCity = row
            selectRegion = 0
        }
    }
}

extension ProfileViewModel : UIPickerViewDataSource {
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 200 {
            return 2
        }
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 100 {
            return 2
        }
        if component == 0 {
            return addressDic.count
        }
        return ((addressDic[selectProvince] as! NSDictionary).object(forKey: "children") as! NSArray).count
    }
}
