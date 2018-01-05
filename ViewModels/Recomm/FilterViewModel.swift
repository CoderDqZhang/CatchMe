//
//  FilterViewModel.swift
//  CatchMe
//
//  Created by Zhang on 05/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class FilterViewModel: BaseViewModel {

    let sexArray = NSMutableArray.init(array: ["全部","男","女"])
    let statusArray = NSMutableArray.init(array: ["全部","在线","可聊"])
    let locationArray = NSMutableArray.init(array: ["全国"])
    var location = NSMutableArray.init()
    override init() {
        super.init()
        location = LocalJsonFile.init().fileRead(fileName: "address", type: "txt")!.object(forKey: "data") as! NSMutableArray
        for i in 0...location.count - 1 {
            locationArray.add(((location[i] as! NSDictionary).object(forKey: "name") as! NSString).substring(to: 2) ?? "")
        }
    }
    
    func tableViewFilterSexTableViewCellSetData(_ indexPath:IndexPath, cell:FilterSexTableViewCell) {
        cell.cellSetData(array: sexArray, selectItem: nil)
    }
    
    func tableViewFilterAgeTableViewCellSetData(_ indexPath:IndexPath, cell:FilterAgeTableViewCell) {
        cell.cellSetData(minX: 18, maxX: 40, start: 18)
    }
    
    func tableViewFilterStatusTableViewCellSetData(_ indexPath:IndexPath, cell:FilterStatusTableViewCell) {
        cell.cellSetData(array: statusArray, selectItem: nil)
    }
    
    func tableViewFilterLocationTableViewCellSetData(_ indexPath:IndexPath, cell:FilterLocationTableViewCell) {
        cell.cellSetData(array: locationArray, selectItem: nil)
    }
    
}

extension FilterViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return CGFloat((locationArray.count / 3) * 60 + 70)
        }
        return 100
    }
}

extension FilterViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterSexTableViewCell.description(), for: indexPath)
            self.tableViewFilterSexTableViewCellSetData(indexPath, cell: cell as! FilterSexTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterAgeTableViewCell.description(), for: indexPath)
            self.tableViewFilterAgeTableViewCellSetData(indexPath, cell: cell as! FilterAgeTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterStatusTableViewCell.description(), for: indexPath)
            self.tableViewFilterStatusTableViewCellSetData(indexPath, cell: cell as! FilterStatusTableViewCell)
            cell.selectionStyle = .none
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterLocationTableViewCell.description(), for: indexPath) as!  FilterLocationTableViewCell
            self.tableViewFilterLocationTableViewCellSetData(indexPath, cell: cell as! FilterLocationTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}
