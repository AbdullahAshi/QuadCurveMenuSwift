//
//  AwesomeDataSource.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 16/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

class AwesomeDataSource: NSObject
{
    var dataItems : NSMutableArray = []
    
    override init()
    {
        super.init()
        dataItems = NSMutableArray(array: ["1","2","3","4","5","6","7","8"])
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AwesomeDataSource : QuadCurveDataSourceDelegate
{

    func numberOfMenuItems() -> Int
    {
        return dataItems.count
    }
    
    func dataObjectAtIndex(itemIndex : NSInteger) -> AnyObject
    {
        return dataItems[itemIndex] as AnyObject
    }
}
