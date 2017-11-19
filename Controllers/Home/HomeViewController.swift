//
//  HomeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa

class HomeViewController: BaseViewController {

    var collectView:UICollectionView!
    var homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindLogicViewModel()
        self.setUpCollectView()
        // Do any additional setup after loading the view.
    }
    
    func setUpCollectView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188)
        collectView = UICollectionView.init(frame: CGRect.init(x: 0, y: -20, width: SCREENWIDTH, height: SCREENHEIGHT), collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        collectView.delegate = homeViewModel
        collectView.dataSource = homeViewModel
        self.view.addSubview(collectView)
        collectView.register(MyDollsCollectionViewCell.self, forCellWithReuseIdentifier: MyDollsCollectionViewCell.description())
        collectView.register(BannerCollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: BannerCollectionReusableView.description())
        collectView.register(BannerCollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: BannerCollectionReusableView.description())
    }
    
    func bindLogicViewModel(){
        self.homeViewModel.controller = self
    }

    override func setUpView(){
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 40)
        button.backgroundColor = UIColor.red
        button.setTitle("播放", for: .normal)
        button.reactive.controlEvents(.touchUpInside).observe { (action) in
//            self.testNetWork()
            NavigationPushView(self, toConroller: CacheMeViewController())
        }
        self.view.addSubview(button)
        
        let buttonShare = UIButton.init(type: .custom)
        buttonShare.frame = CGRect.init(x: 100, y: 200, width: 100, height: 40)
        buttonShare.backgroundColor = UIColor.red
        buttonShare.setTitle("分享", for: .normal)
        buttonShare.reactive.controlEvents(.touchUpInside).observe { (action) in
            //            self.testNetWork()
            self.shareItemPress()
        }
        self.view.addSubview(buttonShare)
    }
    
    func testNetWork(){
        let url = "\(TickeHot)"
        BaseNetWorke.sharedInstance.getUrlWithString(url, parameters: nil).observe { (resultDic) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.fd_prefersNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareItemPress() {
        let url = "www.baidu.com"
        KWINDOWDS().addSubview(ShareView.init(title: "推荐给好友", model: ShareModel.init(), image: nil, url: url))
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

