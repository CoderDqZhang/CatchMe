//
//  RecommendViewController.swift
//  CatchMe
//
//  Created by Zhang on 29/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import MJRefresh

class RightBarItemView:UIView {
    var imageView:UIImageView!
    var button:UIButton!
    
    init(frame: CGRect, image:UIImage, title:String) {
        super.init(frame: frame)
        imageView = UIImageView.init()
        imageView.image = image
        imageView.frame = CGRect.init(x: 0, y: 15, width: image.size.width, height: image.size.height)
        self.addSubview(imageView)
        
        button = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.frame = CGRect.init(x: image.size.width, y: 0, width: frame.size.width - image.size.width, height: frame.size.height)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecommendViewController: BaseViewController {

    let reCommendViewModel = RecommendViewModel()
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
        self.navigationItem.title = "抓友推荐"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: RightBarItemView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 44), image: UIImage.init(named: "筛选")!, title: "筛选"))
    }
    
    func setUpCollectView(){
        let layout = UICollectionViewFlowLayout.init()
        layout.headerReferenceSize = CGSize.init(width: SCREENWIDTH, height: SCREENWIDTH * 80 / 188)
        collectView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - (IPHONEX ? 84 : 64) - 44), collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.init(hexString: App_Theme_FAFAFA_Color)
        collectView.delegate = reCommendViewModel
        collectView.dataSource = reCommendViewModel
        self.view.addSubview(collectView)
        collectView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.description())
    }
    
    func bindLogicViewModel(){
        self.reCommendViewModel.controller = self
    }
    
    func setUpCollectViewRefreshData(){
        self.collectView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.reCommendViewModel.refreshData()
        })
        
        
    }
    
    func setUpCollectViewLoadMoreData(){
        self.collectView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.reCommendViewModel.loadMoreData()
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
