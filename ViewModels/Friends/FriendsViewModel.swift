//
//  FriendsViewModel.swift
//  CatchMe
//
//  Created by Zhang on 29/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class FriendsViewModel: BaseViewModel {

    var models = NSMutableArray.init()
    
    override init() {
        super.init()
    }
    
    func refreshData(){
        
    }
    
    func loadMoreData(){
        
    }
    
    func collectViewFriendsCollectionViewCellSetData(_ indexPath:IndexPath, cell:FriendsCollectionViewCell){
        cell.friendsCollectionViewCellClouse = { type in
            switch type {
            case .voice:
                self.showVoiceView()
            case .onevideo:
                self.showOneVideoView()
            default:
                self.showTwoVideoView()
            }
        }
    }
    
    func showVoiceView(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "需要10币/分钟哦", desc: "对方不接受不会收钱的", btnTop: "没问题", btnBottom: "再想想", image: nil, topImageUrl: "", type: .showUser, clickClouse: { (tag) in
            if tag == 100 {
                
            }else if tag == 200 {
                
            }
        }))
    }
    
    func showOneVideoView(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "需要10币/分钟哦", desc: "对方不接受不会收钱的", btnTop: "没问题", btnBottom: "再想想", image: nil, topImageUrl: "", type: .showUser, clickClouse: { (tag) in
            if tag == 100 {
                
            }else if tag == 200 {
                
            }
        }))
    }
    
    func showTwoVideoView(){
        KWINDOWDS().addSubview(GloableAlertView.init(title: "需要10币/分钟哦", desc: "对方不接受不会收钱的", btnTop: "没问题", btnBottom: "再想想", image: nil, topImageUrl: UserInfoModel.shareInstance().photo, type: .showUser, clickClouse: { (tag) in
            if tag == 100 {
                
            }else if tag == 200 {
                
            }
        }))
    }
    
    func collectDidSelect(_ indexPath:IndexPath){
        
    }
}

extension FriendsViewModel : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectDidSelect(indexPath)
    }
}

extension FriendsViewModel : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendsCollectionViewCell.description(), for: indexPath)
        self.collectViewFriendsCollectionViewCellSetData(indexPath, cell: collectViewCell as! FriendsCollectionViewCell)
        return collectViewCell
    }
    
}

extension FriendsViewModel : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: (SCREENWIDTH - 14) / 2, height: ((SCREENWIDTH - 14) / 2) * 135 / 90)
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

