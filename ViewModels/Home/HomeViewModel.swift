//
//  HomeViewModel.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel {

    var pageIndex:String = "1"
    var models:HomeLabels!
    var banners:NSMutableArray!
    var headerView:BannerCollectionReusableView!
    override init() {
        super.init()
        self.requestBanner()
        self.getConfig()
    
    }
    
    
    
    //MARK: UICollectionCellSetData
    func collectViewMyDollsCollectionViewCellSetData(_ indexPath:IndexPath, cell:MyDollsCollectionViewCell) {
        cell.cellSetData(model:models.data[indexPath.row])
    }
    
    func collectDidSelect(_ indexPath:IndexPath) {
        
        let controllerVC = CacheMeViewController()
        controllerVC.roomModel = models.data[indexPath.row]
        let naviController = UINavigationController.init(rootViewController:controllerVC )
        naviController.transitioningDelegate = self
        
        self.controller?.present(naviController, animated: true, completion: {
            
        })
    }
    
    func cellBanner(headerView:BannerCollectionReusableView){
        self.headerView = headerView
        if self.banners != nil {
            let imageUrls = NSMutableArray.init()
            for model in self.banners {
                let banner =  BannerModel.init(fromDictionary: model as! NSDictionary)
                imageUrls.add(banner.bannerAddress)
            }
            self.headerView.setcycleScrollerViewData(imageUrls.mutableCopy() as! NSArray)
            self.headerView.cyCleScrollerViewClouse = { index in
                let banner = BannerModel.init(fromDictionary: self.banners[index] as! NSDictionary)
                
                switch banner.type {
                case 1:
                    let controllerVC = MyInvitationCodeViewController()
                    controllerVC.isFormHomeVC = true
                    self.presenetVC(controllerVC: controllerVC)
                case 3:
                    let controllerVC = BaseWebViewController()
                    controllerVC.isFormHomeVC = true
                    controllerVC.bannerModel = BannerModel.init(fromDictionary: self.banners[index] as! NSDictionary)
                    self.presenetVC(controllerVC: controllerVC)
                case 2:
                    let controllerVC = CacheMeViewController()
                    controllerVC.roomModel = Labels.init(fromDictionary: ["id":banner.roomId as! Int])
                    self.presenetVC(controllerVC: controllerVC)
                default:
                    break;
                }
            }
        }
        
    }
    
    func presenetTopUpVC(){
        let controllerVC = TopUpViewController()
        controllerVC.isFormHomeVC = true
        self.presenetVC(controllerVC: controllerVC)
    }
    
    func cellSetBanner(){
        let imageUrls = NSMutableArray.init()
        if self.banners != nil {
            for model in self.banners {
                let banner =  BannerModel.init(fromDictionary: model as! NSDictionary)
                imageUrls.add(banner.bannerAddress)
            }
        }
        if self.headerView != nil {
            self.headerView.setcycleScrollerViewData(imageUrls.mutableCopy() as! NSArray)
            self.headerView.cyCleScrollerViewClouse = { index in
                let banner = BannerModel.init(fromDictionary: self.banners[index] as! NSDictionary)
                
                switch banner.type {
                case 1:
                    let controllerVC = MyInvitationCodeViewController()
                    controllerVC.isFormHomeVC = true
                    self.presenetVC(controllerVC: controllerVC)
                case 3:
                    let controllerVC = BaseWebViewController()
                    controllerVC.isFormHomeVC = true
                    controllerVC.bannerModel = BannerModel.init(fromDictionary: self.banners[index] as! NSDictionary)
                    self.presenetVC(controllerVC: controllerVC)
                case 2:
                    let controllerVC = CacheMeViewController()
                    controllerVC.roomModel = Labels.init(fromDictionary: ["id":banner.roomId as! Int])
                    self.presenetVC(controllerVC: controllerVC)
                default:
                    break;
                }
            }
        }
    }
    
    func presenetVC(controllerVC:BaseViewController){
        let naviController = UINavigationController.init(rootViewController:controllerVC)
        naviController.transitioningDelegate = self
        self.controller?.present(naviController, animated: true, completion: {
            
        })
    }
    
    func loadMoreData(){
        let pageIndex = (self.pageIndex as NSString).integerValue + 1
        self.pageIndex = "\(pageIndex)"
        self.requestRooms(pageIndex: self.pageIndex)
    }
    
    func refreshData(){
        self.pageIndex = "1"
        self.requestRooms(pageIndex: self.pageIndex)
    }
    
    //MARK: RequestNetWorking
    func requestRooms(pageIndex:String){
        let url = HomeRooms
        let parameters = ["offset":pageIndex,"limit":"20","userId":UserInfoModel.shareInstance().idField] as [String : Any]
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil {
                    if pageIndex != "1" {
                        let models = HomeLabels.init(fromDictionary: resultDic.value as! NSDictionary)
                        for model in models.data {
                            self.models.data.append(model)
                        }
                    }else{
                        self.models = HomeLabels.init(fromDictionary: resultDic.value as! NSDictionary)
                    }
                    if self.models.data.count >= 20 {
                        (self.controller as! HomeViewController).setUpCollectViewLoadMoreData()
                        (self.controller as! HomeViewController).collectView.mj_footer.endRefreshing()
                    }
                }
                DispatchQueue.main.async {
                    (self.controller as! HomeViewController).collectView.reloadData()
                }
            }
            (self.controller as! HomeViewController).collectView.mj_header.endRefreshing()
            
        }
    }
    
    //首页banner
    func requestBanner(){
        BaseNetWorke.sharedInstance.getUrlWithString(Banner, parameters: nil).observe { (resultDic) in
            if !resultDic.isCompleted {
                self.banners = NSMutableArray.mj_objectArray(withKeyValuesArray: resultDic.value)
                self.cellSetBanner()
            }
        }
    }
    
    
    func getConfig(){
        let parameters = ["platform":"1","version":APPVERSION]
        BaseNetWorke.sharedInstance.getUrlWithString(Config, parameters: parameters as AnyObject).observe { (resultDic) in
            if !resultDic.isCompleted {
                if resultDic.value != nil && resultDic.value is NSDictionary {
                    let model = ConfigModel.init(fromDictionary: resultDic.value as! NSDictionary)
                    ConfigModel.shanreInstance.isOnlineVersion = model.isOnlineVersion
                    ConfigModel.shanreInstance.musicName = model.musicName
                }
            }
        }
    }
    
}

extension HomeViewModel : CAAnimationDelegate{
    
}

extension HomeViewModel : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectDidSelect(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let kindView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerCollectionReusableView.description(), for: indexPath)
            let height:CGFloat = (IPHONEWIDTH320 ? 137 : IPHONEWIDTH375 ? 160 : 180) + 8
            kindView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: height)
            self.cellBanner(headerView: kindView as! BannerCollectionReusableView)
            return kindView
        }else{
            let kindView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerCollectionReusableView.description(), for: indexPath)
            kindView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 0)
            kindView.backgroundColor = UIColor.white
            return kindView
        }
    }
}

extension HomeViewModel : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models == nil ? 0 : models.data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyDollsCollectionViewCell.description(), for: indexPath)
        self.collectViewMyDollsCollectionViewCellSetData(indexPath, cell: collectViewCell as! MyDollsCollectionViewCell)
        return collectViewCell
    }

}

extension HomeViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: (SCREENWIDTH - 14) / 2, height: ((SCREENWIDTH - 14) / 2) * 95 / 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        let height:CGFloat = (IPHONEWIDTH320 ? 137 : IPHONEWIDTH375 ? 160 : 180) + 8
        return CGSize.init(width: SCREENWIDTH, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 0.001, height: 0.001)
    }
    
    
}

extension HomeViewModel : UIViewControllerTransitioningDelegate {
    
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
