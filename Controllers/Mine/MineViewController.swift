//
//  MineViewController.swift
//  CatchMe
//
//  Created by Zhang on 18/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    var isOwnUser:Bool = true
    var bottomView:GloableBottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel(viewModel: MineViewModel.init(), controller: self)
        self.setUpTableView(style: .plain, cells: [MineHeaderTableViewCell.self,MineToolsTableViewCell.self,UserPhotosTableViewCell.self,UserSocialTableViewCell.self,UserAuthorityTableViewCell.self], controller: self)
        
        self.upDataConstraints()
        self.setUpNavigationItem()
        self.umengPageName = "我的"
        // Do any additional setup after loading the view.
    }
    
    func upDataConstraints(){
        (self.viewModel as! MineViewModel).isOwnUser = self.isOwnUser
        if isOwnUser {
            self.tableView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.top).offset(IPHONE_VERSION_MINE11 ? -20 : 0)
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(40)
            }
        }else{
            bottomView = GloableBottomView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 50, width: SCREENWIDTH, height: 50), title: "关注", click: {
                
            })
            self.view.addSubview(bottomView)
            self.tableView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.top).offset(IPHONE_VERSION_MINE11 ? -20 : 0)
                make.left.equalTo(self.view.snp.left).offset(0)
                make.right.equalTo(self.view.snp.right).offset(0)
                make.bottom.equalTo(self.view.snp.bottom).offset(10)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        self.navigationController?.fd_prefersNavigationBarHidden = true
        let viewController = (KWINDOWDS().rootViewController as! MainTabBarViewController).currentViewController
        if ((viewController is HomeViewController) || (viewController is FriendsViewController) || (viewController is RecommendViewController) && isOwnUser) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func setUpView(){
        
    }
    
    func setUpNavigationItem(){
        let rightButton = UIButton.init(type: .custom)
        rightButton.reactive.controlEvents(.touchUpInside).observe { (action) in
            self.rightBarItemPress()
        }
        self.view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.view.snp.top).offset(IPHONEX ? 40 : 28)
            make.size.equalTo(CGSize.init(width: 36, height: 36))
        }
        if isOwnUser {
            rightButton.setImage(UIImage.init(named: "settings"), for: .normal)
        }else{
            let backButton = UIButton.init(type: .custom)
            backButton.isUserInteractionEnabled = true
            backButton.setImage(UIImage.init(named: "back_bar"), for: .normal)
            backButton.frame = CGRect.init(x: 10, y: IPHONEX ? 40 : 28, width: 44, height: 44)
            backButton.reactive.controlEvents(.touchUpInside).observe { (action) in
                self.navigationController?.popViewController()
            }
            self.view.addSubview(backButton)
            rightButton.setImage(UIImage.init(named: "settings"), for: .normal)
        }
        
    }
    
    @objc func rightBarItemPress(){
        (self.viewModel as! MineViewModel).rightBarButtomClick()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showImagePickerView(isAllowEditing:Bool){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (cancelAction) in
            
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let cameraAction = UIAlertAction(title: "拍照", style: .default) { (cancelAction) in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = isAllowEditing
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true) {
                    
                }
            }
            controller.addAction(cameraAction)
        }
        
        
        let album = UIAlertAction(title: "相册", style: .default) { (cancelAction) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = isAllowEditing
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true) {
                
            }
        }
        controller.addAction(cancel)
        controller.addAction(album)
        self.present(controller, animated: true) {
            
        }
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

extension MineViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage!
        if info[UIImagePickerControllerEditedImage]  != nil {
            image = info[UIImagePickerControllerEditedImage] as! UIImage
            _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image, path: "headerImage")
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! MineHeaderTableViewCell
            cell.headerImage.image = image
            (viewModel as! MineViewModel).uploadImage(image: image)
            picker.dismiss(animated: true, completion: nil)
        }else{
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
            //这个是要上传原图
        }
    }
}

extension MineViewController : UINavigationControllerDelegate {
    
}
