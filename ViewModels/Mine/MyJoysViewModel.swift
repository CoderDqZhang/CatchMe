//
//  MyJoysViewModel.swift
//  CatchMe
//
//  Created by Zhang on 20/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MyJoysViewModel: BaseViewModel {

    var model = NSMutableArray.init()
    override init() {
        super.init()
        self.requestMyDolls()
    }
    //MARK: UITableViewCellSetData
    func tableViewMyJoyTableViewCellSetData(_ indexPath:IndexPath, cell:MyJoyTableViewCell) {
        cell.cellSetData(model: MyCatchDollsModel.init(fromDictionary: model[indexPath.section] as! NSDictionary) )
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        let toViewController = JoysDetailViewController()
        toViewController.url = "\(DollsDetail)\(MyCatchDollsModel.init(fromDictionary: model[indexPath.section] as! NSDictionary).skuId!)"
        NavigationPushView(self.controller!, toConroller: toViewController)
    }
    
    func requestMyDolls(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField]
//        let parameters = ["userId":1]
        BaseNetWorke.sharedInstance.getUrlWithString(CatchedDolls, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = NSMutableArray.mj_keyValuesArray(withObjectArray: resultDic.value as! [Any])
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
        return self.model.count
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

extension MyJoysViewModel : DZNEmptyDataSetDelegate {
    
}

extension MyJoysViewModel : DZNEmptyDataSetSource {
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        let attributed = NSMutableAttributedString.init(string: "抓我！主人，快带我回家吧～")
//        if #available(iOS 11.0, *) {
//            attributed.addAttributes([NSAttributedStringKey.font : App_Theme_PinFan_M_16_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(named: App_Theme_CCCCCC_Color)!], range: NSRange.init(location: 0, length: "抓我！主人，快带我回家吧～".length))
//        } else {
//            // Fallback on earlier versions
//        }
//        return attributed
//    }
}
