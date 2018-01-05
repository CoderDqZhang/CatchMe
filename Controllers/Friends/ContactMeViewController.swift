//
//  ContactMeViewController.swift
//  CatchMe
//
//  Created by Zhang on 04/01/2018.
//  Copyright © 2018 Zhang. All rights reserved.
//

import UIKit

class ContactMeViewController: BaseViewController {

    var contactView:ContactLocalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactView = ContactLocalView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT), type: .conneactSuccessMe, click:{ type in
            self.bottomClick(type: type)
        })
        self.view.addSubview(contactView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bottomClick(type:ContactBottomViewButtomType){
        switch type {
        case .accpetVideo:
            print("点击同意接听视频")
        case .closeCamera:
            print("点击关闭摄像头")
        case .coinLabel:
            print("点击金币按钮")
        case .showCollect:
            print("点击我的心愿单")
        default:
            self.dismiss(animated: true, completion: {
                
            })
            print("点击挂断")
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
