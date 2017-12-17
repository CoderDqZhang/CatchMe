//
//  ChangeUserNameViewModel.swift
//  CatchMe
//
//  Created by Zhang on 16/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ChangeUserNameViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    func tableViewUserNameChangeTableViewCellSetData(_ indexPath:IndexPath, cell:UserNameChangeTableViewCell){
        cell.textField.text = UserInfoModel.shareInstance().userName
        cell.textField.reactive.continuousTextValues.observeValues { (str) in
            UserInfoModel.shareInstance().userName = str
        }
    }
}

extension ChangeUserNameViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ChangeUserNameViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserNameChangeTableViewCell.description(), for: indexPath)
        self.tableViewUserNameChangeTableViewCellSetData(indexPath, cell: cell as! UserNameChangeTableViewCell)
        cell.selectionStyle = .none
        return cell
    }
}

