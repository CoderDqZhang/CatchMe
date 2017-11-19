//
//  HomeViewModel.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel {

    override init() {
        super.init()
    }
    
    //MARK: UICollectionCellSetData
    func collectViewMyDollsCollectionViewCellSetData(_ indexPath:IndexPath, cell:MyDollsCollectionViewCell) {
        
    }
    
    func collectDidSelect(_ indexPath:IndexPath) {
        NavigationPushView(self.controller!, toConroller: CacheMeViewController())
    }
    
    func cellBanner(headerView:BannerCollectionReusableView){
        let imageUrls = NSMutableArray.init(array: ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511699910&di=4dab0c873fc8e22e5a9a831b3ece86de&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1205%2F22%2Fc8%2F11710213_11710213_1337684443710.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511699935&di=5e94a2bd7dbd3a28f9fe22c31bb8bca2&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1205%2F22%2Fc8%2F11710213_11710213_1337684441789.jpg"])
        headerView.setcycleScrollerViewData(imageUrls.mutableCopy() as! NSArray)
        headerView.cyCleScrollerViewClouse = { index in
        }
    }
}

extension HomeViewModel : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectDidSelect(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let kindView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerCollectionReusableView.description(), for: indexPath)
            kindView.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188)
            self.cellBanner(headerView: kindView as! BannerCollectionReusableView)
            kindView.backgroundColor = UIColor.brown
            return kindView
        }else{
            let kindView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerCollectionReusableView.description(), for: indexPath)
            kindView.backgroundColor = UIColor.brown
            return kindView
        }
    }
}

extension HomeViewModel : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
        return CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188 + 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 0.001, height: 0.001)
    }
    
    
}
