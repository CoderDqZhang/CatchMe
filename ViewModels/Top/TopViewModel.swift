//
//  TopViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    //MARK: UITableViewCellSetData
    func tableViewTopAvatarTableViewCellSetData(_ indexPath:IndexPath, cell:TopAvatarTableViewCell) {
        
    }
    
    func tableViewTopDescTableViewCellSetData(_ indexPath:IndexPath, cell:TopDescTableViewCell) {
        
    }
    
    func tableViewTopUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:TopUserInfoTableViewCell) {
        cell.cellSetData(indexPath: indexPath)
    }
    
}

extension TopViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
            return SCREENWIDTH * 80 / 187.5
        case 1:
            return 72
        default:
            return 114
        }
    }
}

extension TopViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopAvatarTableViewCell.description(), for: indexPath)
            self.tableViewTopAvatarTableViewCellSetData(indexPath, cell: cell as! TopAvatarTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopDescTableViewCell.description(), for: indexPath)
            self.tableViewTopDescTableViewCellSetData(indexPath, cell: cell as! TopDescTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopUserInfoTableViewCell.description(), for: indexPath)
            self.tableViewTopUserInfoTableViewCellSetData(indexPath, cell: cell as! TopUserInfoTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}


