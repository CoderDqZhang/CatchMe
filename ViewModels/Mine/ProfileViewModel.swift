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
    var detailStr = NSMutableArray.init()
    var addressDic = NSMutableArray.init()
    var selectProvince:Int = 0
    var selectCity:Int = 0
    var selectRegion:Int = 0
    override init() {
        super.init()
        self.getUserInfoData()
        addressDic = LocalJsonFile.init().fileRead(fileName: "address", type: "txt")!.object(forKey: "data") as! NSMutableArray
    }
    
    func getUserInfoData(){
        detailStr.add(UserInfoModel.shareInstance().userName)
        detailStr.add(UserInfoModel.shareInstance().gender != 0 ? "男" : "女")
    }
    
    
    //MARK: UITableViewCellSetData
    func tableViewProfileHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:ProfileHeaderTableViewCell) {
        cell.cellSetData(imageUrl: UserInfoModel.shareInstance().photo as! String)
    }
    
    func tableViewGloabTitleAndFieldCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndFieldCell) {
        cell.setData(titleStr[indexPath.row], detail: (detailStr[indexPath.row] as? String)!, laceholder: "请输入用户名")
        cell.textField.reactive.continuousTextValues.observeValues { (str) in
            UserInfoModel.shareInstance().userName = str
        }
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
        return section == 0 ? 20 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        case 1:
            return 50
        default:
            return 56
        }
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.description(), for: indexPath)
            self.tableViewProfileHeaderTableViewCellSetData(indexPath, cell: cell as! ProfileHeaderTableViewCell)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        case 1:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: GloabTitleAndFieldCell.description(), for: indexPath)
                self.tableViewGloabTitleAndFieldCellSetData(indexPath, cell: cell as! GloabTitleAndFieldCell)
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfielInfoTableViewCell.description(), for: indexPath)
                self.tableViewProfielInfoTableViewCellSetData(indexPath, cell: cell as! ProfielInfoTableViewCell)
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileLogoutTableViewCell.description(), for: indexPath)
            cell.backgroundColor = UIColor.clear
            let button = CustomButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200)/2, y: 10, width: 200, height: 46), title: "退出", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder) { (tag) in
                self.logout()
            }
            cell.contentView.addSubview(button)
            cell.selectionStyle = .none
            return cell
        }
    }
}


