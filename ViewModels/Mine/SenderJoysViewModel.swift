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
    override init() {
        super.init()
        model = AddressModel.findLastObject()
        isHaveAddress = model == nil ? false : true
    }
    
    //MARK: UItableViewCellSetData
    func tableViewSendAddressTableViewCellSetData(_ indexPath:IndexPath, cell:SendAddressTableViewCell) {
        cell.cellSetData(isHaveAddress: isHaveAddress, model:model)
    }
    
    func tableViewSendJoyInfoTableViewCellSetData(_ indexPath:IndexPath, cell:SendJoyInfoTableViewCell) {
        
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
        default:
            break
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
            return 2
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

