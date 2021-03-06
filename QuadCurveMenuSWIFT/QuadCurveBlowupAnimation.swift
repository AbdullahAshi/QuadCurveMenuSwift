//
//  QuadCurveBlowupAnimation.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

class QuadCurveBlowupAnimation : NSObject, QuadCurveAnimation{
    
    var animationName: String
    {
        get
        {
            return "blowup"
        }
    }
    
    var blowUpScale : CGFloat
    var duration : CGFloat
    var delayBetweenItemAnimation : CGFloat
    
    override init() {
        self.blowUpScale = kQuadCurveDefaultBlowUpScale
        self.duration = kQuadCoreDefaultAnimationDuration
        self.delayBetweenItemAnimation = kQuadCoreDefaultDelayBetweenItemAnimation
        super.init()
    }
    
    func animationForItem(item : QuadCurveMenuItem) -> CAAnimationGroup{
     
        let point : CGPoint = item.center
        let positionAnimation : CABasicAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = NSValue(cgPoint: point)
        positionAnimation.toValue = NSValue(cgPoint: point)
        
        let scaleAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform")
        scaleAnimation.toValue = NSValue(caTransform3D: CATransform3DMakeScale(self.blowUpScale, self.blowUpScale, 1))
        scaleAnimation.fillMode = kCAFillModeForwards
        
        let opacityAnimation : CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue  = NSNumber(value: 0.0)
        
        let animationgroup : CAAnimationGroup = CAAnimationGroup()
        
        animationgroup.animations = NSArray(objects: positionAnimation, scaleAnimation, opacityAnimation) as? [CAAnimation]
        animationgroup.duration = Double(self.duration)
        
        animationgroup.fillMode = kCAFillModeForwards
        
        return animationgroup
    }
    
}
