//
//  QuadCurveDefaultDataSource.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

class QuadCurveDefaultDataSource
{
    var array : NSArray = []
    
    init(WithArray : NSArray)
    {
        array = WithArray
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuadCurveDefaultDataSource: QuadCurveDataSourceDelegate
{
    func numberOfMenuItems() -> Int
    {
        return array.count
    }
    
    func dataObjectAtIndex(itemIndex : NSInteger) -> AnyObject
    {
        return array[itemIndex] as AnyObject
    }
    
}
