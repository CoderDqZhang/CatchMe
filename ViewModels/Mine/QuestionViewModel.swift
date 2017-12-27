//
//  QuestionViewModel.swift
//  CatchMe
//
//  Created by Zhang on 25/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class QuestionViewModel: BaseViewModel {

    var content:String = ""
    var contact:String = ""
    override init() {
        super.init()
    }
    
    func submit(){
        if content == "" {
            _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "主人，填写一些反馈吧~", autoHidder: true)
        }else{
            let parameters = ["content":content,"contact":contact,"userId":UserInfoModel.shareInstance().idField]
            BaseNetWorke.sharedInstance.postUrlWithString(FeedBack, parameters: parameters as AnyObject).observe { (resultDic) in
                if !resultDic.isCompleted {
                    _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "反馈成功", autoHidder: true)
                }
            }
        }
    }
    
    func tableViewQuestionDetailTableViewCellSetData(_ indexPath:IndexPath, cell:QuestionDetailTableViewCell) {
        cell.textView.reactive.continuousTextValues.observeValues { (str) in
            self.content = str!
        }
    }
    
    func tableViewQuestionPhoneTableViewCellSetData(_ indexPath:IndexPath, cell:QuestionPhoneTableViewCell) {
        cell.textField.reactive.continuousTextValues.observeValues { (str) in
            self.contact = str!
        }
    }
}

extension QuestionViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  section == 0 ? 10 : 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 175
        default:
            return 54
        }
    }
    
    func requestFeedBack(){
        let parameters = ["userId":UserInfoModel.shareInstance().idField,"content":content,"contact":contact]
        BaseNetWorke.sharedInstance.postUrlWithString(FeedBack, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                _ = Tools.shareInstance.showMessage(KWINDOWDS(), msg: "反馈成功", autoHidder: true)
                self.controller?.navigationController?.popViewController()
            }
        }
    }
}

extension QuestionViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionDetailTableViewCell.description(), for: indexPath)
            self.tableViewQuestionDetailTableViewCellSetData(indexPath, cell: cell as! QuestionDetailTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: QuestionPhoneTableViewCell.description(), for: indexPath)
            self.tableViewQuestionPhoneTableViewCellSetData(indexPath, cell: cell as! QuestionPhoneTableViewCell)
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            let button = CustomTouchButton.init(frame: CGRect.init(x: (SCREENWIDTH - 200) / 2, y: 0, width: 200, height: 46), title: "提交", tag: 10, titleFont: App_Theme_PinFan_M_17_Font!, type: CustomButtonType.withBackBoarder, pressClouse: { (tag) in
                self.submit()
            })
            cell.contentView.addSubview(button)
            return cell
        }
        
    }
}


