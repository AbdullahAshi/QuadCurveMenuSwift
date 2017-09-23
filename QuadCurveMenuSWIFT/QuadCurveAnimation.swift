//
//  QuadCurveAnimation.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

let kQuadCoreDefaultAnimationDuration : CGFloat = 0.5
let kQuadCoreDefaultDelayBetweenItemAnimation : CGFloat = 0.036
let kQuadCurveDefaultBlowUpScale : CGFloat = 9.0
let kQuadCurveDefaultShrinkScale : CGFloat = 0.1
let kQuadCurveDefaultRotation : CGFloat = CGFloat(Double.pi * 2)

protocol QuadCurveAnimation : NSObjectProtocol {
    
    var animationName : String  { get }
    var duration : CGFloat { get set }
    var delayBetweenItemAnimation : CGFloat { get set }
 
    func animationForItem(item : QuadCurveMenuItem) -> CAAnimationGroup
    
}
