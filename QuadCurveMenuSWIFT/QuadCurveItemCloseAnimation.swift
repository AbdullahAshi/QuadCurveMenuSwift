//
//  QuadCurveItemCloseAnimation.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

class QuadCurveItemCloseAnimation: NSObject, QuadCurveAnimation{
    
    var animationName: String
    {
        get
        {
            return "Close"
        }
    }
    
    var rotation : CGFloat
    var duration : CGFloat
    var delayBetweenItemAnimation : CGFloat
    
    override init() {
        self.rotation = kQuadCurveDefaultRotation
        self.duration = kQuadCoreDefaultAnimationDuration
        self.delayBetweenItemAnimation = kQuadCoreDefaultDelayBetweenItemAnimation
        super.init()
    }
    
    func animationForItem(item : QuadCurveMenuItem) -> CAAnimationGroup{
        
        let rotateAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.values = [Float(0.0),
                                         Float(self.rotation),
                                         Float(0.0)]
        rotateAnimation.duration = CFTimeInterval(self.duration)
        rotateAnimation.keyTimes = NSArray(objects: NSNumber(value: 0.0),
            NSNumber(value: 0.4),
            NSNumber(value: 0.5)) as? [NSNumber]
        
        let positionAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.duration = CFTimeInterval(self.duration);
        let path : CGMutablePath = CGMutablePath()
        path.move(to: item.endPoint!)
        path.addLine(to: item.farPoint!)
        path.addLine(to: item.startPoint!)
        positionAnimation.path = path
        
        let animationgroup : CAAnimationGroup = CAAnimationGroup()
        animationgroup.animations = NSArray(objects: positionAnimation, rotateAnimation) as? [CAAnimation]
        animationgroup.duration = Double(self.duration)
        animationgroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        return animationgroup
    }
    
}
