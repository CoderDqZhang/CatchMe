//
//  SenderJoysViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class SenderJoysViewModel: BaseViewModel {

    var isHaveAddress:Bool = true
    var model:AddressModel!
    var models:NSMutableArray!
    var modelData:NSMutableArray!
    var selectArrary = NSMutableArray.init()
    
    override init() {
        super.init()
        if AddressModel.findAll().count > 0 {
            model = AddressModel.findLastObject()
            isHaveAddress = model == nil ? false : true
        }else{
            self.requestDefaultAddress()
        }
    }
    
    func senderAddress(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "当前余额不足支付邮费\n请先充值", btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
            if tag == 100 {
                if !COFIGVALUE {
                    NavigationPushView(self.controller!, toConroller: InPurchaseViewController())
                }else{
                    NavigationPushView(self.controller!, toConroller: TopUpViewController())
                }
            }
        }))
    }
    
    func changeModels(){
        modelData = NSMutableArray.init()
        for i in self.models {
            modelData.add((i as! NSDictionary).object(forKey: "skuId") as Any)
        }
        let set = NSSet.init(array: modelData as! [Any])
        modelData.removeAllObjects()
        for str in set.allObjects {
            print(str)
            let predicate = NSPredicate.init(format: "skuId = %@", str as! CVarArg)
            let results = self.models.filtered(using: predicate)
            modelData.add(results)
            selectArrary.add(true)
        }
        self.controller?.tableView.reloadData()
    }
    
    func senderJoys(){
        var isNoneMuch:Bool = false
        var count:Int = 0
        for i in 0...self.selectArrary.count - 1 {
            if self.selectArrary[i] as! Bool {
                count = count + (self.modelData[i] as! NSArray).count
                if count > 2 {
                    isNoneMuch = true
                    break
                }
            }
        }
        if count == 0 {
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请选择发货娃娃", autoHidder: true)
            return
        }
        if (UserInfoModel.shareInstance().coinAmount! as NSString).integerValue < 100 && !isNoneMuch {
            KWINDOWDS().addSubview(GloableAlertView.init(title: "当前余额不足支付邮费\n请先充值", btnTop: "去充值", btnBottom: "取消", image: UIImage.init(named: "pic_fail_1")!, type: GloableAlertViewType.topupfail, clickClouse: { (tag) in
                if tag == 100 {
                    if !COFIGVALUE {
                        NavigationPushView(self.controller!, toConroller: InPurchaseViewController())
                    }else{
                        NavigationPushView(self.controller!, toConroller: TopUpViewController())
                    }
                }
            }))
        }else{
            if isHaveAddress {
                self.requestApplySenderJoy()
            }else{
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "请先填写地址", autoHidder: true)
            }
        }
    }
    
    //MARK: UItableViewCellSetData
    func tableViewSendAddressTableViewCellSetData(_ indexPath:IndexPath, cell:SendAddressTableViewCell) {
        cell.cellSetData(isHaveAddress: isHaveAddress, model:model)
    }
    
    func tableViewSendJoyInfoTableViewCellSetData(_ indexPath:IndexPath, cell:SendJoyInfoTableViewCell) {

        cell.cellSetData(model: MyCatchDollsModel.init(fromDictionary: (modelData[indexPath.row] as! NSArray)[0] as! NSDictionary), count:(modelData[indexPath.row] as! NSArray).count)
        if modelData.count - 1 == indexPath.row {
            cell.hidderLineLabel()
        }
    }
    
    func tableViewSenderMuchTableViewCellSetData(_ indexPath:IndexPath, cell:SenderMuchTableViewCell) {
        
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath, tableView:UITableView) {
        switch indexPath.section {
        case 0:
            let controllerVC = AddressViewController()
            controllerVC.addressSaveSuccessClouse = { model in
                self.model = model
                self.isHaveAddress = true
                self.controller?.tableView.reloadData()
            }
            controllerVC.model = self.model
            NavigationPushView(self.controller!, toConroller: controllerVC)
        case 1:
            let cell = tableView.cellForRow(at: indexPath) as! SendJoyInfoTableViewCell
            cell.changeSelectData(isSelect: !cell.isSelect)
            selectArrary.replaceObject(at: indexPath.row, with: cell.isSelect)
        default:
            break
        }
    }
    
    func requestApplySenderJoy(){
        let senderDolls = NSMutableArray.init()
        for i in 0...selectArrary.count - 1 {
            if selectArrary[i] as! Bool {
                for models in modelData[i] as! NSArray {
                    senderDolls.add(MyCatchDollsModel.init(fromDictionary: models as! NSDictionary).gameId)
                }
            }
        }
        let parameters = ["catchdollIds":senderDolls]
        BaseNetWorke.sharedInstance.postUrlWithString(ApplyShipments, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "发货成功", autoHidder: true)
            }
        }
    }
    
    func requestDefaultAddress(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField]
        BaseNetWorke.sharedInstance.getUrlWithString(QueryDefault, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                let models:NSMutableArray = NSMutableArray.mj_keyValuesArray(withObjectArray: resultDic.value as! [Any])
                if (models.count > 0) {
                    self.model = AddressModel.init(dictionary: models[0] as! NSDictionary as! [AnyHashable : Any])
                    self.isHaveAddress = self.model == nil ? false : true
                    self.controller?.tableView.reloadData()
                }
            }
        }
    }
}

extension SenderJoysViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(indexPath,tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.00001 : 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 104
        case 1:
            return 90
        default:
            return 55
        }
    }
}

extension SenderJoysViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.modelData == nil ? 0 : self.modelData.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SendAddressTableViewCell.description(), for: indexPath)
            self.tableViewSendAddressTableViewCellSetData(indexPath, cell: cell as! SendAddressTableViewCell)
            if isHaveAddress {
                cell.accessoryType = .disclosureIndicator
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SendJoyInfoTableViewCell.description(), for: indexPath)
            self.tableViewSendJoyInfoTableViewCellSetData(indexPath, cell: cell as! SendJoyInfoTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SenderMuchTableViewCell.description(), for: indexPath)
            self.tableViewSenderMuchTableViewCellSetData(indexPath, cell: cell as! SenderMuchTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
        
    }
}

