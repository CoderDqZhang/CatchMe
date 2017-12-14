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

    var titleStr:[String] = ["昵称","性别"]
    var pickerStr:[String] = ["男","女"]
    var detailStr = NSMutableArray.init()
    var selectProvince:Int = 0
    var selectCity:Int = 0
    var selectRegion:Int = 0
    var selectRow:Int = 0
    override init() {
        super.init()
        self.getUserInfoData()
    }
    
    func getUserInfoData(){
        if UserInfoModel.isLoggedIn() {
            detailStr.add(UserInfoModel.shareInstance().userName)
            detailStr.add(UserInfoModel.shareInstance().gender != 0 ? "男" : "女")
        }
    }
    
    
    func getSexText(){
        UserInfoModel.shareInstance().gender = pickerStr[selectRow] == "男" ? 1 : 0
        self.updateCellString((self.controller as! ProfileViewController).tableView, str: pickerStr[selectRow], tag: 0)
    }
    
    //MARK: UITableViewCellSetData
    func tableViewProfileHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:ProfileHeaderTableViewCell) {
        cell.cellSetData(imageUrl: UserInfoModel.shareInstance().photo == nil ? "" : UserInfoModel.shareInstance().photo)
    }
    
    func tableViewGloabTitleAndFieldCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndFieldCell) {
        cell.setData(titleStr[indexPath.row], detail: (detailStr[indexPath.row] as? String)!, laceholder: "请输入用户名")
        cell.textField.reactive.continuousTextValues.observeValues { (str) in
            UserInfoModel.shareInstance().userName = str
        }
    }
    
    func tableViewGloabTitleAndSwitchCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndSwitchCell) {
        let str = UserDefaultsGetSynchronize(MUISCCOGIF) as! String
        cell.cellSetData(str: "音乐开关", isOn: str == "true" ? true : false)
    }
    
    func updateCellString(_ tableView:UITableView, str:String, tag:Int) {
        let cell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 1)) as! ProfielInfoTableViewCell
        cell.detailLabel.text = str
    }
    
    func tableViewProfielInfoTableViewCellSetData(_ indexPath:IndexPath, cell:ProfielInfoTableViewCell) {
        cell.cellSetData(title: titleStr[indexPath.row], desc: detailStr[indexPath.row] as! String)
        
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        if indexPath.section == 0 {
            (self.controller as! ProfileViewController).presentImagePickerView()
        }else{
            if indexPath.row == 1 {
                (self.controller as! ProfileViewController).showSexPickerView()
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
    
    //MARK: RequestNet
    func changeUserInfo(){
        let parameters = ["id":UserInfoModel.shareInstance().idField,
                          "userName":UserInfoModel.shareInstance().userName,
                          "photo":UserInfoModel.shareInstance().photo,
                          "telephone":UserInfoModel.shareInstance().telephone,
                          "gender":UserInfoModel.shareInstance().gender] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(ChangeUserInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                Notification(ChangeUserInfoData, value: nil)
                self.controller?.navigationController?.popViewController()
            }
        }
    }
    
    func uploadImage(image:UIImage) {
        let hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "上传中...")
        let fileUrl = SaveImageTools.sharedInstance.getCachesDirectory("photoImage.png", path: "headerImage", isSmall: false)
        let parameters = ["file":fileUrl]
        BaseNetWorke.sharedInstance.uploadDataFile(UploadImage, parameters:nil, images: parameters as NSDictionary, hud: hud).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    UserInfoModel.shareInstance().photo = resultDic.value as! String
                }
            }
        }
    }
}

extension ProfileViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 20 : section == 1 ? 10 : section == 2 ? 10 : 28
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        default:
            return 55
        }
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.description(), for: indexPath)
            self.tableViewProfileHeaderTableViewCellSetData(indexPath, cell: cell as! ProfileHeaderTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: GloabTitleAndFieldCell.description(), for: indexPath)
                self.tableViewGloabTitleAndFieldCellSetData(indexPath, cell: cell as! GloabTitleAndFieldCell)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfielInfoTableViewCell.description(), for: indexPath)
                self.tableViewProfielInfoTableViewCellSetData(indexPath, cell: cell as! ProfielInfoTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GloabTitleAndSwitchCell.description(), for: indexPath)
            self.tableViewGloabTitleAndSwitchCellSetData(indexPath, cell: cell as! GloabTitleAndSwitchCell)
            cell.selectionStyle = .none
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
        return pickerStr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectRow = row
    }
}

extension ProfileViewModel : UIPickerViewDataSource {
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
}



