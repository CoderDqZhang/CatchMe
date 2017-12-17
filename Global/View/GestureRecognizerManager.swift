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
    var recognizerLeft:UISwipeGestureRecognizer!
    override init() {
        super.init()
    }
    
    static let shareInstance = GestureRecognizerManager()
    
    func setUpSwipeGestureRecognizerLeft(view:UIView?){
        recognizerLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(self.handleSwipeGesture(sender:)))
        recognizerLeft.delegate = self
        recognizerLeft.direction = .left
        recognizerLeft.numberOfTouchesRequired = 1
        view?.addGestureRecognizer(recognizerLeft)
    }
    
    @objc func handleSwipeGesture(sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            if GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse != nil {
                GestureRecognizerManager.shareInstance.gestureRecognizerManagerClouse(.left)
            }
        }
    }
}

extension GestureRecognizerManager : UIGestureRecognizerDelegate {
    
}
