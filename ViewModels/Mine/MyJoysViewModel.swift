//
//  MyJoysViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MyJoysViewModel: BaseViewModel {

    var model:MyCatchDollsModel!
    override init() {
        super.init()
        self.requestMyDolls()
    }
    //MARK: UITableViewCellSetData
    func tableViewMyJoyTableViewCellSetData(_ indexPath:IndexPath, cell:MyJoyTableViewCell) {
        cell.cellSetData(model: model.data[indexPath.section])
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        NavigationPushView(self.controller!, toConroller: JoysDetailViewController())
    }
    
    func requestMyDolls(){
        let parameters = ["useId":UserInfoModel.shareInstance().idField]
        BaseNetWorke.sharedInstance.getUrlWithString(CatchedDolls, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = MyCatchDollsModel.init(fromDictionary: resultDic.value! as! NSDictionary)
                self.controller?.tableView.reloadData()
            }
        }
    }
}

extension MyJoysViewModel: UITableViewDelegate {
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
        return 130
    }
}

extension MyJoysViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model == nil ? 0 : self.model.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyJoyTableViewCell.description(), for: indexPath)
        self.tableViewMyJoyTableViewCellSetData(indexPath, cell: cell as! MyJoyTableViewCell)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
}
