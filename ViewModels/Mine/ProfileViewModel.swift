//
//  ProfileViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfileViewModel: BaseViewModel {

    var titleStr:[String] = ["昵称","性别"]
    var detailStr = NSMutableArray.init()
    override init() {
        super.init()
        self.getUserInfoData()
    }
    
    func getUserInfoData(){
        detailStr.add(UserInfoModel.shareInstance().userName)
        detailStr.add(UserInfoModel.shareInstance().gender == 0 ? "男" : "女")
    }
    
    
    //MARK: UITableViewCellSetData
    func tableViewProfileHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:ProfileHeaderTableViewCell) {
        if UserInfoModel.shareInstance().photo! is String {
            cell.cellSetData(imageUrl: UserInfoModel.shareInstance().photo as! String)
            
        }
    }
    
    func tableViewGloabTitleAndFieldCellSetData(_ indexPath:IndexPath, cell:GloabTitleAndFieldCell) {
        cell.setData(titleStr[indexPath.row], detail: (detailStr[indexPath.row] as? String)!)
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
    
    //MARK: RequestNet
    func changeUserInfo(){
        let parameters = ["id":UserInfoModel.shareInstance().idField,
                          "userName":UserInfoModel.shareInstance().userName,
                          "photo":UserInfoModel.shareInstance().photo,
                          "telephone":UserInfoModel.shareInstance().telephone]
        BaseNetWorke.sharedInstance.postUrlWithString(ChangeUserInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                
            }
        }
    }
    
    func uploadImage(image:UIImage) {
        let hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "上传中...")
        let parameters = ["file":image.compressedData()]
        BaseNetWorke.sharedInstance.uploadDataFile(UploadImage, parameters: parameters as NSDictionary, images: nil, hud: hud).observe { (resultDic) in
            if !resultDic.isCompleted {
                print(resultDic.value)
            }
        }
        
//        uploadImage(image: image, fileName: "thumbnail/collection", success: { (resultDic) in
//            self.imageType == 0 ? (UserInfoModel.shareInstance().tails.userInfo.photo = resultDic as! String)
//                : (UserInfoModel.shareInstance().tails.userInfo.qrCode = resultDic as! String)
//        }) { (failure) in
//
//        }
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
        default:
            return 56
        }
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderTableViewCell.description(), for: indexPath)
            self.tableViewProfileHeaderTableViewCellSetData(indexPath, cell: cell as! ProfileHeaderTableViewCell)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        default:
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
        }
    }
}
