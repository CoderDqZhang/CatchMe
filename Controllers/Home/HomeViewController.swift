//
//  HomeViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MJRefresh

class HomeViewController: BaseViewController {

    var collectView:UICollectionView!
    var topUpBtn:UIButton!
    
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.umengPageName = "首页"
        self.view.backgroundColor = UIColor.init(hexString: App_Theme_FFFFFF_Color)
        self.bindLogicViewModel()
        self.setUpCollectView()
        self.setUpCollectViewRefreshData()
        self.setUpTopUpView()
        _ = Timer.after(5, {
            self.showSelectSex()
        })
        // Do any additional setup after loading the view.
    }
    
    func setUpCollectView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188)
        collectView = UICollectionView.init(frame: CGRect.init(x: 0, y: IPHONEX ? -44 : -20, width: SCREENWIDTH, height: SCREENHEIGHT + (IPHONEX ? 22 : 0)), collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        collectView.delegate = homeViewModel
        collectView.dataSource = homeViewModel
        self.view.addSubview(collectView)
        collectView.register(MyDollsCollectionViewCell.self, forCellWithReuseIdentifier: MyDollsCollectionViewCell.description())
        collectView.register(BannerCollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: BannerCollectionReusableView.description())
        collectView.register(BannerCollectionReusableView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionFooter", withReuseIdentifier: BannerCollectionReusableView.description())
    }
    
    func setUpTopUpView() {
        let topView = TopUpHomeView.init(frame: CGRect.init(x: SCREENWIDTH - 90, y: SCREENHEIGHT - 120 - (IPHONEX ? 73 : 49), width: 86, height: 86)) {
            self.homeViewModel.presenetTopUpVC()
        }
        self.view.addSubview(topView)
    }
    
    func bindLogicViewModel(){
        self.homeViewModel.controller = self
        self.homeViewModel.requestRooms(pageIndex: "1")

    }
    
    func showSelectSex(){
//        NavigaiontPresentView(self, toController: ContactMeViewController())
        KWINDOWDS().addSubview(GloableAlertView.init(title: "请选择您的性别", desc: nil, btnTop: "帅哥", btnBottom: "美女", image: UIImage.init(named: "pic_success")!, topImageUrl: nil, type: GloableAlertViewType.selectSex, clickClouse: { (tag) in
            if tag == 100 {

            }else if tag == 200 {

            }
        }))
    }

    func setUpCollectViewRefreshData(){
        self.collectView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.homeViewModel.refreshData()
        })
        
        
    }
    
    func setUpCollectViewLoadMoreData(){
        self.collectView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.homeViewModel.loadMoreData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: false)
        
        if (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController is MineViewController {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
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

