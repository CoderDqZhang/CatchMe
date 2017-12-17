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
    var shareCodelModel:SessionShareModel!
    
    override init() {
        super.init()
    }
    
    //MARK: UITableViewCellSetData
    func tableViewMyJoyTableViewCellSetData(_ indexPath:IndexPath, cell:MyJoyTableViewCell) {
        var isOwne:Bool = false
        if (self.controller as! MyJoysViewController).userId == nil {
            isOwne = true
        }else{
            if (self.controller as! MyJoysViewController).userId == UserInfoModel.shareInstance().idField {
                isOwne = true
            }
        }
        cell.cellSetData(model: MyCatchDollsModel.init(fromDictionary: model[indexPath.section] as! NSDictionary), indexPath: indexPath, isOwn:isOwne)
        cell.shareImage.reactive.controlEvents(.touchUpInside).observe { (result) in
            let tag = result.value?.tag
            self.getShareCodeInfo(tag: tag!)
        }
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
        let toViewController = JoysDetailViewController()
        toViewController.url = "\(CatchDolls)\(MyCatchDollsModel.init(fromDictionary: model[indexPath.section] as! NSDictionary).gameId!)"
        NavigationPushView(self.controller!, toConroller: toViewController)
    }
    
    func requestMyDolls(userId:String){
        let parameters = ["userId":userId]
        BaseNetWorke.sharedInstance.getUrlWithString(CatchedDolls, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.model = NSMutableArray.mj_keyValuesArray(withObjectArray: resultDic.value as! [Any])
                self.controller?.tableView.reloadData()
            }
        }
    }
    
    func getShareCodeInfo(tag:Int){
        let catchModel = MyCatchDollsModel.init(fromDictionary: model[tag] as! NSDictionary)
        let parameters = ["type":"1","gameId":catchModel.gameId] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(Socialsharecard, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.shareCodelModel = SessionShareModel.init(fromDictionary: resultDic.value as! NSDictionary)
                self.showShareView()
            }
        }
    }
    
    func showShareView(){
        if self.shareCodelModel != nil {
            if KWINDOWDS().viewWithTag(120) == nil {
                KWINDOWDS().addSubview(GloabelShareAndConnectUs.init(type: GloabelShareAndConnectUsType.share, title: "成功活抓！快邀请朋友们来围观吧~", clickClouse: { (type) in
                    switch type {
                    case .QQChat:
                        ShareTools.shareInstance.shareQQSessionWebUrl(self.shareCodelModel.title, webTitle: self.shareCodelModel.descriptionField, imageUrl: self.shareCodelModel.thumbnailAddress, webDescription: "", webUrl: self.shareCodelModel.url)
                    case .weChatChat:
                        ShareTools.shareInstance.shareWeChatSession(self.shareCodelModel.title, description: self.shareCodelModel.descriptionField, image: UIImage.getFromURL(self.shareCodelModel.thumbnailAddress), url: self.shareCodelModel.url)
                    case .weChatSession:
                        ShareTools.shareInstance.shareWeChatTimeLine(self.shareCodelModel.title, description: self.shareCodelModel.descriptionField, image: UIImage.getFromURL(self.shareCodelModel.thumbnailAddress), url: self.shareCodelModel.url)
                    default:
                        break
                    }
                }))
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if KWINDOWDS().viewWithTag(120) != nil {
            (KWINDOWDS().viewWithTag(120) as! GloabelShareAndConnectUs).removeSelf()
        }
    }
}

extension MyJoysViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
//        return 0
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
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributed = "抓我！主人，快带我回家吧～"
        let attributedString = NSMutableAttributedString.init(string: attributed)
        attributedString.addAttributes([NSAttributedStringKey.font:App_Theme_PinFan_M_16_Font!,NSAttributedStringKey.foregroundColor:UIColor.init(hexString: App_Theme_CCCCCC_Color)!], range: NSRange.init(location: 0, length: attributed.length))
        
        return attributedString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: "pic_toy")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -64
    }
}
