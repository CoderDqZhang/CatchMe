//
//  FriendsViewController.swift
//  CatchMe
//
//  Created by Zhang on 29/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MJRefresh

class FriendsViewController: BaseViewController {

    let friendsViewModel = FriendsViewModel()
    var collectView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.bindLogicViewModel()
        self.setUpCollectView()
        self.setUpCollectViewRefreshData()
        // Do any additional setup after loading the view.
    }

    override func viewControllerSetNavigationItemBack() {
        
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "我的抓友"
    }
    
    func setUpCollectView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188)
        collectView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - (IPHONEX ? 84 : 64) - 44), collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        collectView.delegate = friendsViewModel
        collectView.dataSource = friendsViewModel
        self.view.addSubview(collectView)
        collectView.register(FriendsCollectionViewCell.self, forCellWithReuseIdentifier: FriendsCollectionViewCell.description())
    }
    
    func bindLogicViewModel(){
        self.friendsViewModel.controller = self
    }
    
    func setUpCollectViewRefreshData(){
        self.collectView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.friendsViewModel.refreshData()
        })
        
        
    }
    
    func setUpCollectViewLoadMoreData(){
        self.collectView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.friendsViewModel.loadMoreData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
