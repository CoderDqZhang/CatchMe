//
//  MineViewModel.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MineViewModel: BaseViewModel {

    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(MineViewModel.updataTableView), name: NSNotification.Name(rawValue: LoginStatuesChange), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: LoginStatuesChange), object: nil)
    }
    
    @objc func updataTableView(){
        self.controller?.tableView.reloadData()
    }
    //MARK: TableViewCellSetData
    func tableViewMineHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:MineHeaderTableViewCell) {
        if UserInfoModel.isLoggedIn() {
            cell.cellSetData(model: UserInfoModel.shareInstance());
        }
    }
    
    func tableViewMineToolsTableViewCellSetData(_ indexPath:IndexPath, cell:MineToolsTableViewCell){
        cell.customViewButtonClouse = { tag in
            switch tag {
            case 1:
                if !COFIGVALUE {
                    NavigationPushView(self.controller!, toConroller: InPurchaseViewController())
                }else{
                    NavigationPushView(self.controller!, toConroller: TopUpViewController())
                }
            case 2:
                NavigationPushView(self.controller!, toConroller: MyJoysViewController())
            case 3:
                NavigationPushView(self.controller!, toConroller: TopViewController())
            case 4:
                NavigationPushView(self.controller!, toConroller: MyInvitationCodeViewController())
            case 5:
                NavigationPushView(self.controller!, toConroller: QuestionViewController())
            default:
                NavigationPushView(self.controller!, toConroller: AboutUsViewController())
            }
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        if indexPath.row == 0 {
            if UserInfoModel.isLoggedIn() {
                NavigationPushView(self.controller!, toConroller: ProfileViewController())
            }else{
                NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: LoginTypeViewController()))
            }
        }
    }
}

extension MineViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            self.tableViewDidSelect(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 222
        default:
            return SCREENHEIGHT - 222 - 44 - 20
        }
    }
}

extension MineViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineHeaderTableViewCell.description(), for: indexPath)
            self.tableViewMineHeaderTableViewCellSetData(indexPath, cell: cell as! MineHeaderTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineToolsTableViewCell.description(), for: indexPath)
            self.tableViewMineToolsTableViewCellSetData(indexPath, cell: cell as! MineToolsTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

