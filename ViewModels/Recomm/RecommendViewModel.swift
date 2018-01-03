//
//  RecommendViewModel.swift
//  CatchMe
//
//  Created by Zhang on 29/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {

    var models = NSMutableArray.init()
    
    override init() {
        super.init()
    }
    
    func refreshData(){
        
    }
    
    func loadMoreData(){
        
    }
    
    func collectViewRecommendCollectionViewCellSetData(_ indexPath:IndexPath, cell:RecommendCollectionViewCell){
        
    }
    
    func collectDidSelect(_ indexPath:IndexPath){
        let controllerVC = MineViewController()
        controllerVC.isOwnUser = false
        NavigationPushView(self.controller!, toConroller: controllerVC)
    }
}

extension RecommendViewModel : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectDidSelect(indexPath)
    }
}

extension RecommendViewModel : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.description(), for: indexPath)
//        self.collectViewRecommendCollectionViewCellSetData(indexPath, cell: collectViewCell as! RecommendCollectionViewCell)
        return collectViewCell
    }
    
}

extension RecommendViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: (SCREENWIDTH - 14) / 2, height: ((SCREENWIDTH - 14) / 2) * 115 / 90)
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
        return CGSize.init(width: 0, height: 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 0.001, height: 0.001)
    }
    
    
}
