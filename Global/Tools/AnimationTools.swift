
//
//  AnimationTools.swift
//  CatchMe
//
//  Created by Zhang on 07/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

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
    
    func easeInOutAnimation(view:UIView,touchStatus:TouchStatus) {
        if touchStatus == .begin {
            let scale = self.baseAnimationWithKeyPath("transform.scale", fromValue: 1.0, toValue: 0.7, duration: 0.1, repeatCount: 0, timingFunction: nil)
            view.layer.add(scale, forKey: "transformScale")
        }else{
            let scale = self.baseAnimationWithKeyPath("transform.scale", fromValue: 0.5, toValue: 1, duration: 0.1, repeatCount: 0, timingFunction: nil)
            view.layer.add(scale, forKey: "transformScale")
        }
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
    
    
    func baseAnimationWithKeyPath(_ path : String , fromValue : Any? , toValue : Any?, duration : CFTimeInterval, repeatCount : Float? , timingFunction : String?) -> CABasicAnimation{
        
        let animate = CABasicAnimation(keyPath: path)
        //起始值
        animate.fromValue = fromValue;
        
        //变成什么，或者说到哪个值
        animate.toValue = toValue
        
        //所改变属性的起始改变量 比如旋转360°，如果该值设置成为0.5 那么动画就从180°开始
        //        animate.byValue =
        
        //动画结束是否停留在动画结束的位置
        //        animate.isRemovedOnCompletion = false
        
        //动画时长
        animate.duration = duration
        
        //重复次数 Float.infinity 一直重复 OC：HUGE_VALF
        animate.repeatCount = repeatCount ?? 0
        
        //设置动画在该时间内重复
        //        animate.repeatDuration = 5
        
        //延时动画开始时间，使用CACurrentMediaTime() + 秒(s)
        //        animate.beginTime = CACurrentMediaTime() + 2;
        
        //设置动画的速度变化
        /*
         kCAMediaTimingFunctionLinear: String        匀速
         kCAMediaTimingFunctionEaseIn: String        先慢后快
         kCAMediaTimingFunctionEaseOut: String       先快后慢
         kCAMediaTimingFunctionEaseInEaseOut: String 两头慢，中间快
         kCAMediaTimingFunctionDefault: String       默认效果和上面一个效果极为类似，不易区分
         */
        
        animate.timingFunction = CAMediaTimingFunction(name: timingFunction ?? kCAMediaTimingFunctionEaseInEaseOut)
        
//        animate.isRemovedOnCompletion = false
        //动画在开始和结束的时候的动作
        /*
         kCAFillModeForwards    保持在最后一帧，如果想保持在最后一帧，那么isRemovedOnCompletion应该设置为false
         kCAFillModeBackwards   将会立即执行第一帧，无论是否设置了beginTime属性
         kCAFillModeBoth        该值是上面两者的组合状态
         kCAFillModeRemoved     默认状态，会恢复原状
         */
        animate.fillMode = kCAFillModeBoth
        
        //动画结束时，是否执行逆向动画
        //        animate.autoreverses = true
        
        return animate
        
    }
}

