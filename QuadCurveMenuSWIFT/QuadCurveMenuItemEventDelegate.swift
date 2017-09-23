//
//  QuadCurveMenuItemEventDelegate.swift
//  QuadCurveMenuSWIFT
//
//  Created by Abdullah Al-Ashi on 17/Sep/17.
//  Copyright © 2017 Abdullah Al-Ashi. All rights reserved.
//

import Foundation

@objc protocol QuadCurveMenuItemEventDelegate : NSObjectProtocol
{
    func quadCurveMenuItemLongPressed(item : QuadCurveMenuItem) -> Void
    
    func quadCurveMenuItemTapped(item : QuadCurveMenuItem) -> Void
    
}
