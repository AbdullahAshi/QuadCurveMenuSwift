//
//  QuadCurveMenuItemFactory.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

protocol QuadCurveMenuItemFactory : NSObjectProtocol{
    
    func createMenuItemWithDataObject(dataObject : AnyObject?) -> QuadCurveMenuItem
}
