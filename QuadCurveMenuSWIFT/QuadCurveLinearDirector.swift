//
//  QuadCurveLinearDirector.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation
import UIKit

let kQuadCurveDefaultPadding : CGFloat = 10.0

class QuadCurveLinearDirector : NSObject, QuadCurveMotionDirector
{
    var angle : CGFloat = 0.0
    var padding : CGFloat = 0.0
    
    init(angle : CGFloat, padding : CGFloat){
        super.init()
        
        self.angle = angle
        self.padding = padding
    }
    
    override convenience init() {
        self.init(angle: 0.0, padding: kQuadCurveDefaultPadding)
    }
    
    func positionMenuItem(item : QuadCurveMenuItem, index: Int, count : Int, mainMenuItem : QuadCurveMenuItem ) -> Void{
        
        let startPoint : CGPoint = mainMenuItem.center
        
        item.startPoint = startPoint
        
        let itemSize : CGSize = item.frame.size
        
        let xCoefficient : CGFloat = CGFloat( cosf( Float(self.angle) ) )
        let yCoefficient : CGFloat = CGFloat( sinf( Float(self.angle) ) )
        
        let endRadiusX : CGFloat = ( CGFloat(itemSize.width) + CGFloat(self.padding) ) * ( CGFloat(index) + CGFloat(1.0) )
        let endRadiusY : CGFloat = ( CGFloat(itemSize.width) + CGFloat(self.padding) ) * ( CGFloat(index) + CGFloat(1.0) )
        
        let endPoint : CGPoint = CGPoint(x: startPoint.x + endRadiusX * xCoefficient,
                                         y: startPoint.y - endRadiusY * yCoefficient)
        
        item.endPoint = endPoint;
        
        let nearPoint : CGPoint = CGPoint(x: startPoint.x + (endRadiusX - 10) * xCoefficient,
                                          y: startPoint.y - (endRadiusY - 10) * yCoefficient)
        
        item.nearPoint = nearPoint
        
        let farPoint : CGPoint = CGPoint(x: startPoint.x + (endRadiusX + 10) * xCoefficient,
                                         y: startPoint.y - (endRadiusY + 10) * yCoefficient)
        
        item.farPoint = farPoint
    }
}
