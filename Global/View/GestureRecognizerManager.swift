//
//  GestureRecognizerManager.swift
//  CatchMe
//
//  Created by Zhang on 17/12/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

enum SwipeGestureRecognizerType {
    case left
    case right
    case down
    case up
}

typealias GestureRecognizerManagerClouse = (_ type:SwipeGestureRecognizerType) ->Void
class GestureRecognizerManager: NSObject {

    var gestureRecognizerManagerClouse:GestureRecognizerManagerClouse!
    
    override init() {
        super.init()
    }
    
    static let shareInstance = GestureRecognizerManager()
    
    func setUpSwipeGestureRecognizer(view:UIView?){
        let recognizerLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipeGesture(sender:)))
        recognizerLeft.delegate = self
        recognizerLeft.direction = .left
        recognizerLeft.numberOfTouchesRequired = 1
        view?.addGestureRecognizer(recognizerLeft)
        
        let recognizerRight = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipeGesture(sender:)))
        recognizerRight.delegate = self
        recognizerRight.direction = .right
        recognizerRight.numberOfTouchesRequired = 1
        view?.addGestureRecognizer(recognizerRight)
    }
    
    @objc func handleSwipeGesture(sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse != nil {
                GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse(.left)
            }
        }else if sender.direction == .right {
            if GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse != nil {
                GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse(.right)
            }
        }
    }
}

extension GestureRecognizerManager : UIGestureRecognizerDelegate {
    
}
