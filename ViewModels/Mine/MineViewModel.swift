//
//  MineViewModel.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MineViewModel: BaseViewModel {

    var isOwnUser:Bool = true
    var imageUrls:NSMutableArray!
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(MineViewModel.updataTableView), name: NSNotification.Name(rawValue: LoginStatuesChange), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updataTableView), name: NSNotification.Name(rawValue: ChangeUserInfoData), object: nil)
        self.imageUrls = NSMutableArray.init()
        self.imageUrls.addObjects(from: ["http://ww4.sinaimg.cn/bmiddle/a15bd3a5jw1f12r9ku6wjj20u00mhn22.jpg","http://ww2.sinaimg.cn/bmiddle/a15bd3a5jw1f01hkxyjhej20u00jzacj.jpg"])
        KSPhotoBrowser.setImageManagerClass(KSSDImageManager.self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: LoginStatuesChange), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ChangeUserInfoData), object: nil)
    }
    
    @objc func updataTableView(){
        self.controller?.tableView.reloadData()
    }
    
    func rightBarButtomClick(){
        if isOwnUser {
            let controllerVC = ProfileViewController()
            controllerVC.profileViewControllerClouse = {
                self.controller?.tableView.reloadData()
            }
            NavigationPushView(self.controller!, toConroller: controllerVC)
        }else{
            KWINDOWDS().addSubview(UserOperationView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), click: { (type) in
                switch type {
                case .unfollow:
                    self.unfollowUser()
                case .shield:
                    self.shieldUser()
                default:
                    self.complainUser()
                }
            }))
        }
    }
    
    func unfollowUser(){
        
    }
    
    func shieldUser(){
        
    }
    
    func complainUser(){
        
    }
    
    func selectImageIndex(index:Int, view:UIView?, image:UIImage?) {
        let items = NSMutableArray.init().mutableCopy()
        for i in 0...imageUrls.count - 1 {
            let item = KSPhotoItem.init(sourceView: view, thumbImage: image, imageUrl: URL.init(string: imageUrls.object(at: i) as! String))
            (items as AnyObject).add(item)
        }
        let browser = KSPhotoBrowser.init(photoItems: items as! [KSPhotoItem], selectedIndex: UInt(index))
        browser.delegate = self
        browser.dismissalStyle = .scale
        browser.backgroundStyle = .blurPhoto
        browser.loadingStyle = .determinate
        browser.pageindicatorStyle = .dot
        browser.bounces = false
        browser.show(from: self.controller!)
    }
    
    //MARK: TableViewCellSetData
    func tableViewMineHeaderTableViewCellSetData(_ indexPath:IndexPath, cell:MineHeaderTableViewCell) {
        if UserInfoModel.isLoggedIn() {
            cell.cellSetData(model: UserInfoModel.shareInstance());
        }
    }
    
    func tableViewUserPhotosTableViewCellSetData(_ indexPath:IndexPath, cell:UserPhotosTableViewCell) {
        cell.setData(imageUrls: imageUrls, isOwn: self.isOwnUser)
        cell.userPhotosTableViewCellClouse = { tag,views  in
            self.selectImageIndex(index: tag, view: views, image: (views as! UIImageView).image)
        }
        cell.addButton.reactive.controlEvents(.touchUpInside).observe { (btn) in
            (self.controller as! MineViewController).showImagePickerView(isAllowEditing: false)
        }
    }
    
    func tableViewUserSocialTableViewCellSetData(_ indexPath:IndexPath, cell:UserSocialTableViewCell) {
        cell.userSocialTableViewCellClouse = { type in
            switch type {
            case .friendsY:
                let toControllerVC = FriendsViewController()
                NavigationPushView(self.controller!, toConroller: toControllerVC)
                break;
            case .friendsM:
                let toControllerVC = FriendsViewController()
                NavigationPushView(self.controller!, toConroller: toControllerVC)
                break;
            case .dolls:
                let toControllerVC = MyJoysViewController()
                toControllerVC.userId = UserInfoModel.shareInstance().idField
                NavigationPushView(self.controller!, toConroller: toControllerVC)
                break;
            default:
                break;
            }
        }
    }
    
    func tableViewUserAuthorityTableViewCellSetData(_ indexPath:IndexPath, cell:UserAuthorityTableViewCell) {
        cell.cellSetData(isOwnUser: self.isOwnUser)
        cell.userAuthorityTableViewCellClouse = { type in
            switch type {
            case .voice:
                self.showVoiceChoiseMuch(cell: cell,type: type)
            case .oneVideo:
                self.showOneVideoChoiseMuch(cell: cell,type: type)
            default:
                self.showTwoVideoChoiseMuch(cell: cell,type: type)
            }
        }
    }
    
    
    func tableViewMineToolsTableViewCellSetData(_ indexPath:IndexPath, cell:MineToolsTableViewCell){
        cell.customViewButtonClouse = { tag in
            switch tag {
            case 1:
                NavigationPushView(self.controller!, toConroller: TopUpViewController())
            case 2:
                self.pushTopViewController()
            default:
                NavigationPushView(self.controller!, toConroller: MyInvitationCodeViewController())
            }
        }
    }
    
    func showVoiceChoiseMuch(cell:UserAuthorityTableViewCell, type:UserAuthorityTableViewCellSelectType){
        KWINDOWDS().addSubview(SelectMuchView.init(title: "音频价格", desc: "你可以调节你希望的价格段位", much: "30", image: UIImage.init(named: "叶子")!, start: 30, end: 300, clickClouse: { (much) in
            cell.updateUserAuthority(type: type, much: much)
        }))
    }
    
    func showOneVideoChoiseMuch(cell:UserAuthorityTableViewCell, type:UserAuthorityTableViewCellSelectType){
        KWINDOWDS().addSubview(SelectMuchView.init(title: "单向视频价格", desc: "你可以调节你希望的价格段位", much: "60", image: UIImage.init(named: "叶子")!,start: 30, end: 300, clickClouse: { (much) in
            cell.updateUserAuthority(type: type, much: much)
        }))
    }
    
    func showTwoVideoChoiseMuch(cell:UserAuthorityTableViewCell, type:UserAuthorityTableViewCellSelectType){
        KWINDOWDS().addSubview(SelectMuchView.init(title: "视频聊天价格", desc: "你可以调节你希望的价格段位", much: "90", image: UIImage.init(named: "叶子")!,start: 30, end: 300, clickClouse: { (much) in
            cell.updateUserAuthority(type: type, much: much)
        }))
    }
    
    func pushTopViewController(){
        let controllerVC = TopViewController()
        let naviController = UINavigationController.init(rootViewController:controllerVC )
        naviController.transitioningDelegate = self
        self.controller?.present(naviController, animated: true, completion: {
            
        })
    }
    
    func tableViewDidSelect(_ indexPath:IndexPath) {
        if indexPath.row == 0 {
            if UserInfoModel.isLoggedIn() {
                if isOwnUser {
                    (self.controller as! MineViewController).showImagePickerView(isAllowEditing: true)
                }
            }else{
                NavigaiontPresentView(self.controller!, toController: UINavigationController.init(rootViewController: LoginTypeViewController()))
            }
        }
    }
    
    func uploadImage(image:UIImage) {
        let hud = Tools.shareInstance.showLoading(KWINDOWDS(), msg: "上传中...")
        let fileUrl = SaveImageTools.sharedInstance.getCachesDirectory("photoImage.png", path: "headerImage", isSmall: false)
        let parameters = ["file":fileUrl]
        BaseNetWorke.sharedInstance.uploadDataFile(UploadImage, parameters:nil, images: parameters as NSDictionary, hud: hud).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    UserInfoModel.shareInstance().photo = resultDic.value as! String
                    self.changeUserInfo()
                }
            }
        }
    }
    
    func changeUserInfo(){
        let parameters = ["id":UserInfoModel.shareInstance().idField,
                          "userName":UserInfoModel.shareInstance().userName,
                          "photo":UserInfoModel.shareInstance().photo == nil ? "" : UserInfoModel.shareInstance().photo ,
                          "telephone":UserInfoModel.shareInstance().telephone,
                          "gender":UserInfoModel.shareInstance().gender] as [String : Any]
        BaseNetWorke.sharedInstance.postUrlWithString(ChangeUserInfo, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                UserInfoModel.shareInstance().saveOrUpdate(byColumnName: "neteaseAccountId", andColumnValue: "'\(UserInfoModel.shareInstance().neteaseAccountId!)'")
                Notification(ChangeUserInfoData, value: nil)
                if (self.controller! as! ProfileViewController).profileViewControllerClouse != nil {
                    (self.controller! as! ProfileViewController).profileViewControllerClouse()
                }
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
            return SCREENWIDTH * 140 / 187.5
        case 1:
            return (SCREENWIDTH - 40 - 13 * 3) / 4 + 48
        case 2:
            return 78
        case 3:
            if isOwnUser {
               return 125
            }
            return 196
        default:
            return 196
        }
    }
}

extension MineViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isOwnUser ? 5 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineHeaderTableViewCell.description(), for: indexPath)
            self.tableViewMineHeaderTableViewCellSetData(indexPath, cell: cell as! MineHeaderTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserPhotosTableViewCell.description(), for: indexPath)
            self.tableViewUserPhotosTableViewCellSetData(indexPath, cell: cell as! UserPhotosTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserSocialTableViewCell.description(), for: indexPath)
            self.tableViewUserSocialTableViewCellSetData(indexPath, cell: cell as! UserSocialTableViewCell)
            cell.selectionStyle = .none
            return cell
        case 3:
            if isOwnUser {
                let cell = tableView.dequeueReusableCell(withIdentifier: MineToolsTableViewCell.description(), for: indexPath)
                self.tableViewMineToolsTableViewCellSetData(indexPath, cell: cell as! MineToolsTableViewCell)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: UserAuthorityTableViewCell.description(), for: indexPath)
                self.tableViewUserAuthorityTableViewCellSetData(indexPath, cell: cell as! UserAuthorityTableViewCell)
                cell.selectionStyle = .none
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserAuthorityTableViewCell.description(), for: indexPath)
            self.tableViewUserAuthorityTableViewCellSetData(indexPath, cell: cell as! UserAuthorityTableViewCell)
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension MineViewModel : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransitionAnimated.init() as! UIViewControllerAnimatedTransitioning
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}

extension MineViewModel : KSPhotoBrowserDelegate {
    func ks_photoBrowser(_ browser: KSPhotoBrowser, didSelect item: KSPhotoItem, at index: UInt) {
        
    }    
}


