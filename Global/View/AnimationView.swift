//
//  AnimationView.swift
//  CatchMe
//
//  Created by Zhang on 13/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit
import pop

class AnimationView: UIView {
}

class AnimationTouchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(self.longPress(longPress:)))
        longPressGestureRecognizer.minimumPressDuration = 0.1
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func longPress(longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            self.scaleToSmall()
        }else if longPress.state == .ended {
            self.viewPress()
            self.scleToDefault()
        }
    }
    
    func scaleToSmall(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 0.90, height: 0.90))
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    @objc func scalAnimation(){
        let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.velocity = NSValue.init(cgSize: CGSize.init(width: 3, height: 3))
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.springBounciness = 18
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    func viewPress(){
        
    }
    
    func scleToDefault(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
}

class AnimationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.scaleToSmall), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(self.scalAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.scleToDefault), for: .touchDragExit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func scaleToSmall(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 0.90, height: 0.90))
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    @objc func scalAnimation(){
        let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.velocity = NSValue.init(cgSize: CGSize.init(width: 3, height: 3))
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        scaleAnimation?.springBounciness = 18
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    @objc func scleToDefault(){
        let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation?.toValue = NSValue.init(cgSize: CGSize.init(width: 1, height: 1))
        self.layer.pop_add(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
}
