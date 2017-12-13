
//
//  AnimationTools.swift
//  CatchMe
//
//  Created by Zhang on 07/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import pop

enum TouchStatus {
    case begin
    case end
}

typealias AnimationFinishClouse = (_ ret:Bool) ->Void

class AnimationTools: NSObject {
    
    override init() {
        super.init()
    }
    
    static let shareInstance = AnimationTools()
    
    func moveAnimation(view:UIView?,frame:CGRect,finishClouse:@escaping AnimationFinishClouse){
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            view?.frame = frame
        }) { (ret) in
            finishClouse(ret)
        }
    }
    
    func scalAnimation(view:UIView){
        let scale = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.75, height: 1.75))
        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scale?.dynamicsTension = 1000
        scale?.dynamicsMass = 1.3
        scale?.dynamicsFriction = 10.3
        scale?.springSpeed = 10
        scale?.springBounciness = 15.64
        self.shakeAnimation(view: view)
//        view.layer.pop_add(scale, forKey: "scale")
    }
    
    func shakeAnimation(view:UIView){
        let shake = CABasicAnimation.init(keyPath: "transform.rotation.z")
        shake.fromValue = 0.1
        shake.toValue = -0.1
        shake.duration = 0.1
        shake.autoreverses = false //是否重复
        shake.repeatCount = 2
        view.layer.add(shake, forKey: "transformRotation")
        view.alpha = 1.0
        UIView.animate(withDuration: 2.0, delay: 1, options: .curveEaseIn, animations: {
            
        }) { (ret) in
            
        }
    }
    
    func removeViewAnimation(view:UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0
            view.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        }) { (ret) in
            view.removeFromSuperview()
        }
    }
    
    func removeBigViewAnimation(view:UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            view.alpha = 0
            view.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        }) { (ret) in
            view.removeFromSuperview()
        }
    }
}

