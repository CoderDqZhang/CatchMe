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
    }
    //MARK: TableViewCellSetData
    func tableViewMineHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:MineHeaderTableViewCell) {
        
    }
    
    func tableViewMineToolsTableViewCellSetData(_ indexPath:IndexPath, cell:MineToolsTableViewCell){
        cell.customViewButtonClouse = { tag in
            print(tag)
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        if indexPath.row == 0 {
            NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: LoginTypeViewController()))
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

