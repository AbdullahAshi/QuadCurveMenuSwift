//
//  QuadCurveRadialDirector.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

let kQuadCurveMenuDefaultNearRadius : CGFloat = 110.0
let kQuadCurveMenuDefaultEndRadius : CGFloat = 120.0
let kQuadCurveMenuDefaultFarRadius : CGFloat = 140.0
let kQuadCurveMenuDefaultTimeOffset : CGFloat = 0.036
let kQuadCurveMenuDefaultRotateAngle : CGFloat = 0.0
let kQuadCurveMenuDefaultMenuWholeAngle : CGFloat = CGFloat(Double.pi * 2)

func RotateCGPointAroundCenter(point: CGPoint, center: CGPoint, angle: Float) -> CGPoint{
    
    let translation : CGAffineTransform = CGAffineTransform(translationX: center.x, y: center.y)
    let rotation : CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(angle))
    let transformGroup : CGAffineTransform = translation.inverted().concatenating(rotation).concatenating(translation)
    return point.applying(transformGroup)
}


class QuadCurveRadialDirector : NSObject, QuadCurveMotionDirector
{
    var nearRadius : CGFloat = 0.0
    var endRadius : CGFloat = 0.0
    var farRadius : CGFloat = 0.0
    var rotateAngle : CGFloat = 0.0
    var menuWholeAngle : CGFloat = 0.0
    
    override convenience init() {
        self.init(menuWholeAngle: kQuadCurveMenuDefaultMenuWholeAngle, rotateAngle: kQuadCurveMenuDefaultRotateAngle)
    }
    
    convenience init(menuWholeAngle : CGFloat){
        self.init(menuWholeAngle: menuWholeAngle, rotateAngle: kQuadCurveMenuDefaultRotateAngle)
    }
    
    init(menuWholeAngle : CGFloat, rotateAngle : CGFloat){
        super.init()
        self.nearRadius = kQuadCurveMenuDefaultNearRadius
        self.endRadius = kQuadCurveMenuDefaultEndRadius
        self.farRadius = kQuadCurveMenuDefaultFarRadius
        
        self.rotateAngle = rotateAngle
        self.menuWholeAngle = menuWholeAngle
    }
    
    func positionMenuItem(item : QuadCurveMenuItem, index: Int, count : Int, mainMenuItem : QuadCurveMenuItem ) -> Void{
        let startPoint : CGPoint = mainMenuItem.center
        item.startPoint = startPoint
        
        let itemAngle : Float = Float(index) * Float(self.menuWholeAngle) / Float(count)
        let xCoefficient : CGFloat = CGFloat(sinf(itemAngle))
        let yCoefficient : CGFloat = CGFloat(cosf(itemAngle))
        
        
        let endPoint : CGPoint = CGPoint(x: CGFloat(startPoint.x) + self.endRadius * CGFloat(xCoefficient),
                                         y: startPoint.y - self.endRadius * yCoefficient)
        
        item.endPoint = RotateCGPointAroundCenter(point: endPoint, center: startPoint, angle: Float(self.rotateAngle))
        
        let nearPoint : CGPoint = CGPoint(x: startPoint.x + self.nearRadius * xCoefficient,
                                          y: startPoint.y - self.nearRadius * yCoefficient)
        
        item.nearPoint = RotateCGPointAroundCenter(point: nearPoint,
                                                   center: startPoint,
                                                   angle: Float(self.rotateAngle))
        
        let farPoint : CGPoint = CGPoint(x: startPoint.x + self.farRadius * xCoefficient,
                                         y: startPoint.y - self.farRadius * yCoefficient)
        
        item.farPoint = RotateCGPointAroundCenter(point: farPoint,
                                                  center: startPoint,
                                                  angle: Float(self.rotateAngle))
    }
    
}
