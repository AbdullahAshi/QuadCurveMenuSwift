//
//  QuadCurveDataSourceDelegate.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 16/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

protocol QuadCurveDataSourceDelegate {
    
    func numberOfMenuItems() -> Int
    
    func dataObjectAtIndex(itemIndex : NSInteger) -> AnyObject
}
