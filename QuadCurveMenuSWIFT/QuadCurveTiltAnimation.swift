//
//  QuadCurveTiltAnimation.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

class QuadCurveTiltAnimation: NSObject, QuadCurveAnimation{
    
    var animationName: String
    {
        get
        {
            return "tiltAnimation"
        }
    }
    
    var tiltDirection : CGFloat
    var duration : CGFloat
    var delayBetweenItemAnimation : CGFloat
    
    init(tiltDirection : CGFloat){
        self.tiltDirection = tiltDirection
        self.duration = kQuadCoreDefaultAnimationDuration
        self.delayBetweenItemAnimation = kQuadCoreDefaultDelayBetweenItemAnimation
        super.init()
    }
    
    static func initWithClockwiseTilt() -> QuadCurveTiltAnimation
    {
        return QuadCurveTiltAnimation(tiltDirection: CGFloat(Double.pi / 4))
    }
    
     static func initWithCounterClockwiseTilt() -> QuadCurveTiltAnimation
    {
        return QuadCurveTiltAnimation(tiltDirection: CGFloat( -(Double.pi / 4) ))
    }
    
    func animationForItem(item : QuadCurveMenuItem) -> CAAnimationGroup{
        
        let rotateAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.fromValue = item.layer.presentation()?.value(forKeyPath: "transform.rotation.z")
        rotateAnimation.toValue = NSNumber(value: Float(self.tiltDirection))
        rotateAnimation.duration = CFTimeInterval(self.duration)
        rotateAnimation.fillMode = kCAFillModeForwards
        let animationgroup : CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = NSArray(objects: rotateAnimation) as? [CAAnimation]
        animationgroup.duration = Double(self.duration)
        animationgroup.fillMode = kCAFillModeForwards
        
        item.transform = CGAffineTransform(rotationAngle: self.tiltDirection);
        
        return animationgroup
        
    }
}
