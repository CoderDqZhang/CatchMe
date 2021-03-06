//
//  TopViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class TopViewModel: BaseViewModel {

    var model:TopWeeklyModel!
    override init() {
        super.init()
        self.requestTopWeelky()
    }
    
    //MARK: UITableViewCellSetData
    
    func tableViewDidSelect(_ indexPath:IndexPath, tableView:UITableView) {
        if indexPath.row >= 2 {
            let toControllerVC = MyJoysViewController()
            toControllerVC.userId = "\(self.model.gameStatistics[indexPath.row - 2].id!)"
            NavigationPushView(self.controller!, toConroller: toControllerVC)
        }
    }
    
    
    func tableViewTopAvatarTableViewCellSetData(_ indexPath:IndexPath, cell:TopAvatarTableViewCell) {
        cell.cellSetData(model: self.model)
    }
        
    func tableViewTopDescTableViewCellSetData(_ indexPath:IndexPath, cell:TopDescTableViewCell) {
        cell.cellSetData(model: self.model)
    }
    
    func tableViewTopUserInfoTableViewCellSetData(_ indexPath:IndexPath, cell:TopUserInfoTableViewCell) {
        cell.cellSetData(indexPath: indexPath, model:self.model.gameStatistics[indexPath.row - 2])
    }
    
    //RequestTopWeelky
    func requestTopWeelky(){
        BaseNetWorke.sharedInstance.getUrlWithString(TopWeekly, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = TopWeeklyModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.controller?.tableView.reloadData()
            }
        }
    }
    
    
    
}

extension TopViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableViewDidSelect(indexPath, tableView: tableView)
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
            return SCREENWIDTH * (169 + 64) / 375
        case 1:
            return 68
        default:
            if indexPath.row == 4 {
                return 104 - 7.5
            }else if indexPath.row > 4 {
                return 104 - 15
            }
            return 104
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > SCREENWIDTH * (169 + 64) / 375 - 74{
            (self.controller as! TopViewController).gLoabelNavigaitonBar.changeBackGroundColor(isTheme: true)
        }else{

            (self.controller as! TopViewController).gLoabelNavigaitonBar.changeBackGroundColor(isTheme: false)
        }
    }
}

extension TopViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model == nil ? 0 : self.model.gameStatistics.count + 2
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


