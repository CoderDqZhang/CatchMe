//
//  ProfileViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    var sexPickerView:ZHPickView!
    var picker:UIPickerView!
    var pickerToolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel(viewModel: ProfileViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [ProfileHeaderTableViewCell.self,GloabTitleAndFieldCell.self,ProfielInfoTableViewCell.self, ProfileLogoutTableViewCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "个人信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(self.rightBarButtonPress))
    }
    
    @objc func rightBarButtonPress(){        
        (self.viewModel as! ProfileViewModel).changeUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSexPickerView(){
        if sexPickerView == nil {
            sexPickerView = ZHPickView(pickviewWith: ["男","女"], isHaveNavControler: false)
            sexPickerView.setPickViewColer(UIColor.white)
            sexPickerView.setTintColor(UIColor.white)
            sexPickerView.tag = 2
            sexPickerView.setToolbarTintColor(UIColor.init(hexString: App_Theme_FC4652_Color))
            sexPickerView.setTintFont(App_Theme_PinFan_R_13_Font, color: UIColor.init(hexString: App_Theme_FFFFFF_Color))
            sexPickerView.delegate = self
        }
        
        sexPickerView.show()
    }
    
    func presentImagePickerView(){
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (cancelAction) in
            
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            let cameraAction = UIAlertAction(title: "拍照", style: .default) { (cancelAction) in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.present(imagePicker, animated: true) {
                    
                }
            }
            controller.addAction(cameraAction)
        }
        
        
        let album = UIAlertAction(title: "相册", style: .default) { (cancelAction) in
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
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

extension ProfileViewController : ZHPickViewDelegate {
    func toobarDonBtnHaveClick(_ pickView: ZHPickView!, resultString: String!) {
        print(resultString)
        if resultString != nil {
            UserInfoModel.shareInstance().gender = resultString == "男" ? 1 : 0
            (viewModel as! ProfileViewModel).updateCellString(self.tableView, str: resultString, tag: pickView.tag)
        }
    }
}

extension ProfileViewController : UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        _ = SaveImageTools.sharedInstance.saveImage("photoImage.png", image: image, path: "headerImage")
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ProfileHeaderTableViewCell
        cell.avatarImage.image = image
        (viewModel as! ProfileViewModel).uploadImage(image: image)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController : UINavigationControllerDelegate {
    
}

