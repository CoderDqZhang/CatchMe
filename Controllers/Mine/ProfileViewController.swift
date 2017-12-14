//
//  ProfileViewController.swift
//  CatchMe
//
//  Created by Zhang on 19/11/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    var picker:UIPickerView!
    var pickerToolBar:UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel(viewModel: ProfileViewModel(), controller: self)
        self.setUpTableView(style: .grouped, cells: [ProfileHeaderTableViewCell.self,GloabTitleAndFieldCell.self,ProfielInfoTableViewCell.self, ProfileLogoutTableViewCell.self,GloabTitleAndSwitchCell.self], controller: self)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.fd_prefersNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func setUpViewNavigationItem() {
        self.navigationItem.title = "设置"
    }
    
    override func backBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController()
        (self.viewModel as! ProfileViewModel).changeUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSexPickerView(){
        picker = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 220, width: SCREENWIDTH, height: 220))
        picker.dataSource = (self.viewModel as! ProfileViewModel)
        picker.delegate = (self.viewModel as! ProfileViewModel)
        self.view.addSubview(self.showToolBar())
        self.view.addSubview(picker)
    }
    
    func showToolBar() -> UIToolbar{
        pickerToolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: SCREENHEIGHT - 264, width: SCREENWIDTH, height: 44))
        pickerToolBar.barTintColor = UIColor.init(hexString: App_Theme_FA3A47_Color)
        pickerToolBar.backgroundColor =  UIColor.clear
        let barItems = NSMutableArray.init()
        let cancel = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(self.cancelSelect))
        barItems.add(cancel)
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        flexSpace.width = SCREENWIDTH - 60
        barItems.add(flexSpace)
        let done = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(self.doneSelect))
        barItems.add(done)
        pickerToolBar.items = barItems as? [UIBarButtonItem]
        return pickerToolBar
    }
    
    @objc func cancelSelect(){
        picker.isHidden = true
        pickerToolBar.isHidden = true
    }
    
    @objc func doneSelect(){
        picker.isHidden = true
        pickerToolBar.isHidden = true
        (self.viewModel as! ProfileViewModel).getSexText()
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

